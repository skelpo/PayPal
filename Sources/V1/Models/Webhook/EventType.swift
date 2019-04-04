import Failable

/// An event that will fire a registered webhook.
public struct EventType: Codable {
    
    /// The unique event name.
    public var name: Name
    
    /// A human-readable description of the event.
    public let description: String?
    
    /// The status of a webhook event.
    public let status: String?
    
    /// The resource versions in the webhook notification.
    public let versions: [Version]?
    
    /// Creates a new `EventType` instance.
    ///
    /// - Parameters:
    ///   - name: The unique event name.
    ///   - description: A human-readable description of the event.
    ///   - status: The status of a webhook event.
    ///   - versions: The resource versions in the webhook notification.
    public init(
        name: Name,
        description: String?,
        status: String?,
        versions: [Version]?
    ) {
        self.name = name
        self.description = description
        self.status = status
        self.versions = versions
    }
    
    /// The validator for the `EventType.versions` property value.
    public struct Version: Codable {
        
        /// The value which makes the major value of the version, i.e. `1.x`.
        public var major: Int
        
        /// The value which makes the minor value of the version, i.e. `x.0`.
        public var minor: Int
        
        /// Creates a new `EventType.Version` instance.
        ///
        /// - Parameters:
        ///   - major: The value which makes the major value of the version.
        ///   - minor: The value which makes the minor value of the version.
        public init(major: Int, minor: Int) {
            self.major = major
            self.minor = minor
        }
        
        /// Creates an `EventType` instance.
        ///
        /// - Parameter string: A string containing the version data, i.e. `1.0`.
        public init?(_ string: String) {
            
            // FIXME: - We only convert to a `String` because otherwise we get a compiler crash.
            // Remove that operation when the compiler gets fixed: https://bugs.swift.org/browse/SR-10305
            let components = string.split(separator: ".").map(String.init)
            guard components.count == 2 else { return nil }
            guard let major = components.first.flatMap(Int.init) else { return nil }
            guard let minor = components.last.flatMap(Int.init) else { return nil }
            
            self.major = major
            self.minor = minor
        }
        
        /// See [`Decodable.init(from:)`](https://developer.apple.com/documentation/swift/decodable/2894081-init).
        public init(from decoder: Decoder)throws {
            let container = try decoder.singleValueContainer()
            let version = try container.decode(String.self)
            
            guard let instance = Version(version) else {
                throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot get version components from string \(version)"
                )
            }
            
            self = instance
        }
        
        /// See [`Encodable.encode(to:)`](https://developer.apple.com/documentation/swift/encodable/2893603-encode).
        public func encode(to encoder: Encoder)throws {
            var container = encoder.singleValueContainer()
            let version = "\(self.major).\(self.minor)"
            
            try container.encode(version)
        }
    }
    
    /// The webhook events that are supported by PayPal.
    public enum Name: String, Hashable, CaseIterable, Codable {
        
        /// `PAYMENT.AUTHORIZATION.CREATED`
        case authorizationCreated = "PAYMENT.AUTHORIZATION.CREATED"
        
        /// `PAYMENT.AUTHORIZATION.VOIDED`
        case authorizationVoided = "PAYMENT.AUTHORIZATION.VOIDED"
        
        /// `PAYMENT.CAPTURE.COMPLETED`
        case captureCompleted = "PAYMENT.CAPTURE.COMPLETED"
        
        /// `PAYMENT.CAPTURE.DENIED`
        case captureDenied = "PAYMENT.CAPTURE.DENIED"
        
        /// `PAYMENT.CAPTURE.PENDING`
        case capturePending = "PAYMENT.CAPTURE.PENDING"
        
        /// `PAYMENT.CAPTURE.REFUNDED`
        case captureRefunded = "PAYMENT.CAPTURE.REFUNDED"
        
        /// `PAYMENT.CAPTURE.REVERSED`
        case captureReversed = "PAYMENT.CAPTURE.REVERSED"

        
        /// `PAYMENT.PAYOUTSBATCH.DENIED`
        case payoutbatchDenied = "PAYMENT.PAYOUTSBATCH.DENIED"
        
        /// `PAYMENT.PAYOUTSBATCH.PROCESSING`
        case payoutbatchProcessing = "PAYMENT.PAYOUTSBATCH.PROCESSING"
        
        /// `PAYMENT.PAYOUTSBATCH.SUCCESS`
        case payoutbatchSuccess = "PAYMENT.PAYOUTSBATCH.SUCCESS"
        
        /// `PAYMENT.PAYOUTS-ITEM.BLOCKED`
        case payoutItemBlocked = "PAYMENT.PAYOUTS-ITEM.BLOCKED"
        
        /// `PAYMENT.PAYOUTS-ITEM.CANCELED`
        case payoutItemCanceled = "PAYMENT.PAYOUTS-ITEM.CANCELED"
        
        /// `PAYMENT.PAYOUTS-ITEM.DENIED`
        case payoutItemDenied = "PAYMENT.PAYOUTS-ITEM.DENIED"
        
        /// `PAYMENT.PAYOUTS-ITEM.FAILED`
        case payoutItemFailed = "PAYMENT.PAYOUTS-ITEM.FAILED"
        
        /// `PAYMENT.PAYOUTS-ITEM.HELD`
        case payoutItemHeld = "PAYMENT.PAYOUTS-ITEM.HELD"
        
        /// `PAYMENT.PAYOUTS-ITEM.REFUNDED`
        case payoutItemRefunded = "PAYMENT.PAYOUTS-ITEM.REFUNDED"
        
        /// `PAYMENT.PAYOUTS-ITEM.RETURNED`
        case payoutItemReturned = "PAYMENT.PAYOUTS-ITEM.RETURNED"
        
        /// `PAYMENT.PAYOUTS-ITEM.SUCCEEDED`
        case payoutItemSucceeded = "PAYMENT.PAYOUTS-ITEM.SUCCEEDED"
        
        /// `PAYMENT.PAYOUTS-ITEM.UNCLAIMED`
        case payoutItemUnclaimed = "PAYMENT.PAYOUTS-ITEM.UNCLAIMED"

        
        /// `BILLING_AGREEMENTS.AGREEMENT.CREATED`
        case agreementCreated = "BILLING_AGREEMENTS.AGREEMENT.CREATED"
        
        /// `BILLING_AGREEMENTS.AGREEMENT.CANCELLED`
        case agreementCancelled = "BILLING_AGREEMENTS.AGREEMENT.CANCELLED"
        
        /// `BILLING.PLAN.CREATED`
        case planCreated = "BILLING.PLAN.CREATED"
        
        /// `BILLING.PLAN.UPDATED`
        case planeUpdated = "BILLING.PLAN.UPDATED"
        
        /// `BILLING.SUBSCRIPTION.CANCELLED`
        case subscriptionCancelled = "BILLING.SUBSCRIPTION.CANCELLED"
        
        /// `BILLING.SUBSCRIPTION.CREATED`
        case subscriptionCreated = "BILLING.SUBSCRIPTION.CREATED"
        
        /// `BILLING.SUBSCRIPTION.RE-ACTIVATED`
        case subscriptionReactivated = "BILLING.SUBSCRIPTION.RE-ACTIVATED"
        
        /// `BILLING.SUBSCRIPTION.SUSPENDED`
        case subscriptionSuspended = "BILLING.SUBSCRIPTION.SUSPENDED"
        
        /// `BILLING.SUBSCRIPTION.UPDATED`
        case subscriptionUpdated = "BILLING.SUBSCRIPTION.UPDATED"

        
        /// `IDENTITY.AUTHORIZATION-CONSENT.REVOKED`
        case authorizationConsentRevoked = "IDENTITY.AUTHORIZATION-CONSENT.REVOKED"

        
        /// `CUSTOMER.DISPUTE.CREATED`
        case disputeCreated = "CUSTOMER.DISPUTE.CREATED"
        
        /// `CUSTOMER.DISPUTE.RESOLVED`
        case disputeResolved = "CUSTOMER.DISPUTE.RESOLVED"
        
        /// `CUSTOMER.DISPUTE.UPDATED`
        case disputeUpdated = "CUSTOMER.DISPUTE.UPDATED"
        
        /// `RISK.DISPUTE.CREATED`
        case riskDisputeCreated = "RISK.DISPUTE.CREATED"

        
        /// `INVOICING.INVOICE.CANCELLED`
        case invoiceCancelled = "INVOICING.INVOICE.CANCELLED"
        
        /// `INVOICING.INVOICE.CREATED`
        case invoiceCreated = "INVOICING.INVOICE.CREATED"
        
        /// `INVOICING.INVOICE.PAID`
        case invoicePaid = "INVOICING.INVOICE.PAID"
        
        /// `INVOICING.INVOICE.REFUNDED`
        case invoiceRefunded = "INVOICING.INVOICE.REFUNDED"
        
        /// `INVOICING.INVOICE.SCHEDULED`
        case invoiceScheduled = "INVOICING.INVOICE.SCHEDULED"
        
        /// `INVOICING.INVOICE.UPDATED`
        case invoiceUpdtaed = "INVOICING.INVOICE.UPDATED"

        
        /// `MERCHANT.ONBOARDING.COMPLETED`
        case onboardingComplete = "MERCHANT.ONBOARDING.COMPLETED"
        
        /// `MERCHANT.PARTNER-CONSENT.REVOKED`
        case partnerConsentRevoked = "MERCHANT.PARTNER-CONSENT.REVOKED"

        
        /// `CHECKOUT.ORDER.PROCESSED`
        case checkoutProcessed = "CHECKOUT.ORDER.PROCESSED"
        
        /// `CUSTOMER.ACCOUNT-LIMITATION.ADDED`
        case accountLimitationAdded = "CUSTOMER.ACCOUNT-LIMITATION.ADDED"
        
        /// `CUSTOMER.ACCOUNT-LIMITATION.ESCALATED`
        case accountLimitationEscalated = "CUSTOMER.ACCOUNT-LIMITATION.ESCALATED"
        
        /// `CUSTOMER.ACCOUNT-LIMITATION.LIFTED`
        case accountLimitationLifted = "CUSTOMER.ACCOUNT-LIMITATION.LIFTED"
        
        /// `CUSTOMER.ACCOUNT-LIMITATION.UPDATED`
        case accountLimitationUpdated = "CUSTOMER.ACCOUNT-LIMITATION.UPDATED"

        
        /// `PAYMENT.ORDER.CANCELLED`
        case orderCancelled = "PAYMENT.ORDER.CANCELLED"
        
        /// `PAYMENT.ORDER.CREATED`
        case orderCreated = "PAYMENT.ORDER.CREATED"

        
        /// `PAYMENT.REFERENCED-PAYOUT-ITEM.COMPLETED`
        case referencedItemCompleted = "PAYMENT.REFERENCED-PAYOUT-ITEM.COMPLETED"
        
        /// `PAYMENT.REFERENCED-PAYOUT-ITEM.FAILED`
        case referencedItemFailed = "PAYMENT.REFERENCED-PAYOUT-ITEM.FAILED"

        
        /// `PAYMENT.SALE.COMPLETED`
        case saleCompleted = "PAYMENT.SALE.COMPLETED"
        
        /// `PAYMENT.SALE.DENIED`
        case saleDenied = "PAYMENT.SALE.DENIED"
        
        /// `PAYMENT.SALE.PENDING`
        case salePending = "PAYMENT.SALE.PENDING"
        
        /// `PAYMENT.SALE.REFUNDED`
        case saleRefunded = "PAYMENT.SALE.REFUNDED"
        
        /// `PAYMENT.SALE.REVERSED`
        case saleReversed = "PAYMENT.SALE.REVERSED"

        
        /// `VAULT.CREDIT-CARD.CREATED`
        case creditCardCreated = "VAULT.CREDIT-CARD.CREATED"
        
        /// `VAULT.CREDIT-CARD.DELETED`
        case creditCardDeleted = "VAULT.CREDIT-CARD.DELETED"
        
        /// `VAULT.CREDIT-CARD.UPDATED`
        case creditCardUpdated = "VAULT.CREDIT-CARD.UPDATED"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, description, status
        case versions = "resource_versions"
    }
}
