//
//  ContentView.swift
//  MemorizationGame
//
//  Created by Yahya Ewida on 9/2/20.
//  Copyright © 2020 Yahya Ewida. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                NavigationView() {
                    List {
                        self.setupThemeSectionView(for: .Haloween, withEmoji: "🎃", andText: "Haloween", andColor: Color.orange)
                        self.setupThemeSectionView(for: .Sports, withEmoji: "⚽️", andText: "Sports", andColor: Color.green)
                        self.setupThemeSectionView(for: .Food, withEmoji: "🍕", andText: "Food", andColor: Color.blue)
                        self.setupButtonSectionView()
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Game Themes")
                }
                
            }
        }
    }
    
    private func setupThemeSectionView(for themeType : ThemeType, withEmoji emoji : String, andText text : String, andColor color : Color ) -> some View {
        Section {
            NavigationLink(destination: CardsThemeView(viewModel: EmojiMemoryGame(themeType: themeType))) {
                HStack {
                    Text(emoji)
                    Text(text)
                }.font(Font.system(size: 28, weight: .semibold, design: .default))
                    .foregroundColor(color)
            }
        }
    }
    
    private func setupButtonSectionView() -> some View {
        Section {
            HStack {
                Spacer()
                NavigationLink(destination: CardsThemeView(viewModel: EmojiMemoryGame(themeType: selectRandomTheme()))) {
                    Button(action: {
                        print("Button tapped!")
                    }) {
                        Text("Start With Random Theme")
                            .fontWeight(.semibold)
                            .font(.headline)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.red.opacity(0.7))
                            .cornerRadius(40)
                    }
                }
                Spacer()
            }
        }
    }
    
    private func selectRandomTheme() -> ThemeType {
        let randomNumber = Int.random(in: 0...2)
        return ThemeType.getThemeByIndex(index : randomNumber)
    }
}

struct CardView : View{
    var card : MemoryGame<String>.Card
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    //View Builder would draw if the condition is true, otherwise would draw nothing
    @ViewBuilder
    private func body(for size: CGSize) -> some View{
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(110-90), clockwise: true).padding(5).opacity(0.4)
                Text(self.card.content)
            }.font(Font.system(size: min(size.width, size.height) * fontScaleFactor))
                .foregroundColor(Color.orange)
                .cardify(isFaceUp: self.card.isFaceUp)
        }
    }
    
    // MARK:- Constants
    private let fontScaleFactor : CGFloat = 0.7
    private let aspectRatio : CGFloat = 2/3
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return HomeView()
    }
}
