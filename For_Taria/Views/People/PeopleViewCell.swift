//
//  PersonView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PeopleViewCell: View {
    let person: Person
    
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
            Text(person.name)
                .font(.title)
                .bold()
        }
        .background(.black)
        .foregroundColor(.yellow)
        .frame(height: 100.00)
    }
}


struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleViewCell(person: SwapiFormattingData.person)
    }
}
