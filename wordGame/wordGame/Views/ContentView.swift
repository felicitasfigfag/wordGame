//
//  ContentView.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var mainVM : MainViewModel
    let gameMng: WordGameManager
        
    init(mainVM: MainViewModel, gameMng: WordGameManager){
        self.mainVM = mainVM
        self.gameMng = gameMng
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    AttemptsCounter(vm: mainVM)
                }
                Spacer()
            }
            MainBody(vm: mainVM)
            
            VStack {
                Spacer()
                Buttons(vm: mainVM)
            }
        }
        .padding(20)
        .alert(isPresented: $mainVM.showError) {
            Alert(title: Text("Error"), message: Text(mainVM.errorMessage), dismissButton: .default(Text("Ok")))
        }
        .alert(item: $mainVM.endGameAlert) { alert in
            Alert(title: Text(alert.title), message: Text(alert.message),
                  dismissButton: .destructive(Text(alert.buttonText), action: {
                      alert.action?()
                      exit(0) 
            }))
        }
        .onAppear {
            mainVM.startTimer()
        }
    }
}




struct AttemptsCounter: View {
    var vm : MainViewModel
    var correctAttempts: String
    var wrongAttempts: String
    
    init(vm: MainViewModel){
        self.vm = vm
        self.correctAttempts = vm.correctAttempts.formatted()
        self.wrongAttempts = vm.wrongAttempts.formatted()
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Text("Correct attempts: ")
                Text("\(vm.correctAttempts)")
            }
            HStack {
                Text("Wrong attempts: ")
                Text("\(vm.wrongAttempts)")
            }
        }
        .padding()
    }
}


struct MainBody: View {
    var vm : MainViewModel
    var originalWord: String
    var translatedWord: String
    
    init(vm: MainViewModel){
        self.vm = vm
        self.originalWord = vm.originalWord
        self.translatedWord = vm.translatedWord
    }
    
    var body: some View {
        VStack (alignment: .center){
            Text(self.translatedWord)
                .font(.title)
                .padding(.bottom, 20)
            Text(self.originalWord)
                .font(.title2)
        }
        .padding()
    }
}

struct Buttons: View {
    var vm : MainViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button("Correct"){
                ///True represents Correct and False represents Wrong
                vm.handleUserSelection(selection: true)
            }
            .font(.title)
            .buttonStyle(.bordered)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(5)
            .frame(width: 150, height: 70)
            
            Button("Wrong"){
                vm.handleUserSelection(selection: false)
            }
            .font(.title)
            .buttonStyle(.bordered)
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(5)
            .frame(width: 150, height: 70)
        }
        .padding()
    }
}




