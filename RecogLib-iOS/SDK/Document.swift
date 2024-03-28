import Foundation

public struct Document: Comparable {
    
    public static func < (lhs: Document, rhs: Document) -> Bool {
        lhs.role == rhs.role &&
            lhs.country == rhs.country &&
            lhs.page == rhs.page &&
            lhs.code == rhs.code
    }
    
    public let role: DocumentRole?
    
    public let country: Country?
    
    public let page: PageCodes?
    
    public let code: DocumentCodes?
    
    public init(role: DocumentRole?, country: Country?, page: PageCodes?, code: DocumentCodes?) {
        self.role = role
        self.country = country
        self.page = page
        self.code = code
    }
}
