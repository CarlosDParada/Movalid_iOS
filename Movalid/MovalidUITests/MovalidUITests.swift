//
//  MovalidUITests.swift
//  MovalidUITests
//
//  Created by Carlos Parada on 6/21/19.
//  Copyright © 2019 Carlos Parada. All rights reserved.
//

import XCTest

class MovalidUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func validateFLow(){
        
        let app = XCUIApplication()
        let topRatedButton = app/*@START_MENU_TOKEN@*/.buttons["Top Rated"]/*[[".segmentedControls.buttons[\"Top Rated\"]",".buttons[\"Top Rated\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        topRatedButton.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Upcoming"]/*[[".segmentedControls.buttons[\"Upcoming\"]",".buttons[\"Upcoming\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Series"]/*[[".segmentedControls.buttons[\"Series\"]",".buttons[\"Series\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let popularButton = app/*@START_MENU_TOKEN@*/.buttons["Popular"]/*[[".segmentedControls.buttons[\"Popular\"]",".buttons[\"Popular\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        popularButton.tap()
        topRatedButton.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Peliculas"]/*[[".segmentedControls.buttons[\"Peliculas\"]",".buttons[\"Peliculas\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        popularButton.tap()
    }
    


}
