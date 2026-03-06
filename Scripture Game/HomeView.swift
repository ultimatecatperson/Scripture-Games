/*
    Created by Random Meow in March 2026
    You may use any code here as long as you give credit
    Thanks
*/

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            HStack {
                GameButton(title: "Physical Flip", destination: { PhysicalFlip() })
            }
            .padding()
            .navigationTitle("Games")
            .navigationSubtitle("Scripture Game")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct GameButton<Destination: View>: View {
    let title: String
    @ViewBuilder let destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            Text(title)
                .padding()
                .font(.largeTitle.bold())
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .background(Color.accent)
                .cornerRadius(30)
                .tint(Color.white)
        }
    }
}

#Preview {
    HomeView()
}
