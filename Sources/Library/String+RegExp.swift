import Foundation

public extension String {
    /// An `NSRange` that represents the full range of the string.
    var nsRange: NSRange {
        return NSRange(location: 0, length: utf16.count)
    }

    /// Returns a substring with the given `NSRange`,
    /// or `nil` if the range can't be converted.
    func substring(with nsrange: NSRange) -> String? {
        guard let range = Range(nsrange) else { return nil }
    #if swift(>=5)
        let start = UTF16View.Index(encodedOffset: range.lowerBound)
        let end = UTF16View.Index(encodedOffset: range.upperBound)
    #else
        let start = UTF16Index(encodedOffset: range.lowerBound)
        let end = UTF16Index(encodedOffset: range.upperBound)
    #endif
        return String(utf16[start..<end])
    }

    /// Returns a range equivalent to the given `NSRange`,
    /// or `nil` if the range can't be converted.
    func range(from nsrange: NSRange) -> Range<Index>? {
        guard let range = Range(nsrange) else { return nil }
    #if swift(>=5)
        let utf16Start = UTF16View.Index(encodedOffset: range.lowerBound)
        let utf16End = UTF16View.Index(encodedOffset: range.upperBound)
    #else
        let utf16Start = UTF16Index(encodedOffset: range.lowerBound)
        let utf16End = UTF16Index(encodedOffset: range.upperBound)
    #endif

        guard let start = Index(utf16Start, within: self),
            let end = Index(utf16End, within: self)
            else { return nil }

        return start..<end
    }
}
