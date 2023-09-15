//
//  ContentView.swift
//  ValorantShopFileManagerTestProject
//
//  Created by 김건우 on 2023/09/15.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - WRAPPER PROPERTIES
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var isPresentDownloadsView: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            Button("스킨 데이터 다운로드") {
                Task {
                    await viewModel.downloadsSkin()
                }
                isPresentDownloadsView = true
            }
            .buttonStyle(.borderedProminent)
        }
        .sheet(isPresented: $isPresentDownloadsView) {
            DownloadsView()
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
