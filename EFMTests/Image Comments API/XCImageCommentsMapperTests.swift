//
//  XCImageCommentsMapperTests.swift
//  EFMTests
//
//  Created by Denis Yaremenko on 16.03.2025.
//

import XCTest
import EFM

final class XCImageCommentsMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon2xxHTTPResponse() throws {
       
        let samples = [199, 150, 300, 400, 500]
        let data = makeItemsJSON([])
        
        try samples.forEach { code in
            let response = HTTPURLResponse(statusCode: code)
            XCTAssertThrowsError(try ImageCommentsMapper.map(data, response: response))
        }
    }
    
    func test_map_throwsErrorOn2xxHTTPResponseWithInvalidData() throws {
        let samples = [200, 201, 250, 280, 299]
        let invalidData = Data("invalid_json".utf8)
        
        try samples.forEach { code in
            let response = HTTPURLResponse(statusCode: code)
            XCTAssertThrowsError(try ImageCommentsMapper.map(invalidData, response: response))
        }
    }
    
    func test_map_deliversNoItemsOn2xxHTTPResponseWithEmptyData() throws {
        let emtpyData = makeItemsJSON([])
        let samples = [200, 201, 250, 280, 299]
        
        try samples.forEach { code in
            let response = HTTPURLResponse(statusCode: code)
            let result = try ImageCommentsMapper.map(emtpyData, response: response)
            XCTAssertEqual(result, [])
        }
    }
    
    func test_map_devliersItemsOn2xxHTTPResponseWithJSONItems() throws {
        let item1 = makeItem(
                    id: UUID(),
                    message: "a message",
                    createdAt: (Date(timeIntervalSince1970: 1598627222), "2020-08-28T15:07:02+00:00"),
                    username: "a username")
        
        let item2 = makeItem(
                     id: UUID(),
                     message: "another message",
                     createdAt: (Date(timeIntervalSince1970: 1577881882), "2020-01-01T12:31:22+00:00"),
                     username: "another username")
                
        let samples = [200, 201, 250, 280, 299]
        
        let jsonData = makeItemsJSON([item1.json, item2.json])
        
        try samples.forEach { code in
            let response = HTTPURLResponse(statusCode: code)
            let result = try ImageCommentsMapper.map(jsonData, response: response)
            XCTAssertEqual(result, [item1.model, item2.model])
        }
    }
    
    // MARK: - Helpers

    private func makeItem(
        id: UUID,
        message: String,
        createdAt: (date: Date, iso8601String: String),
        username: String
    ) -> (model: ImageComment, json: [String : Any]) {
        
        let item = ImageComment(id: id, message: message, createdAt: createdAt.date, username: username)
        
        let json: [String: Any] = [
            "id" : id.uuidString,
            "message" : message,
            "created_at" : createdAt.iso8601String,
            "author" : [
                "username" : username
            ]
        ]
        
        return (item, json)
    }

}
