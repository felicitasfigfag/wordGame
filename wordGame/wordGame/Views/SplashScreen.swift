//
//  SplashScreen.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import Foundation
import SwiftUI

struct SplashScreen: View {
    @ObservedObject var appState: AppState

    var body: some View {
            VStack {
                Image("Babbel_Logo")
                    .resizable()
                    .padding(.horizontal, 20)
                    .scaledToFit()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            appState.showingSplash = false
                        }
                    }
            }
        }
    }
