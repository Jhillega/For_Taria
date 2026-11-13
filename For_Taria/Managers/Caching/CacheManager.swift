//
//  CacheManager.swift
//  For_Taria
//
//  Created by Jason Hillegass on 11/24/24.
//

import Foundation

final class SwapiCache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    private let dateProvider: () -> Date
    private let entryLifetime: TimeInterval
    private let keyTracker = KeyTracker()
    // Set by `init(persistedAs:)`; writes the cache to disk after every mutation.
    private var persist: (() -> Void)?
    
    init(dateProvider: @escaping () -> Date = Date.init, entryLifetime: TimeInterval = 12 * 60 * 60, maximumEntryCount: Int = 50) {
        self.dateProvider = dateProvider
        self.entryLifetime = entryLifetime
        wrapped.countLimit = maximumEntryCount
        wrapped.delegate = keyTracker
    }
    
    func insert(_ value: Value, forKey key: Key) {
        let date = dateProvider().addingTimeInterval(entryLifetime)
        let entry = Entry(key: key, value: value, expirationDate: date)
        wrapped.setObject(entry, forKey: WrappedKey(key: key))
        keyTracker.keys.insert(key)
        persist?()
    }
    
    func value(forKey key: Key) -> Value? {
        
        guard let entry = wrapped.object(forKey: WrappedKey(key: key)) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            // discard expired values
            removeValue(forKey: key)
            return nil
        }
        
        return entry.value
    }
    
    func removeValue(forKey key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key: key))
        persist?()
    }
}

private extension SwapiCache {
    final class WrappedKey: NSObject {
        let key: Key
        
        init(key: Key) {
            self.key = key
        }
        
        override var hash: Int {
            return key.hashValue
        }
        
        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }
            
            return value.key == key
        }
    }
}

private extension SwapiCache {
    final class Entry {
        let key: Key
        let value: Value
        let expirationDate: Date
        
        init(key: Key, value: Value, expirationDate: Date) {
            self.key = key
            self.value = value
            self.expirationDate = expirationDate
        }
    }
}

private extension SwapiCache {
    final class KeyTracker: NSObject, NSCacheDelegate {
        var keys = Set<Key>()
        
        func cache(_ cache: NSCache<AnyObject, AnyObject>, willEvictObject object: Any) {
            
            guard let entry = object as? Entry else {
                return
            }
            
            keys.remove(entry.key)
        }
    }
}

extension SwapiCache {
    subscript(key: Key) -> Value? {
        get {
            return value(forKey: key)
        }
        set {
            guard let value = newValue else {
                removeValue(forKey: key)
                return
            }
            
            insert(value, forKey: key)
        }
    }
}

extension SwapiCache.Entry: Codable where Key: Codable, Value: Codable {
    private enum CodingKeys: String, CodingKey {
        case key, value, expirationDate
    }
    
    // Explicit because Decodable can't be synthesized for a class in an extension.
    convenience init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(key: try container.decode(Key.self, forKey: .key),
                  value: try container.decode(Value.self, forKey: .value),
                  expirationDate: try container.decode(Date.self, forKey: .expirationDate))
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
        try container.encode(value, forKey: .value)
        try container.encode(expirationDate, forKey: .expirationDate)
    }
}

private extension SwapiCache {
    func entry(forKey key: Key) -> Entry? {
        guard let entry = wrapped.object(forKey: WrappedKey(key: key)) else {
            return nil
        }
        
        guard dateProvider() < entry.expirationDate else {
            removeValue(forKey: key)
            return nil
        }
        
        return entry
    }
    
    func insert(_ entry: Entry) {
        wrapped.setObject(entry, forKey: WrappedKey(key: entry.key))
        keyTracker.keys.insert(entry.key)
    }
}

extension SwapiCache: Codable where Key: Codable, Value: Codable {
    convenience init(from decoder: any Decoder) throws {
        self.init()
        
        let container = try decoder.singleValueContainer()
        let entries = try container.decode([Entry].self)
        entries.forEach(insert)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(keyTracker.keys.compactMap(entry))
    }
    
    // Creates a cache backed by a file in the caches directory. Unexpired entries
    // from a previous launch are restored, and every change is written back to disk.
    convenience init(persistedAs name: String,
                     entryLifetime: TimeInterval = 12 * 60 * 60,
                     maximumEntryCount: Int = 50,
                     fileManager: FileManager = .default) {
        self.init(entryLifetime: entryLifetime, maximumEntryCount: maximumEntryCount)
        
        if let url = Self.fileURL(withName: name, using: fileManager),
           let data = try? Data(contentsOf: url),
           let entries = try? JSONDecoder().decode([Entry].self, from: data) {
            entries.filter { dateProvider() < $0.expirationDate }.forEach(insert)
        }
        
        persist = { [weak self] in
            try? self?.saveToDisk(withName: name, using: fileManager)
        }
    }
    
    private static func fileURL(withName name: String, using fileManager: FileManager) -> URL? {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first?
            .appendingPathComponent(name + ".cache")
    }
    
    func saveToDisk(withName name: String,
                    using fileManager: FileManager = .default) throws {
        guard let fileURL = Self.fileURL(withName: name, using: fileManager) else { return }
        let data = try JSONEncoder().encode(keyTracker.keys.compactMap(entry))
        try data.write(to: fileURL, options: .atomic)
    }
}
