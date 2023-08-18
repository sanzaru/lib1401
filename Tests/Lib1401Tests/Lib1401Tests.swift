import XCTest
@testable import Lib1401

final class Lib1401Tests: XCTestCase {
    let inputBytes: [UInt8] = [
        0x5b, 0x4a, 0x4a, 0x08, 0x4a, 0x4a, 0x01, 0x45, 0x5b, 0x4a, 0x02, 0x02, 0x4a, 0x02, 0x49, 0x5b,
        0x64, 0x4a, 0x07, 0x07, 0x02, 0x01, 0x01
    ]

    let inputString = ",0080015,022029,M077211"
    let inputStringInvalid = " ö§§"

    func testEncode() throws {
        XCTAssertEqual(inputBytes, try Lib1401.CharacterEncodings.shared.encode(code: inputString))
    }

    func testDecode() throws {
        let decoded = try Lib1401.CharacterEncodings.shared.decode(from: Data(inputBytes))
        XCTAssertEqual(decoded, inputString)
    }

    func testInvalid() throws {
        XCTAssertThrowsError(try Lib1401.CharacterEncodings.shared.encode(code: inputStringInvalid))
    }
}
