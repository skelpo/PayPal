import PayPal

extension Webhook {
    
    /// The signature for a `Webhook` object that can be verified.
    public struct Signature: Codable {
        
        /// The algorithm that PayPal uses to generate the signature and that you can use to verify the signature.
        /// Extract this value from the PAYPAL-AUTH-ALGO response header, which is received with the webhook notification.
        public var algorithm: String
        
        /// The X.509 public key certificate. Download the certificate from this URL and use it to verify the signature.
        /// Extract this value from the PAYPAL-CERT-URL response header, which is received with the webhook notification.
        public var cert: String
        
        /// The `transmission-x` properties for the JSON body.
        public var transmission: Transmission
        
        /// The ID of the webhook as configured in your Developer Portal account.
        public var webhook: String
        
        /// A webhook event notification.
        public var event: VerifiedEvent
        
        /// Creates a new `Webhook.Verification` instance.
        ///
        /// - Parameters:
        ///   - algorithm: The algorithm that PayPal uses to generate the signature.
        ///   - cert: The X.509 public key certificate.
        ///   - webhook: The ID of the webhook as configured in your Developer Portal account.
        ///   - event: A webhook event notification.
        public init(
            algorithm: String,
            cert: String,
            transmission: Transmission,
            webhook: String,
            event: VerifiedEvent
        ) {
            self.algorithm = algorithm
            self.cert = cert
            self.transmission = transmission
            self.webhook = webhook
            self.event = event
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            self.algorithm = try container.decode(String.self, forKey: .algorithm)
            self.webhook = try container.decode(String.self, forKey: .webhook)
            self.event = try container.decode(VerifiedEvent.self, forKey: .event)
            self.cert = try container.decode(String.self, forKey: .cert)
            self.transmission = try Transmission(from: decoder)
        }
        
        /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
        public func encode(to encoder: Encoder)throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            try container.encode(self.algorithm, forKey: .algorithm)
            try container.encode(self.webhook, forKey: .webhook)
            try container.encode(self.event, forKey: .event)
            try container.encode(self.cert, forKey: .cert)
            try self.transmission.encode(to: encoder)
        }
        
        /// The status options of a signature verification.
        public enum Status: String, Hashable, CaseIterable, Codable {
            
            /// `SUCCESS`.
            case success = "SUCCESS"
            
            /// `FAILURE`.
            case failure = "FAILURE"
        }
        
        /// The `transmission-x` properties for a `Webhok.Verification` instance.
        public struct Transmission: Codable {
            
            /// The ID of the HTTP transmission. Contained in the `PAYPAL-TRANSMISSION-ID` header of the notification message.
            public var id: String
            
            /// The PayPal-generated asymmetric signature. Appears in the `PAYPAL-TRANSMISSION-SIG`
            /// header of the notification message.
            public var signature: String
            
            /// The date and time of the HTTP transmission, in
            /// [Internet date and time format](https://tools.ietf.org/html/rfc3339#section-5.6).
            /// Appears in the `PAYPAL-TRANSMISSION-TIME` header of the notification message.
            public var time: ISO8601Date
            
            /// Created a new `Webhook.Verification.Transmission` instance.
            ///
            /// - Parameters:
            ///   - id: The ID of the HTTP transmission.
            ///   - signature: The PayPal-generated asymmetric signature.
            ///   - time: The date and time of the HTTP transmission.
            public init(id: String, signature: String, time: ISO8601Date) {
                self.id = id
                self.signature = signature
                self.time = time
            }
            
            enum CodingKeys: String, CodingKey {
                case id = "transmission_id"
                case signature = "transmission_sig"
                case time = "transmission_time"
            }
        }
        
        /// The result of a `Webhooks.verify(signature:)` method call.
        public struct Result: Codable {
            
            /// The status of a signature verification.
            public var status: Status
        }
        
        enum CodingKeys: String, CodingKey {
            case algorithm = "auth_algo"
            case cert = "cert_url"
            case webhook = "webhook_id"
            case event = "webhook_event"
        }
    }
    
    public struct VerifiedEvent: Codable {
        
        /// The ID of the webhook event notification.
        public let id: String?
        
        /// The date and time when the webhook event notification was created.
        public let created: ISO8601Date?
        
        /// The name of the resource related to the webhook notification event.
        public let resourceType: String?
        
        /// The event version in the webhook notification.
        public let version: EventType.Version?
        
        /// The event that triggered the webhook event notification.
        public let type: EventType.Name?
        
        /// A summary description for the event notification.
        public let summary: String?
        
        /// The resource version in the webhook notification.
        public let resourceVersion: EventType.Version?
        
        /// The resource that triggered the webhook event notification.
        public let resource: Resource?
        
        /// An array of request-related [HATEOAS links](https://developer.paypal.com/docs/api/hateoas-links).
        public let links: [LinkDescription]?
    }
    
    public struct Resource: Codable {
        public let id: String?
        public let created: ISO8601Date?
        public let updated: ISO8601Date?
        public let state: String?
        public let amount: DetailedAmount?
        public let parent: String?
        public let validTo: ISO8601Date?
    }
}
