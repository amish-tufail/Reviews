//
//  ContentView.swift
//  Reviews
//
//  Created by Amish Tufail on 26/01/2023.
//

import SwiftUI
import StoreKit // For Review

struct ContentView: View {
    @AppStorage("counter") var counter = 0
    @AppStorage("versionAsked") var versionAsked = ""
    var currentVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "" // We are getting the current version through this
    var body: some View {
        ZStack {
            Color.orange.opacity(0.2).ignoresSafeArea()
            VStack {
                Button {
                    // If the user taps on it more than 3 or more times, they are considered best users and we will display the review screen.
                    counter += 1
                    if counter >= 3 {
                        // 1. First We get the scene/window user looking at
                        let scene = UIApplication.shared.connectedScenes.first { scene in
                            scene.activationState == .foregroundActive
                        }
                        // 2. Now we check if it is not nil and then display the review
                        if let scene = scene {
                            print("Current: \(currentVersion)")
                            print("Asked: \(versionAsked)")
                            if currentVersion != versionAsked {
                                SKStoreReviewController.requestReview(in: scene as! UIWindowScene)
                                versionAsked = currentVersion
                            }
                        }
                    }
                } label: {
                    Text("Tap Me")
                }
                .foregroundColor(.orange)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                        .stroke(.black, lineWidth: 2.0)
                )
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
