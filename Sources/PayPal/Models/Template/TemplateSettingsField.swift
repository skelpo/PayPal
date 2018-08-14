import Vapor

extension Template.Settings {
    
    /// A field name used to properly display preferences.
    public enum Field: String, Hashable, CaseIterable, Content {
        
        /// `items.quantity`
        case itemsQuantity = "items.quantity"
        
        /// `items.description`
        case itemsDescription = "items.description"
        
        /// `items.date`
        case itemsDate = "items.date"
        
        /// `items.discount`
        case itemsDiscount = "items.discount"
        
        /// `item.tax`
        case itemsTax = "items.tax"
        
        /// `discount`
        case discount = "discount"
        
        /// `shipping`
        case shipping = "shipping"
        
        /// `custom`
        case custom = "custom"
    }
}
