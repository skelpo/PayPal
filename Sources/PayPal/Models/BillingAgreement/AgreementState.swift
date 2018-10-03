import Vapor

/// The state of a billing agreement.
public enum AgreementState: String, Hashable, CaseIterable, Content {
    
    /// The agreement awaits initial payment completion.
    case pending = "Pending"
    
    /// The agreement is active and payments are scheduled.
    case active = "Active"
    
    /// The agreement is suspended and payments are not scheduled until the agreement is reactivated.
    case suspended = "Suspended"
    
    /// The agreement is cancelled and payments are not scheduled.
    case cancelled = "Cancelled"
    
    /// The agreement is expired and no more payments remain to be scheduled.
    case expired = "Expired"
}
