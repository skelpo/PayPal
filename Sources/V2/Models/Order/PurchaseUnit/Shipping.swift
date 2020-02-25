import PayPal

extension PurchaseUnit {
    
    /// The name and address of the person to ship items to.
    public struct Shipping: Codable {
        
        /// The name of the person to whom to ship the items.
        public var name: Failable<String?, NotNilValidate<Length300>>
        
        /// The address of the person to whom to ship the items. Supports only the `address_line_1`, `address_line_2`,
        /// `admin_area_1`, `admin_area_2`, `postal_code`, and `country_code` properties.
        public var address: Address?
        
        /// Creates a new `PurchaseUnit.Shipping` inctance.
        ///
        /// - Parameters:
        ///   - name: The name of the person to whom to ship the items.
        ///   - address: The address of the person to whom to ship the items.
        public init(name: Failable<String?, NotNilValidate<Length300>>, address: Address?) {
            self.name = name
            self.address = address
        }
    }

}
