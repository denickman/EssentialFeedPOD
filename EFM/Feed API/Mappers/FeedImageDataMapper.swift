//
//  FeedImageDataMapper.swift
//  EFM
//
//  Created by Denis Yaremenko on 30.03.2025.
//

import Foundation

public final class FeedImageDataMapper {
    
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, response: HTTPURLResponse) throws -> Data {
        guard response.isOK, !data.isEmpty else {
            throw Error.invalidData
        }
        return data
    }
}
