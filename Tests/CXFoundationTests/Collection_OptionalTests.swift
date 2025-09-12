import Testing

@testable import CXFoundation

@Suite("CollectionOptionalTests")
struct CollectionOptionalTests {
    @Test func getValue() async throws {
        let array: [Int] = [1, 2, 3]
        let optional = array[safe: 1]
        #expect(optional == 2)
    }

    @Test func getValueNil() async throws {
        let array: [Int] = [1, 2, 3]
        let optional = array[safe: 4]
        #expect(optional == nil)
    }
}
