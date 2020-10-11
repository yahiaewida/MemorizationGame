//
//  CardsThemeView.swift
//  MemorizationGame
//
//  Created by Yahia Ewida on 10/11/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import SwiftUI

struct CardsThemeView: View {
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text(viewModel.themeType.rawValue)
                .fontWeight(.semibold)
                .font(.title)
            
            GridView(viewModel.cards){ card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }.padding(5)
            }.padding()
        }        
    }
}

struct CardsThemeView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(themeType: .Sports)
        game.choose(card: game.cards[0])
        return CardsThemeView(viewModel: game)
    }
}
