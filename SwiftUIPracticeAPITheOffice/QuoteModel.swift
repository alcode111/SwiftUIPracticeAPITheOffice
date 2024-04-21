//
//  QuoteModel.swift
//  SwiftUIPracticeAPITheOffice
//
//  Created by Ismaïl LP on 21/04/2024.
//

import Foundation

struct Quote: Decodable {
    let id: Int
    let character: String
    let quote: String
    let characterAvatarUrl: URL
}
