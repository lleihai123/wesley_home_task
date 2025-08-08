//
//  HomeWorkUITestsLaunchTests.swift
//  HomeWorkUITests
//
//  Created by WesleyLei on 2025/8/6.
//

import XCTest

final class HomeWorkUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
    
    func testAppLoginLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let tabBar = app.tabBars.firstMatch
        guard tabBar.waitForExistence(timeout: 5) else {
            XCTFail("TabBar 未加载成功")
            return
        }
        
        let tabButtons = app.buttons
        if let button = findButton(buttons: tabButtons, name: "个人") {
            button.tap()
        }
        guard tabBar.waitForExistence(timeout: 5) else {
            XCTFail("TabBar 未加载成功")
            return
        }
        
        if let button = findButton(buttons: tabButtons, name: "授权登录") {
            button.tap()
        }
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Test Login"
        attachment.lifetime = .deleteOnSuccess
        add(attachment)
    }
    
    func testAppLogoutLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        
        let tabBar = app.tabBars.firstMatch
        guard tabBar.waitForExistence(timeout: 5) else {
            XCTFail("TabBar 未加载成功")
            return
        }
        
        let tabButtons = app.buttons
        if let button = findButton(buttons: tabButtons, name: "个人") {
            button.tap()
        }
        guard tabBar.waitForExistence(timeout: 5) else {
            XCTFail("TabBar 未加载成功")
            return
        }
        
        if let button = findButton(buttons: tabButtons, name: "退出登录") {
            button.tap()
        }
        
        if let button = findButton(buttons: tabButtons, name: "确定") {
            button.tap()
        }
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Test Logout"
        attachment.lifetime = .deleteOnSuccess
        add(attachment)
    }
    
    func findButton(buttons:XCUIElementQuery, name:String) -> XCUIElement? {
        for button in buttons.allElementsBoundByIndex {
            print("按钮标识：\(button.identifier)，文本：\(button.label)")
            if button.label == name {
                return button
            }
        }
        return nil
    }
}
