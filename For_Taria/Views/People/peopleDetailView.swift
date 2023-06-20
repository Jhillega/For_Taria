//
//  peopleDetailView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/15/23.
//

import SwiftUI

struct peopleDetailView: View {
    let person: Person
    
    var body: some View {
        VStack {
            Text(person.name)
            Text(person.birthYear)
            Text(person.gender.rawValue.localizedCapitalized)
        }
    }
}

struct peopleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        peopleDetailView(person: SwapiFormattingData.person)
    }
}
