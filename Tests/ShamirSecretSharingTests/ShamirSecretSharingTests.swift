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
    
    func testKeyShares() throws {
        
        let key = Array<UInt8>.init(repeating: 42, count: 32)
        let keyshares = try? CreateKeyshares(key: key, n: 3, k: 2)
        
        XCTAssertEqual(keyshares?.count, 3)
        
        let part1 = keyshares![0]
        let part2 = keyshares![1]
        let part3 = keyshares![2]
        
        let part1Encoded = part1.data.base64EncodedString()
        let part2Encoded = part2.data.base64EncodedString()
        let part3Encoded = part3.data.base64EncodedString()
        print("Part1: \(part1Encoded)")
        print("Part2: \(part2Encoded)")
        print("Part3: \(part3Encoded)")
        
        let part1Decoded = Data.init(base64Encoded: part1Encoded)
        let part2Decoded = Data.init(base64Encoded: part2Encoded)
        let part3Decoded = Data.init(base64Encoded: part3Encoded)
        
        let joined = [part1Decoded!.bytes, part2Decoded!.bytes, part3Decoded!.bytes]
        
        let restored = try? CombineKeyshares(keyshares: joined)
        XCTAssertEqual(restored, key)
    }
}

public typealias Bytes = Array<UInt8>

extension Array where Element == UInt8 {
    init (count bytes: Int) {
        self.init(repeating: 0, count: bytes)
    }

    public var utf8String: String? {
        return String(data: Data(self), encoding: .utf8)
    }
}

extension ArraySlice where Element == UInt8 {
    var bytes: Bytes { return Bytes(self) }
}

public extension String {
    var bytes: Bytes { return Bytes(self.utf8) }
}

extension Bytes {
    var data: Data {
        return Data.init(bytes: self, count: count)
    }
}

extension Data {
    var bytes: [UInt8] {
        return [UInt8](self)
    }
}
