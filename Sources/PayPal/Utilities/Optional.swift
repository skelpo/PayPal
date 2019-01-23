/// Attempts a throwing operation, and if an error occurs, a default value is returned instead.
///
/// - Parameters:
///   - optional: The throwing closure that could fail.
///   - fallback: The default value that will be returned if an error is thrown.
///
/// - Returns: The result of the throing operation or the default value.
func ||<T>(optional: @autoclosure ()throws -> T, fallback: @autoclosure () -> T) -> T {
    do {
        return try optional()
    } catch {
        return fallback()
    }
}
