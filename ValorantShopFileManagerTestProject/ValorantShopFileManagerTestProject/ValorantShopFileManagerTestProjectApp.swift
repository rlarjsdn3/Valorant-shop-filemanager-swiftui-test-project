//
//  ValorantShopFileManagerTestProjectApp.swift
//  ValorantShopFileManagerTestProject
//
//  Created by 김건우 on 2023/09/15.
//

import SwiftUI

@main
struct ValorantShopFileManagerTestProjectApp: App {
    
    @StateObject private var viewModel: ViewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
