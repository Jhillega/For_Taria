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
            VStack {
                List(0 ..< results.count, id: \.self) { item in
                    Text(results[item].name)
                }
            }
            .foregroundStyle(.yellow)
        }
    }
}

struct peopleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultsView(results: SwapiFormattingData.results)
    }
}
