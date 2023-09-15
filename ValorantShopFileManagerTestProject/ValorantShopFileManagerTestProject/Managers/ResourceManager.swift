//
//  ResourceManager.swift
//  ValorantShopFileManagerTestProject
//
//  Created by 김건우 on 2023/09/15.
//

import Foundation

final class ResourceManager {
    
    // MARK: - SINGLETON
    static let shared = ResourceManager()
    private init() { }
    
    // MARK: - PROPERTIES
    
    let urlSession: URLSession = URLSession.shared
    
    // MARK: - FUNCTIONS
    
    func fetchWeaponSkins() async -> WeaponSkins? {
        // For Debug
        print(#function)
        
        // URL 만들기
        var urlComponent = URLComponents(string: "https://valorant-api.com/v1/weapons/skins/")
        urlComponent?.queryItems = [URLQueryItem(name: "language", value: "ko-KR")]
        guard let url = urlComponent?.url else { return nil }
        // URL Request 만들기
        var urlReqeust = URLRequest(url: url)
        urlReqeust.httpMethod = "GET"
        
        // 비동기 HTTP 통신하기
        let (data, response) = try! await urlSession.data(for: urlReqeust)
        // 상태 코드가 올바른지 확인하기
        guard let httpResponse = (response as? HTTPURLResponse),
              (200..<300) ~= httpResponse.statusCode else {
            print("상태 코드 에러")
            return nil
        }
        // 받아온 데이터를 디코드하기
        guard let weaponSkins = try? JSONDecoder().decode(WeaponSkins.self, from: data) else {
            print("파싱 에러")
            return nil
        }
        
        // 결과 반환하기
        return weaponSkins
    }
    
    func fetchImageData(_ uuid: String) async -> Data? {
        // For Debug
        print(#function)
        
        // URL 만들기
        guard let url = URL(string: "https://media.valorant-api.com/weaponskins/\(uuid)/displayicon.png") else { return nil }
        // URL Request 만들기
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // 비동기 HTTP 통신하기
        let (data, response) = try! await urlSession.data(for: urlRequest)
        // 상태 코드가 올바른지 확인하기
        guard let httpResponse = (response as? HTTPURLResponse),
              (200..<300) ~= httpResponse.statusCode else {
            print("상태 코드 에러 - \(uuid)")
            return nil
        }
        
        // 값 반환하기
        return data
    }
}
