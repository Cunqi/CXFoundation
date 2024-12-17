import Testing

@testable import CXFoundation

@Suite("CollectionOptionalTests")
struct CollectionOptionalTests {
    @Test func testGetValue() async throws {
        let array: [Int] = [1, 2, 3]
        let optional = array[safe: 1]
        #expect(optional == 2)
    }

    @Test func testGetValueNil() async throws {
        let array: [Int] = [1, 2, 3]
        let optional = array[safe: 4]
        #expect(optional == nil)
    }
}
