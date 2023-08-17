//
//  InstructionsView.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import SwiftUI

struct InstructionsView: View {
    @Binding var showInstructions: Bool

    var body: some View {
        ZStack {
            Color("backgroundColor")
                .ignoresSafeArea()
            VStack(spacing: 20) {
                instructionText("How to play", isTitle: true)
                instructionText("An English word pops up with its Spanish pair.")
                instructionText("Choose if it's right or not!")
                instructionText("Be quick! 5 seconds and it counts as a strike")
                instructionText("3 strikes and you are out!")
                instructionText("Pass 15 pairs without 3 strikes to claim victory")

                Button("Let's Go!") {
                    showInstructions = false
                }
                .padding()
                .background(Color("accentColor"))
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding()
        }
    }

    private func instructionText(_ text: String, isTitle: Bool = false) -> some View {
        Text(text)
            .multilineTextAlignment(.center)
            .foregroundColor(.white)
            .font(isTitle ? .largeTitle : .body)
            .padding(isTitle ? .init(top: 0, leading: 16, bottom: 0, trailing: 16) : .init())
    }
}
