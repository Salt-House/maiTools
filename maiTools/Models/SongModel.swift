//
//  SongModel.swift
//  maiTools
//
//  Created by 马硕 on 2025/4/18.
//

import Foundation

// 歌曲数据模型
struct Song: Codable, Identifiable {
    let id: Int
    let title: String
    let artist: String
    let genre: String
    let bpm: Int
    let map: String
    let version: Int
    let rights: String?
    let aliases: [String]
    let disabled: Bool
    let difficulties: Difficulties
}

// 难度信息
struct Difficulties: Codable {
    let standard: [DifficultyInfo]
    let dx: [DifficultyInfo]
    let utage: [DifficultyInfo]
}

// 难度信息详细
struct DifficultyInfo: Codable {
    let type: ChartType
    let level: String
    let levelValue: Int
    let levelIndex: Int
    let noteDesigner: String
    let version: Int
    let tapNum: Int
    let holdNum: Int
    let slideNum: Int
    let touchNum: Int
    let breakNum: Int
    let curve: RateCurve?
    let kanji: String?
    let description: String?
    let isBuddy: Bool?
    
    enum CodingKeys: String, CodingKey {
        case type
        case level
        case levelValue = "level_value"
        case levelIndex = "level_index"
        case noteDesigner = "note_designer"
        case version
        case tapNum = "tap_num"
        case holdNum = "hold_num"
        case slideNum = "slide_num"
        case touchNum = "touch_num"
        case breakNum = "break_num"
        case curve
        case kanji
        case description
        case isBuddy = "is_buddy"
    }
}

// 谱面类型枚举
enum ChartType: String, Codable {
    case standard = "standard"
    case dx = "dx"
    case utage = "utage"
}

// 难度成绩分布曲线
struct RateCurve: Codable {
    let sampleSize: Int
    let fitLevelValue: Double
    let avgAchievements: Double
    let stdevAchievements: Double
    let avgDxScore: Double
    let rateSampleSize: [String: Int]
    let fcSampleSize: [String: Int]
    
    enum CodingKeys: String, CodingKey {
        case sampleSize = "sample_size"
        case fitLevelValue = "fit_level_value"
        case avgAchievements = "avg_achievements"
        case stdevAchievements = "stdev_achievements"
        case avgDxScore = "avg_dx_score"
        case rateSampleSize = "rate_sample_size"
        case fcSampleSize = "fc_sample_size"
    }
}

// 歌曲分数信息
struct SongScore: Codable, Identifiable {
    let id: String
    let songName: String
    let level: String
    let levelIndex: Int
    let achievements: Double
    let fc: Int
    let fs: Int
    let dxScore: Int
    let dxRating: Double
    let rate: Int
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case songName = "song_name"
        case level
        case levelIndex = "level_index"
        case achievements
        case fc
        case fs
        case dxScore = "dx_score"
        case dxRating = "dx_rating"
        case rate
        case type
    }
}

// 难度颜色辅助函数
struct DifficultyColorHelper {
    static func getDifficultyColor(difficulty: Int) -> String {
        let colors = [
            0: "#1eb300",
            1: "#e1d030",
            2: "#ff1744",
            3: "#ab47bc",
            4: "#acaadd",
        ]
        return colors[difficulty] ?? "#1eb300"
    }
}

// 歌曲类型文本转换
struct GenreTextHelper {
    static func transferText(genre: String) -> String {
        let texts = [
            "POPSアニメ": "流行&动漫",
            "niconicoボーカロイド": "niconico & VOCALOID",
            "東方Project": "东方Project",
            "ゲームバラエティ": "其他游戏",
            "maimai": "舞萌",
            "オンゲキCHUNITHM": "音击/中二节奏",
            "utage": "宴会场",
        ]
        return texts[genre] ?? genre
    }
}

// 歌曲版本文本转换
struct VersionTextHelper {
    static func transferVersion(version: Int) -> String {
        let versions = [
            10000: "maimai",
            11000: "maimai PLUS",
            12000: "maimai GreeN",
            13000: "maimai GreeN PLUS",
            14000: "maimai ORANGE",
            15000: "maimai ORANGE PLUS",
            16000: "maimai PiNK",
            17000: "maimai PiNK PLUS",
            18000: "maimai MURASAKi",
            19000: "maimai MURASAKi PLUS",
            19900: "maimai FiNALE",
            20000: "舞萌DX",
            21000: "舞萌DX 2021",
            22000: "舞萌DX 2022",
            23000: "舞萌DX 2023",
            24000: "舞萌DX 2024",
        ]
        
        if let versionText = versions[version] {
            return versionText
        } else {
            let baseVersion = (version / 100) * 100
            return versions[baseVersion] ?? "Unknown"
        }
    }
}

// 歌曲类型对应颜色
struct GenreColorHelper {
    static func getGenreColor(genre: String) -> (bg: String, border: String) {
        let colors: [String: (bg: String, border: String)] = [
            "POPSアニメ": (bg: "rgb(255,200,0)", border: "#b38c00"),
            "流行&动漫": (bg: "rgb(255,200,0)", border: "#b38c00"),
            "niconicoボーカロイド": (bg: "rgb(69,197,255)", border: "rgb(0,108,196)"),
            "niconico & VOCALOID": (bg: "rgb(69,197,255)", border: "rgb(0,108,196)"),
            "東方Project": (bg: "rgb(159,54,227)", border: "#7f2bb6"),
            "东方Project": (bg: "rgb(159,54,227)", border: "#7f2bb6"),
            "ゲームバラエティ": (bg: "rgb(122,231,83)", border: "#62b942"),
            "其他游戏": (bg: "rgb(122,231,83)", border: "#62b942"),
            "maimai": (bg: "rgb(255,70,70)", border: "#802323"),
            "舞萌": (bg: "rgb(255,70,70)", border: "#802323"),
            "オンゲキCHUNITHM": (bg: "rgb(48,157,248)", border: "rgb(0,108,196)"),
            "音击&中二节奏": (bg: "rgb(48,157,248)", border: "rgb(0,108,196)"),
            "utage": (bg: "rgb(220,56,184)", border: "rgb(179,46,121)"),
        ]
        
        return colors[genre] ?? (bg: "rgb(255,200,0)", border: "#b38c00")
    }
}

// 难度等级枚举
enum Difficulty: String {
    case basic = "Basic"
    case advanced = "Advanced"
    case expert = "Expert"
    case master = "Master"
    case remaster = "Re:Master"
}

// 类别枚举
enum Category: String {
    case popsAndAnime = "流行&动漫"
    case niconicoAndVocaloid = "niconico&VOCALOID"
    case touhouProject = "东方Project"
    case gameAndVariety = "其他游戏"
    case maimai = "舞萌"
    case ongekiAndChunithm = "音击&中二"
    case utage = "宴会场"
}
