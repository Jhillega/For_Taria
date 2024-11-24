//
//  peopleDetailView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/15/23.
//

import SwiftUI

struct SearchResultsView: View {
    let results: [SWAPISearchResultPresentable]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            if results.isEmpty {
                Text("Unable to find what you where looking for.....")
                    .foregroundStyle(.yellow)
            } else {
                VStack {
                    ForEach(0 ..< results.count, id: \.self) { item in
                        Text(results[item].name)
                    }
                    .listStyle(.plain)
                }
                .foregroundStyle(.yellow)
                .listRowInsets(.none)
            }
        }
    }
}

struct peopleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(results: SwapiFormattingData.results)
    }
}
