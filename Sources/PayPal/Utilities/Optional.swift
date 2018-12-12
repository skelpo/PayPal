func ||<T>(optional: @autoclosure ()throws -> T, fallback: @autoclosure () -> T) -> T {
    do {
        return try optional()
    } catch {
        return fallback()
    }
}
