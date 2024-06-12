//
//  TestApp.swift
//  Test
//
//  Created by Ilia Loviagin on 6/12/24.
//

import SwiftUI

@main
struct TestApp: App {
    @StateObject private var homeViewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homeViewModel)
        }
    }
}
