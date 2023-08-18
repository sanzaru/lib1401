import Foundation

public extension Lib1401 {
    struct BCEncoder {
        public static let shared = BCEncoder()

        enum EncodingError: Error {
            case unknownCharacter(String.Element)
            case unknownByte(UInt8)
        }

        public func encode(with buffer: String) throws -> [UInt8] {
            var bytes = [UInt8]()

            for char in buffer {
                guard let byte = Lib1401.CharacterEncodings.shared.simh[char] else {
                    throw(EncodingError.unknownCharacter(char))
                }

                bytes.append(byte)
            }

            return bytes
        }

        public func decode(from data: Data) throws -> String? {
            var decoded = ""

            try data.forEach { byte in
                guard let decodedByte = Lib1401.CharacterEncodings.shared.simh.first(where: { $0.value == UInt8(byte)})?.key else {
                    throw(EncodingError.unknownByte(UInt8(byte)))
                }

                decoded.append(decodedByte)
            }

            return decoded
        }

        public func decode(from bytes: [UInt8]) throws -> String? {
            return try decode(from: Data(bytes))
        }
    }
}
