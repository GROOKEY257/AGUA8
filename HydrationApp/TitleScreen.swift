//
//  TitleScreen.swift
//  HydrationApp
//
//  Created by Rohan on 8/26/23.
//

import SwiftUI

struct TitleScreen: View {
    var body: some View {
        NavigationView {
            NavigationLink() {
                ContentView()
            } label: {
                ZStack {
                    Image("AQUA8NotStolen")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .ignoresSafeArea()
                    VStack {
                        Image("AQUA8High")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 400)
                        Spacer()
                    }
                }
                
            }
        }
    }
}

struct TitleScreen_Previews: PreviewProvider {
    static var previews: some View {
        TitleScreen()
    }
}
