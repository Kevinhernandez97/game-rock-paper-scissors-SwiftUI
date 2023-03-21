//
//  ContentView.swift
//  03-1-days--game-rock-paper-scissors
//
//  Created by Kevin Hernandez on 19/03/23.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["rock", "paper", "scissors"]
    @State private var numRandom = Int.random(in: 0...2)
    @State private var boolRandom = Bool.random()
    @State private var estadoJuego = ""
    @State private var score = 0
    @State private var numRound = 1
    @State private var gameReset = false
    
    var body: some View {
    ZStack {
        LinearGradient(gradient: Gradient(colors: [
            .white,
            .blue,
            .white
        ]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
        VStack {
            Spacer()
            
            Text("Round \(numRound) of 10")
               .font(.largeTitle.bold())
               .foregroundColor(.black)
            HStack {
                    Image("\(possibleMoves[numRandom])")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipped()
            }
            boolRandom ? Text("Iphone: Win") : Text("Iphone: Lose")
            Spacer()
            HStack {
                Text("\(estadoJuego)")
                Button(action: {
                    resetGame()
                }) {
                    Text("Reset")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(20)
                }
            }
                
            Spacer()
            HStack {
                ForEach(0..<3) { num in
                    Button {
                        if numRound == 10 {
                            gameReset = true
                        } else {
                            updateGameState(num)
                        }
                    } label: {
                        Image("\(possibleMoves[num])")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipped()
                        }
                    }
                }
            Text("Player: \(score)")
            Spacer()
            }
            .alert("El juego termino", isPresented: $gameReset) {
                Button("Restart", action: resetGame)
            } message: {
                Text("Tu score es: \(score)")
                }
        }
    }
    
    func updateGameState(_ selectedNumber: Int) {
        switch (boolRandom, numRandom, selectedNumber) {
        case (_, let random, _) where random == selectedNumber:
            estadoJuego = "Empate"
                numRound += 1
        case (true, 0, 1), (true, 2, 0), (true, 1, 2), (false, 1, 0), (false, 0, 2), (false, 2, 1):
            estadoJuego = "Correcto"
            score += 1
            numRound += 1
        case (false, 0, 1), (false, 2, 0), (false, 1, 2), (true, 1, 0), (true, 0, 2), (true, 2, 1):
            estadoJuego = "Incorrecto"
            score -= 1
            numRound += 1
        default:
            break
        }
        
        numRandom = Int.random(in: 0...2)
        boolRandom.toggle()
    }
    
    func resetGame () {
            estadoJuego = ""
            score = 0
            numRound = 0
    }
}

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
