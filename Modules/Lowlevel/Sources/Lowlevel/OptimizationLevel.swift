/// Represents the optimization levels available for Swift compilation.
public enum OptimizationLevel: String, CaseIterable {

    /// Balanced optimization (`-O`): suitable for general-purpose optimized builds.
    case balanced = "-O"

    /// No optimization (`-Onone`): disables all optimizations, useful for debugging.
    case none = "-Onone"

    /// Size optimization (`-Osize`): optimizes for smaller binary size.
    case size = "-Osize"

    /// Unchecked optimization (`-Ounchecked`): performs aggressive optimizations and disables overflow checks.
    case unchecked = "-Ounchecked"
}
