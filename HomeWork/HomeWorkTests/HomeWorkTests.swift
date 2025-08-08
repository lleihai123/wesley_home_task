//
//  HomeWorkTests.swift
//  HomeWorkTests
//
//  Created by WesleyLei on 2025/8/6.
//

@testable import HomeWork
import XCTest

final class HomeWorkTests: XCTestCase {
    let interfaceMockImpl = GitHubHttpInterfaceMockImpl()
    override func setUpWithError() throws {
        GitHubServiceManage.configure(interface: interfaceMockImpl)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHomeViewModel() throws {
        let homeViewModel = HomeViewModel(eventCenter: EventCenter.shard)
        GitHubServiceManage.configure(interface: interfaceMockImpl)
        EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventType.networkSuccess, mainNeed: true))
        wait(time: 1.0)
        XCTAssertEqual(homeViewModel.listData.count, 0, "mock not service")
    }
    
    func testProfileViewModel() throws {
        let profileViewModel = ProfileViewModel(eventCenter: EventCenter.shard)
        EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventType.getUserSuccess, mainNeed: true))
        wait(time: 0.5)
        XCTAssertTrue(profileViewModel.isLoginSuccess, "mock not service")
        
    }
    
    func testRootViewModel() throws {
        let rootViewModel = RootViewModel(eventCenter: EventCenter.shard)
        EventCenter.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventType.getUserSuccess, mainNeed: true))
        wait(time: 0.5)
        XCTAssertTrue(rootViewModel.selectedTab == 1, "mock not service")
        
    }
    
    func testRootViewModelByMock() throws {
        let rootViewModel = RootViewModel(eventCenter: EventCenterMockInterface.shard)
        EventCenterMockInterface.shard.dispatcherEvent(event: EventModel(eventData: "", eventType: AppEventType.getUserSuccess, mainNeed: true))
        XCTAssertTrue(rootViewModel.selectedTab == 1, "mock not service")
        
    }
    
    
}

extension HomeWorkTests {
    func wait(time:CGFloat) {
        let delayExpectation = expectation(description: "等待 \(time) 秒")
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            delayExpectation.fulfill()
        }
        wait(for: [delayExpectation], timeout: time)
    }
}
