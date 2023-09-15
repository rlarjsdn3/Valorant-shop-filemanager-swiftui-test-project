//
//  DownloadsView.swift
//  ValorantShopFileManagerTestProject
//
//  Created by 김건우 on 2023/09/15.
//

import SwiftUI

struct DownloadsView: View {
    
    // MARK: - WRPPAER PROPERTIES
    
    @EnvironmentObject var viewModel: ViewModel
    
    @State private var progressValue: Float = 0.0
    
    // MARK: - BODY
    
    var body: some View {
        VStack {
            let progressValue = Float(viewModel.downloadedImageCount) / Float(viewModel.totalImageDownloadCount)
            ProgressView(value: progressValue)
                .padding()
                .progressViewStyle(.linear)
            
            Text("로딩: \(viewModel.totalImageDownloadCount) / \(viewModel.downloadedImageCount) - \(progressValue * 100.0)%")
            
            Button("스킨 이미지 다운로드") {
                Task {
                    await viewModel.downloadsImage()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct DownloadsView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadsView()
            .environmentObject(ViewModel())
    }
}
