//
//  ShamirSecretSharingTests.swift
//  
//
//  Created by Long Pham on 22/12/2023.
//

import XCTest
@testable import SSSSwift

final class ShamirSecretSharingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testThreeMethods() throws {
        let myLib = MyLib()
        print("MyLib.Foo: \(myLib.foo())")
        
        let data = Array<UInt8>.init(repeating: 42, count: 64)
        
        let shares = try? CreateShares(data: data, n: 5, k: 3)
        
        print(shares ?? "CreateShares error")
        
        var restored = try CombineShares(shares: shares!)
        
        print(restored ?? "CombineShares error")
        
        let key = Array<UInt8>.init(repeating: 42, count: 32)
        let keyshares = try? CreateKeyshares(key: key, n: 5, k: 3)
        
        print(keyshares ?? "CreateShares error")
        
        restored = try CombineKeyshares(keyshares: keyshares!)
        print(restored ?? "Convertsion error")
    }
}
