import HTTP

extension HTTPHeaderName {
    
    /// `PayPal-Auth-Assertion`
    ///
    /// Specifies an API client-provided [JSON Web Token (JWT)](https://tools.ietf.org/html/rfc7519) assertion that identifies the merchant.
    ///
    /// When an API client acts on behalf of multiple merchants at the same time, it becomes difficult and expensive to generate and manage
    /// multiple access tokens. Instead, API clients can use this header to provide a JWT assertion that identifies the merchant when the
    /// API is called.
    ///
    /// - Note: To use this header, you must get consent to act on behalf of a merchant.
    ///
    /// In the header, specify one of these JSON Web Token sub-forms:
    /// - [JSON Web Encryption (JWE)](https://tools.ietf.org/html/rfc7516), in
    ///   [JWS Compact Serialization](https://tools.ietf.org/html/rfc7515#section-3.1) format.
    /// - [JSON Web Signature (JWS)](https://tools.ietf.org/html/rfc7515), in
    ///   [JWE Compact Serialization](https://tools.ietf.org/html/rfc7516#section-3.1) format. Supports both secure and unsecured JWT.
    ///   An unsecured JWT specifies an `alg` of `none` in the `JOSE` header and an empty string for the signature.
    ///
    /// Unsecured JWT example:
    /// - JOSE header:
    ///   ```
    ///   {"alg": "none"}
    ///   ```
    /// - Payload can contain `email`, `client_id`, and `payer_id`. Example payload:
    ///   ```
    ///   {"iss": "client_id","email":"my-email@example.com"}
    ///   ```
    /// - Signature. Use `""` for the unsigned case.
    /// - Resulting unsecured JWT after Base64 and simple concatenation:
    ///   ```
    ///   eyJhbGciOiJub25lIn0.eyJlbWFpbCI6Im15QGVtYWlsLmNvbSJ9
    ///   ```
    ///
    /// All API endpoints support this header.
    public static let paypalAuth = HTTPHeaderName("PayPal-Auth-Assertion")
    
    /// `PayPal-Client-Metadata-Id`
    ///
    /// Verifies that the payment originates from a valid, user-consented device and application. Reduces fraud and decreases declines.
    /// Transactions that do not include a client metadata ID are not eligible for PayPal Seller Protection.
    public static let paypalMetadata = HTTPHeaderName("PayPal-Client-Metadata-Id")
    
    /// `PayPal-Partner-Attribution-Id`
    ///
    /// Indicates that you are a PayPal partner. To receive revenue attribution, specify a unique build notation (BN) code.
    /// BN codes provide tracking on all transactions that originate or are associated with a particular partner. To learn more or
    /// to request a BN code, contact your partner manager or visit the [PayPal Partner Portal](https://www.paypal.com/partnerprogram/).
    public static let paypalAttribution = HTTPHeaderName("PayPal-Partner-Attribution-Id")
    
    /// `PayPal-Request-Id`
    ///
    /// Contains a unique user-generated ID that you can use to enforce idempotency.
    ///
    /// - Note:
    ///   - If you omit this header, the risk of duplicate transactions increases.
    ///   - Not all APIs support this header. To determine whether your API supports it, see the API reference for your API.
    public static let paypalRequest = HTTPHeaderName("PayPal-Request-Id")
}
