//
//  CardView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/6/23.
//

import SwiftUI


struct CardView: View {
    let card: Card
    
    var body: some View {
        HStack{
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(height: 100.00)
                .padding()
            VStack {
                Text(card.labelOne)
                    .font(.title)
                Text("Homeworld: " + card.labelTwo)
                    .font(.body)
                Text("Birth Year: " + card.labelThree)
                    .font(.body)
            }
            Spacer()
        }
        .frame(height: 100.00)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(cardType: CardType.person,
                            labelOne: "Jason Thomas",
                            labelTwo: "Earth",
                            labelThree: "1997",
                            image: UIImage(systemName: "person.fill")))
    }
}
