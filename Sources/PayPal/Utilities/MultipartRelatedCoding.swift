import Multipart
import Random
import Vapor

// MARK: - Multipart

extension MediaType {
    
    /// Multipart encoded compound objects
    public static let related = MediaType(type: "multipart", subType: "related")
}

extension MultipartPart {
    
    /// Creates a random boundary for serelizing or parsing multipart data with.
    ///
    /// Use `OSRandom` to generate the bytes used.
    ///
    /// - Returns: A new boundary.
    public static func boundary() -> String {
        let random = OSRandom().generateData(count: 16)
        return "---vaporBoundary" + random.hexEncodedString()
    }
}

extension Dictionary where Key: LosslessStringConvertible, Value == MultipartPartConvertible {
    
    /// Converts an dictionary of `String: MultipartPartConvertible` objects to keyed `MultipartPart`s
    ///
    /// - Returns: The converted objects.
    ///
    /// - Throws: Any errors thrown from an object's `convertToMultipartPart()` implementation.
    public func parts()throws -> [String: MultipartPart] {
        return try self.reduce(into: [:]) { result, convertible in
            var part = try convertible.value.convertToMultipartPart()
            if part.name == nil { part.name = convertible.key.description }
            result[part.name ?? convertible.key.description] = part
        }
    }
}

extension Array where Element == MultipartPartConvertible {
    
    /// Converts an array of `MultipartPartConvertible` objects to `MultipartPart`s
    ///
    /// - Returns: The converted objects.
    ///
    /// - Throws: Any errors thrown from an object's `convertToMultipartPart()` implementation.
    public func parts()throws -> [MultipartPart] {
        return try self.map { try $0.convertToMultipartPart() }
    }
}

// MARK: Vapor

extension MultipartPart: Content {
    
    /// See [`Decoder.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try container.decode(MultipartPart.self)
    }
    
    /// See [`Encoder.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode)
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self)
    }
}

/// Decodes `MultipartPartConvertible` and `Decodable` objects from `multipart/related` encoded data.
final class MultipartRelatedDecoder: HTTPMessageDecoder {
    
    /// See [`HTTPMessageDecoder.decode(_:from:maxSize:on:)`](https://api.vapor.codes/http/3.0.0/HTTP/Protocols/HTTPMessageDecoder.html#/s:4HTTP18HTTPMessageDecoderP6decodeXeXeF)
    public func decode<D, M>(_ decodable: D.Type, from message: M, maxSize: Int, on worker: Worker) throws -> EventLoopFuture<D> where D : Decodable, M : HTTPMessage {
        guard message.contentType == .related else {
            throw VaporError(
                identifier: "contentType",
                reason: "\(M.self)'s content type does not indicate multipart/related: \(message.contentType?.description ?? "none")",
                possibleCauses: [
                    "\(M.self) does not contain multipart/related.",
                    "\(M.self) is missing the 'Content-Type' header.",
                ]
            )
        }
        guard let boundary = message.contentType?.parameters["boundary"] else {
            throw VaporError(
                identifier: "contentType",
                reason: "\(M.self) did not have multipart/related boundary.",
                possibleCauses: [
                    "\(M.self) is incorrectly formatted."
                ]
            )
        }
        return message.body.consumeData(max: maxSize, on: worker).map { data in
            return try FormDataDecoder().decode(D.self, from: data, boundary: boundary)
        }
    }
}

/// Encodes MultipartPartConvertible` and `Decodable` objects to `multipart/related` data.
final class MultipartRelatedEncoder: HTTPMessageEncoder {
    
    /// See [`HTTPMessageEncoder.encode(_:to:on:)`](https://api.vapor.codes/http/3.0.0/HTTP/Protocols/HTTPMessageEncoder.html#/s:4HTTP18HTTPMessageEncoderP6encodeXeXeF)
    func encode<E, M>(_ encodable: E, to message: inout M, on worker: Worker) throws where E : Encodable, M : HTTPMessage {
        let boundary = MultipartPart.boundary()
        message.contentType = MediaType(type: "multipart", subType: "related", parameters: ["boundary": boundary])
        message.body = try HTTPBody(data: FormDataEncoder().encode(encodable, boundary: boundary))
    }
}
