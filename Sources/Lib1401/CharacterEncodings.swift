import Foundation

public extension Lib1401 {
    /// Character encoding functions and definitions for the IBM 1401
    /// The encoding is based on the SIMH encoding
    /// - seealso:  [https://github.com/simh/simh](https://github.com/simh/simh)
    struct CharacterEncodings {
        public static let shared = CharacterEncodings()

        enum EncodingError: Error {
            case invalidCharacter(Character)
        }

        /// Default SimH encoding
        public let simh: [Character: UInt8] = [
            "A": 0b00110001, "B": 0b00110010, "C": 0b01110011, "D": 0b00110100,
            "E": 0b01110101, "F": 0b01110110, "G": 0b00110111, "H": 0b00111000,
            "I": 0b01111001, "&": 0b01110000, ".": 0b00111011, ")": 0b01111100,
            "J": 0b01100001, "K": 0b01100010, "L": 0b00100011, "M": 0b01100100,
            "N": 0b00100101, "O": 0b00100110, "P": 0b01100111, "Q": 0b01101000,
            "R": 0b00101001, "-": 0b00100000, "$": 0b01101011, "*": 0b00101100,
            "/": 0b01010001, "S": 0b01010010, "T": 0b00010011, "U": 0b01010100,
            "V": 0b00010101, "W": 0b00010110, "X": 0b01010111, "Y": 0b01011000,
            "Z": 0b00011001, "'": 0b00011010, ",": 0b01011011, "%": 0b00011100,
            "#": 0b00001011, "@": 0b01001100, "0": 0b01001010, "1": 0b00000001,
            "2": 0b00000010, "3": 0b01000011, "4": 0b00000100, "5": 0b01000101,
            "6": 0b01000110, "7": 0b00000111, "8": 0b00001000, "9": 0b01001001,
            " ": 0b01000000, ":": 0b00001101, ">": 0b00001110, "(": 0b01001111,
            "^": 0b00010000, "\\": 0b01011110, "+": 0b00011111, "!": 0b00101010,
            "]": 0b01101101, ";": 0b01101110, "_": 0b00101111, "?": 0b01111010,
            "[": 0b00111101, "<": 0b00111110, "\"": 0b01111111
        ]

        /// Encode given string
        /// - Parameter code: The string to encode
        /// - Returns: Array with the encoded bytes
        public func encode(code: String) throws -> [UInt8] {
            try code.uppercased().map({
                if let item = simh[$0] {
                    return item
                }

                throw(EncodingError.invalidCharacter($0))
            })
        }

        /// Decode given UInt8 array to string
        /// - Parameter words: Array of bytes to decode
        /// - Returns: String with the decoded message
        public func decode(words: [UInt8]) -> String? {
            let decoded = words.compactMap({ word in
                return simh.first(where: { $0.value == word })?.key
            })

            return String(decoded)
        }

        /// Decode given Data to string
        /// - Parameter words: Array of bytes to decode
        /// - Returns: String with the decoded message
        public func decode(from data: Data) throws -> String? {
            return decode(words: data.map({ UInt8($0) }))
        }
    }
}
