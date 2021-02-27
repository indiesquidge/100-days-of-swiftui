//
//  ContentView.swift
//  SteinSaksPapir
//
//  Created by austin_wood on 2/27/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var score = 0

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""

    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.white, Color.orange]),
                center: .topTrailing,
                startRadius: 50,
                endRadius: 900)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of…")
                        .font(.title)
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: .orange, radius: 10, x: 5, y: 8)
                    }
                }

                HStack {
                    Text("Score:")
                    Text("\(score)")
                        .fontWeight(.bold)
                }

                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text(scoreMessage),
                  dismissButton: .default(Text("Continue")) {
                    self.askQuestion()
                  })
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score += 1
            scoreMessage = "Your score is: \(score)"
        } else {
            scoreTitle = "Wrong!"
            score = max(score - 1, 0)
            scoreMessage = "That's the flag of \(countries[number])"
        }

        showingScore = true
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
