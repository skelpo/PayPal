func ||<T>(optional: @autoclosure ()throws -> T, fallback: T) -> T {
    do {
        return try optional()
    } catch {
        return fallback
    }
}
