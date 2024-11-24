//
//  SearchView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/13/23.


import SwiftUI

struct SearchView: View {
    @State var searchTerm: String = ""
    @State private var result: [SWAPISearchResultPresentable] = []
    @State private var resultType: SwapiCategoryEndpoints = .people
    @State private var isSearching: Bool = false
    @State var isShowingDetailView = false
    let service = SWAPIService()
    
    init() {
            UINavigationBar.appearance().titleTextAttributes = [
                .foregroundColor: UIColor.systemYellow,
            ]
        }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            if isSearching {
                ProgressView()
            }
            
            VStack {
                if #available(iOS 16.0, *) {
                    TextField("", text: $searchTerm, prompt: Text("Search for a person, place or thing").foregroundColor(.yellow).italic(searchTerm.isEmpty))
                        .padding()
                        .foregroundStyle(.yellow)
                } else {
                    // Fallback on earlier versions
                    if searchTerm.isEmpty {
                        TextField("", text: $searchTerm, prompt: Text("Search for a person, place or thing").foregroundColor(.yellow).italic())
                            .padding()
                            .foregroundStyle(.yellow)
                    } else {
                        TextField("", text: $searchTerm, prompt: Text("Search for a person, place or thing").foregroundColor(.yellow))
                            .padding()
                            .foregroundStyle(.yellow)

                    }
                }
                Button("Search") {
                    Task {
                        await search(query: searchTerm)
                    }
                }
                .padding()
                .foregroundStyle(.yellow)
                .sheet(isPresented: $isShowingDetailView,
                       onDismiss: nil,
                       content: {
                    SearchResultsView(results: result) })
            }
        }
    }
    
    func search(query: String?) async {
        isSearching.toggle()
        
        guard let searchQuery = query else {
            isSearching.toggle()
            // TODO: pop alert when string is empty
            return
        }
        
        result = await service.searchAGalaxyFarFarAway(for: searchQuery, in: resultType) ?? SwapiFormattingData.results
        isSearching.toggle()
        isShowingDetailView = true
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
