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
                }.font(Font.system(size: fontSize, weight: .semibold, design: .default))
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
                            .background(Color.red.opacity(opacity))
                            .cornerRadius(cornerRadius)
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
    
    // MARK:- Constants
    private let fontSize : CGFloat = 28
    private let cornerRadius : CGFloat = 40
    private let opacity : Double = 0.7
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        return HomeView()
    }
}
