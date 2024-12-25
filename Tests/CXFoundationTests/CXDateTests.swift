@testable import CXFoundation
import Foundation
import Testing

@Suite("CXDateTests")
struct CXDateTests {
    @Test func testDate() async throws {
        let date = CXDate.now
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date.value)
        #expect(date.year.value == components.year)
        #expect(date.month.value == components.month)
        #expect(date.day.value == components.day)
        #expect(date.isValid)
    }

    @Test func testEmptyDate() async throws {
        let date = CXDate()
        #expect(date.year.isValid == false)
        #expect(date.month.isValid == false)
        #expect(date.day.isValid == false)
        #expect(date.isValid == false)
    }

    @Test func testUpdateYear() async throws {
        var date = CXDate()
        date.year = .init(2023)
        #expect(date.year.value == 2023)
        #expect(date.isValid)
        #expect(date.description == "2023")
    }

    @Test func testUpdateMonth() async throws {
        var date = CXDate()
        date.month = .init(year: 2023, month: 1)
        #expect(date.year.value == 2023)
        #expect(date.month.value == 1)
        #expect(date.isValid)
        #expect(date.description == "2023-1")
    }

    @Test func testUpdateDay() async throws {
        var date = CXDate()
        date.day = .init(month: .init(year: 2023, month: 1), day: 1)
        #expect(date.year.value == 2023)
        #expect(date.month.value == 1)
        #expect(date.day.value == 1)
        #expect(date.isValid)
        #expect(date.description == "2023-1-1")
    }

    @Test func testFormattedValue() async throws {
        var date = CXDate()
        date.day = .init(month: .init(year: 2023, month: 1), day: 1)
        #expect(date.formattedValue == "2023-01-01")
    }
}
