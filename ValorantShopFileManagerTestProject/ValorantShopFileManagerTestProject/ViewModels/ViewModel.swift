//
//  ViewModels.swift
//  ValorantShopFileManagerTestProject
//
//  Created by 김건우 on 2023/09/15.
//

import SwiftUI
import Foundation

@MainActor
final class ViewModel: ObservableObject {
    
    // MARK: - WRAPPER PROPERTIES
    
    // 실제 프로젝트에서는 Realm에 저장
    @Published var weaponSkins: WeaponSkins?
    
    @Published var totalImageDownloadCount: Int = 0
    @Published var downloadedImageCount: Int = 0
    
    // MARK: - PROPERTIES
    
    let resourceManager = ResourceManager.shared
    
    // MARK: - FUNCTIONS
    
    func downloadsSkin() async {
        guard let weaponSkins = await resourceManager.fetchWeaponSkins() else { return }
        DispatchQueue.main.async {
            self.weaponSkins = weaponSkins
        }
    }
    
    func downloadsImage() async {
        
        // 다운로드 진척도를 나타내는 변수 초기화
        totalImageDownloadCount = 0
        downloadedImageCount = 0
        
        // 다운로드 받은 스킨 데이터가 있는지 확인하기
        guard let weaponSkins = weaponSkins else { return }
        // 아직 다운로드 받지 못한 이미지 UUID를 저장하는 변수
        var notDownloadedImageIDs: [String] = []
        
        // Downloads 폴더에 접근하기 위한 파일매니저 상수
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        // 대표 스킨 이미지가 존재하는지 확인하기
        for skin in weaponSkins.data {
            let imageUUID = skin.uuid
            // 경로 설정하기
            let url = documentDirectory.appending(path: "\(imageUUID).png")
            // 해당 경로에 파일이 존재하는지 확인하기
            if !fileManager.fileExists(atPath: url.path()) {
                notDownloadedImageIDs.append(imageUUID)
            }
        }
        
        DispatchQueue.main.async {
            self.totalImageDownloadCount = notDownloadedImageIDs.count
        }
        
        // 대표 스킨 이미지를 다운로드하기
        for notDownloadedImageID in notDownloadedImageIDs {
            DispatchQueue.main.async {
                // 다운로드 진척도 갱신하기
                self.downloadedImageCount += 1
            }
            // 이미지 데이터 페치하기
            if let imageData = await resourceManager.fetchImageData(notDownloadedImageID) {
                // 경로 설정하기
                let url = documentDirectory.appending(path: "\(notDownloadedImageID).png")
                // 파일 저장하기
                try? imageData.write(to: url)
                
            }
        }
        
    }
    
}
