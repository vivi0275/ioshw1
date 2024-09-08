//
//  HW1StarterTests.swift
//  HW1StarterTests
//
//  Created by Justin Wong on 9/8/24.
//

import XCTest
@testable import HW1Starter

final class HW1StarterTests: XCTestCase {
    
    private let hw1Questions = HW1Questions()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetFileNames1() {
        let fileNames = [
            "Moonlit_Wonder_42.pdf",
            "Recipe_Cookies_09.docx",
            "Project_X_Specs.xlsx",
            "Holiday_Pictures_2024.zip",
            "Meeting_Notes_Sept.txt",
            "Q3pXs.jpeg",
            "tH2dV.png",
            "Financial_Report_Q2.pptx",
            "Code_Snippets_v3.5.py",
            "Book_Review_The_Art.txt",
            "Music_Playlist_Favorites.m3u",
            "sW3tQ.applescript"
        ]
        
        let ans = ["Q3pXs.jpeg",
                   "tH2dV.png",
                   "sW3tQ.applescript"]
        XCTAssertEqual(hw1Questions.getFileNames(for: fileNames, withCount: 5), ans, "File names do not match reference")
    }
    
    func testGetFileNames2() {
        let fileNames = [
            "Moonlit_Wonder_42.pdf",
            "Recipe_Cookies_09.docx",
            "z.bye",
            "Project_X_Specs.xlsx",
            "Holiday_Pictures_2024.zip",
            "Meeting_Notes_Sept.txt",
            "a.jpeg",
            "tH2dV.png",
            "Financial_Report_Q2.pptx",
            "b.hi",
            "Code_Snippets_v3.5.py",
            "Book_Review_The_Art.txt",
            ".oski",
            "Music_Playlist_Favorites.m3u",
            "c.applescript"
        ]
        
        let ans = ["z.bye",
                   "a.jpeg",
                   "b.hi",
                   "c.applescript"]
        XCTAssertEqual(hw1Questions.getFileNames(for: fileNames, withCount: 1), ans, "File names do not match reference")
    }
    
    func testGetTreasureCoords1() {
        let treasureMap: [[String]] = [
            ["X", "", "c", "A", ""],
            ["", "X", "", "c", "A"],
            ["A", "", "X", "", "c"],
            ["", "A", "", "X", ""],
            ["c", "", "A", "c", "X"]
        ]
        let treasureSymbols = ["X", "c", "A"]
        let ans = [(0, 0), (0, 2), (0, 3), (1, 1), (1, 3), (1, 4), (2, 0), (2, 2), (2, 4), (3, 1), (3, 3), (4, 0), (4, 2), (4, 3), (4, 4)]
        let coords = hw1Questions.getTreasureCoords(fromMap: treasureMap, treasureSymbols: treasureSymbols)
        
        assertTreasureCoordsWithRef(userCoords: coords, refCoords: ans)
    }
    
    func testGetTreasureCoords2() {
        let treasureMap: [[String]] = [
            ["", "9", "", "$", "", "", "", "", "v", ""],
            ["$", "v", "9", "@", "$", "", "v", "", "", ""],
            ["", "$", "", "9", "@", "", "", "v", "", ""],
            ["", "@", "", "", "", "v", "", "9", "@", "@"],
            ["", "$", "", "", "@", "9", "v", "$", "", "@"],
            ["", "v", "", "", "v", "", "$", "", "9", "v"],
            ["", "", "v", "@", "", "", "9", "", "$", ""],
            ["9", "@", "", "v", "", "@", "$", "v", "@", ""],
            ["v", "", "9", "", "", "v", "9", "", "", "$"],
            ["@", "v", "", "", "", "@", "", "v", "$", ""]
        ]

        let treasureSymbols = ["v", "9", "@", "$"]
        let ans = [(0, 1), (0, 3), (0, 8), (1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (1, 6), (2, 1), (2, 3), (2, 4), (2, 7), (3, 1), (3, 5), (3, 7), (3, 8), (3, 9), (4, 1), (4, 4), (4, 5), (4, 6), (4, 7), (4, 9), (5, 1), (5, 4), (5, 6), (5, 8), (5, 9), (6, 2), (6, 3), (6, 6), (6, 8), (7, 0), (7, 1), (7, 3), (7, 5), (7, 6), (7, 7), (7, 8), (8, 0), (8, 2), (8, 5), (8, 6), (8, 9), (9, 0), (9, 1), (9, 5), (9, 7), (9, 8)]
        let coords = hw1Questions.getTreasureCoords(fromMap: treasureMap, treasureSymbols: treasureSymbols)
        
        assertTreasureCoordsWithRef(userCoords: coords, refCoords: ans)
    }
    
    func testGetTreasureCoords3() {
        let treasureMap: [[String]] = [[], [], []]
        let treasureSymbols = ["v", "9", "@", "$"]
        let ans = [(Int, Int)]()
        let coords = hw1Questions.getTreasureCoords(fromMap: treasureMap, treasureSymbols: treasureSymbols)
        
        assertTreasureCoordsWithRef(userCoords: coords, refCoords: ans)
    }
    
    func testCanEscape1() {
        let instructions: [[HW1Questions.Direction]] = [
            [.down, .right, .left, .up, .left, .right],
            [.right, .left, .left, .left, .right, .right, .right, .left, .right],
            [.right, .right, .right, .left, .right, .right, .right, .right],
            [.right, .right, .right, .left, .right, .right],
            [.left, .right, .right, .left, .right, .right, .right],
            [.left, .left, .left, .left, .right, .right, .right, .right, .right, .right, .right]
        ]
        
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 3, escapeIndex: 7)
        XCTAssertTrue(canEscape, "Gotten canEscape: \(canEscape). Expected: True")
    }
    
    func testCanEscape2() {
        let instructions: [[HW1Questions.Direction]] = [
            [.right, .left, .right, .left, .left],
            [.right],
            [.left],
            [.right, .right, .left, .left, .left, .left]
        ]
        
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 0, escapeIndex: 0)
        XCTAssertFalse(canEscape, "Gotten canEscape: \(canEscape). Expected: False")
    }
    
    func testCanEscape3() {
        let instructions: [[HW1Questions.Direction]] = [
            [.up],
            [.down],
            []
        ]
        
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 0, escapeIndex: 0)
        XCTAssertTrue(canEscape, "Gotten canEscape: \(canEscape). Expected: True")
    }
    
    func testCanEscape4() {
        let instructions: [[HW1Questions.Direction]] = [
            [.right, .right, .right, .up],
            [.right, .right, .right, .right, .left, .down],
        ]
        
        let canEscape = hw1Questions.canEscape(withDirections: instructions, startingIndex: 2, escapeIndex: 5)
        XCTAssertFalse(canEscape, "Gotten canEscape: \(canEscape). Expected: False")
    }
    
    
    // MARK: - Testing Helper Functions
    
    private func assertTreasureCoordsWithRef(userCoords: [(Int, Int)], refCoords: [(Int, Int)]) {
        XCTAssertTrue(refCoords.count == userCoords.count, "Treasure coordinates count does not match the reference coordinates count.")

        for i in 0..<userCoords.count {
            let coord = userCoords[i]
            let ansCoord = refCoords[i]
            XCTAssertTrue(coord.0 == ansCoord.0, "Treasure and reference coord x values do not match")
            XCTAssertTrue(coord.1 == ansCoord.1, "Treasure and reference coord y values do not match")
        }
    }
}
