//
//  ItemDetailViewModelTests.swift
//  FlikrTests
//
//  Created by Chetan Dhowlaghar on 7/3/24.
//

import Foundation
import XCTest
@testable import Flikr

class ItemDetailViewModelTests: XCTestCase {
    var viewModel: ItemDetailViewModel!
    var item: Item!
    let mockAPIService = MockAPIService()
    override func setUp() {
        super.setUp()
        
        self.item = Item(id: UUID(), title: "all day I dream of horse chestnut blossom", link: "https://www.flickr.com/photos/slabrador/53750657455/", media: FlikrTests.Media(m: "https://live.staticflickr.com/65535/53750657455_0c06d020a3_m.jpg"), dateTaken: nil, description: " <p><a href=\"https://www.flickr.com/people/slabrador/\">slabrador</a> posted a photo:</p> <p><a href=\"https://www.flickr.com/photos/slabrador/53750657455/\" title=\"all day I dream of horse chestnut blossom\"><img src=\"https://live.staticflickr.com/65535/53750657455_0c06d020a3_m.jpg\" width=\"240\" height=\"180\" alt=\"all day I dream of horse chestnut blossom\" /></a></p> ", published: "2024-05-27T16:14:56Z", author: "nobody@flickr.com (\"slabrador\")", authorID: nil, tags: "corsham england unitedkingdom corshamcourt capabilitybrown lancelotcapabilitybrown haha sunkfence mist morning grass blue lawn trees horsechestnut")
        viewModel = ItemDetailViewModel(item: item, apiService: mockAPIService)
    }
    
    override func tearDown() {
        item = nil
        super.tearDown()
    }
    
    func testParseImageSizeFromDescription() {
        XCTAssertEqual(viewModel.imageWidth, 240)
        XCTAssertEqual(viewModel.imageHeight, 180)
    }
    
    func testFormattedDate() {
        if let date = viewModel.date {
            XCTAssertEqual(date, "May 27, 2024")
        }
    }
    
    func testShareItemSuccess() async {
        // Prepare mock data
        let image = UIImage(systemName: "photo")!
        let imageData = image.pngData()!
        mockAPIService.responseData = imageData
        
        // Execute shareItem
        await viewModel.shareItem()
        
        // Check that no alert is shown
        XCTAssertFalse(viewModel.showAlert)
    }
    
    func testShareItemFailure() async {
        // Set mock API service to return an error
        mockAPIService.shouldReturnError = true
        
        // Execute shareItem
        await viewModel.shareItem()
        
        // Check that an alert is shown
        XCTAssertTrue(viewModel.showAlert)
    }
}


    
   
