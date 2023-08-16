//
//  ContentView.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 15/08/2023.
//

import SwiftUI

struct ContentView: View {
    let mainVM : MainViewModel
    let wordVM: WordViewModel
        
    init(mainVM: MainViewModel, wordVM: WordViewModel){
        self.mainVM = mainVM
        self.wordVM = wordVM
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
                Text(self.correctAttempts)
            }
            HStack {
                Text("Wrong attempts: ")
                Text(self.wrongAttempts)
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
                print("Correct")
            }
            .font(.title)
            .buttonStyle(.bordered)
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(5)
            .frame(width: 150, height: 70)
            
            Button("Wrong"){
                print("Wrong")
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






//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(mainVM: MainViewModel(wordVM: WordViewModel(service: WordService())))
//    }
//}
