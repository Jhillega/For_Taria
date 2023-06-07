//
//  CardsTableView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/6/23.
//

import SwiftUI

struct CardsTableView: View {
    var cards: [Card]? = nil
    
    var body: some View {
        NavigationView {
            Text("Hi There")
        }
    }
}

struct CardsTableView_Previews: PreviewProvider {
    static var previews: some View {
        CardsTableView()
    }
}
