import XCTest
@testable import Lib1401

final class Lib1401Tests: XCTestCase {
    let inputBytes: [UInt8] = [
        0x5b, 0x4a, 0x4a, 0x08, 0x4a, 0x4a, 0x01, 0x45, 0x5b, 0x4a, 0x02, 0x02, 0x4a, 0x02, 0x49, 0x5b,
        0x64, 0x4a, 0x07, 0x07, 0x02, 0x01, 0x01
    ]

    let inputString = ",0080015,022029,M077211"
    let inputStringInvalid = "InvalidInputString"

    func testEncode() throws {
        let encoded = try Lib1401.BCEncoder.shared.encode(with: inputString)
        XCTAssertEqual(inputBytes, encoded)
    }

    func testDecode() throws {
        let decoded = try Lib1401.BCEncoder.shared.decode(from: Data(inputBytes))
        XCTAssertEqual(decoded, inputString)
    }

    func testInvalid() throws {
        XCTAssertThrowsError(try Lib1401.BCEncoder.shared.encode(with: inputStringInvalid))
    }
}
