//
//  WeponSkin.swift
//  ValorantShopFileManagerTestProject
//
//  Created by 김건우 on 2023/09/15.
//

import Foundation

struct WeaponSkins: Codable {
    let status: Int
    let data: [Skin]
}

struct Skin: Codable {
    let uuid: String
    let displayName: String
    let contentTierUUID: ContentTier?
    let chromas: [Chroma]
    let levels: [Level]
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case displayName
        case contentTierUUID = "contentTierUuid"
        case chromas, levels
    }
}

enum ContentTier: String, Codable {
    case selectEdition = "12683d76-48d7-84a3-4e09-6985794f0445"
    case deulxeEdition = "0cebb8be-46d7-c12a-d306-e9907bfc5a25"
    case primeumEdition = "60bca009-4182-7998-dee7-b8a2558dc369"
    case exclusiveEdition = "e046854e-406c-37f4-6607-19a9ba8426fc"
    case ultraEdition = "411e4a55-4e59-7757-41f0-86a53f101bb5"
}

struct Chroma: Codable {
    let uuid: String
    let displayIcon: String?
    let swatch: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case displayIcon
        case swatch
    }
}

struct Level: Codable {
    let uuid: String
    let levelItem: LevelItem?
    let streamedVideo: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case levelItem
        case streamedVideo
    }
}

enum LevelItem: String, Codable {
    case animation = "EEquippableSkinLevelItem::Animation"
    case attackerDefenderSwap = "EEquippableSkinLevelItem::AttackerDefenderSwap"
    case finisher = "EEquippableSkinLevelItem::Finisher"
    case fishAnimation = "EEquippableSkinLevelItem::FishAnimation"
    case heartBeatAndMapSensor = "EEquippableSkinLevelItem::HeartbeatAndMapSensor"
    case inspectAndKill = "EEquippableSkinLevelItem::InspectAndKill"
    case killBanner = "EEquippableSkinLevelItem::KillBanner"
    case killCounter = "EEquippableSkinLevelItem::KillCounter"
    case killEffect = "EEquippableSkinLevelItem::KillEffect"
    case randomizer = "EEquippableSkinLevelItem::Randomizer"
    case soundEffects = "EEquippableSkinLevelItem::SoundEffects"
    case topFrag = "EEquippableSkinLevelItem::TopFrag"
    case transformation = "EEquippableSkinLevelItem::Transformation"
    case vfx = "EEquippableSkinLevelItem::VFX"
    case voiceover = "EEquippableSkinLevelItem::Voiceover"
}
