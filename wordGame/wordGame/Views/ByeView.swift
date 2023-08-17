//
//  ByeView.swift
//  wordGame
//
//  Created by Felicitas Figueroa Fagalde on 17/08/2023.
//

import Foundation
import SwiftUI

struct ByeView: View {
    var body: some View {
        ZStack {
            Color("backgroundColor")
                .edgesIgnoringSafeArea(.all)
            
            Text("Goodbye!")
                .font(.largeTitle)
                .foregroundColor(Color("accentColor"))
        }
    }
}

struct ByeView_Previews: PreviewProvider {
    static var previews: some View {
        ByeView()
    }
}
