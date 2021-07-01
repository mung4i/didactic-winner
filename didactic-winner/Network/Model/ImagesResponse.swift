//
//  ImagesResponse.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let imagesResponse = try? newJSONDecoder().decode(ImagesResponse.self, from: jsonData)

import Foundation

// MARK: - ImagesResponse
struct ImagesResponse: Codable {
    let collection: Collection
}

// MARK: - Collection
struct Collection: Codable {
    let items: [Item]
    let version: String
    let href: String
    let links: [CollectionLink]
    let metadata: Metadata
}

// MARK: - Item
struct Item: Codable {
    let href: String
    let links: [ItemLink]
    let data: [Datum]
}

extension Item {
    var detail: String {
        guard let data = data.first else { return "nil" }
        return data.photographer == nil ?
            "" : "\(data.photographer ?? "") | \(data.dateCreated.formattedDate)"
    }
    var description: String {
        data.first?.datumDescription ?? ""
    }
    var title: String {
        data.first?.title ?? ""
    }
    var link: String? {
        links.first?.href
    }
}

// MARK: - Datum
struct Datum: Codable {
    let keywords: [String]?
    let mediaType: MediaType
    let nasaID: String
    let dateCreated: String
    let datumDescription: String
    let center: Center
    let title: String
    let photographer, description508, secondaryCreator, location: String?
    let album: [String]?

    enum CodingKeys: String, CodingKey {
        case keywords
        case mediaType = "media_type"
        case nasaID = "nasa_id"
        case dateCreated = "date_created"
        case datumDescription = "description"
        case center, title, photographer
        case description508 = "description_508"
        case secondaryCreator = "secondary_creator"
        case location, album
    }
}

enum Center: String, Codable {
    case arc = "ARC"
    case gsfc = "GSFC"
    case hq = "HQ"
    case jpl = "JPL"
    case jsc = "JSC"
    case ksc = "KSC"
}

enum MediaType: String, Codable {
    case image = "image"
    case video = "video"
}

// MARK: - ItemLink
struct ItemLink: Codable {
    let render: MediaType?
    let rel: Rel
    let href: String
}

enum Rel: String, Codable {
    case captions = "captions"
    case preview = "preview"
}

// MARK: - CollectionLink
struct CollectionLink: Codable {
    let prompt, rel: String
    let href: String
}

// MARK: - Metadata
struct Metadata: Codable {
    let totalHits: Int

    enum CodingKeys: String, CodingKey {
        case totalHits = "total_hits"
    }
}
