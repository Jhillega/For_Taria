//
//  SearchView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/13/23.


import SwiftUI

struct SearchView: View {
    @State var searchTerm: String = ""
    @State var isShowingDetailView = false
    
    var body: some View {
        VStack {
            TextField("who, what, or where ...", text: $searchTerm)
                .padding()
            if !searchTerm.isEmpty {
                Button("Search") {
                    isShowingDetailView = true
                }
                .padding()
                .sheet(isPresented: $isShowingDetailView,
                       onDismiss: nil,
                       content: {peopleDetailView(person: SwapiFormattingData.person)})
            }
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
