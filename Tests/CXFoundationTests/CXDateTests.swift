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
        date.year = .year(2023)
        #expect(date.year.value == 2023)
        #expect(date.isValid)
    }

    @Test func testUpdateMonth() async throws {
        var date = CXDate()
        date.month = .month(1)
        #expect(date.month.value == 1)
        #expect(date.isValid == false)
    }

    @Test func testUpdateDay() async throws {
        var date = CXDate()
        date.day = .day(1)
        #expect(date.day.value == 1)
        #expect(date.isValid == false)
    }

    @Test func testYearMonth() async throws {
        var date = CXDate()
        date.year = .year(2023)
        date.month = .month(1)
        #expect(date.year.value == 2023)
        #expect(date.month.value == 1)
        #expect(date.isValid)
    }

    @Test func testYearMonthDay() async throws {
        var date = CXDate()
        date.year = .year(2023)
        date.month = .month(1)
        date.day = .day(1)
        #expect(date.year.value == 2023)
        #expect(date.month.value == 1)
        #expect(date.day.value == 1)
        #expect(date.isValid)
    }

    @Test func testYearOnlyDescription() async throws {
        var date = CXDate()
        date.year = .year(2023)
        #expect(date.description == "2023")
    }

    @Test func testYearMonthOnlyDescription() async throws {
        var date = CXDate()
        date.year = .year(2023)
        date.month = .month(1)
        #expect(date.description == "2023-Jan")
    }

    @Test func testYearMonthDayDescription() async throws {
        var date = CXDate()
        date.year = .year(2023)
        date.month = .month(1)
        date.day = .day(1)
        #expect(date.description == "2023-Jan-1")
    }

    @Test func testFormattedValue() async throws {
        var date = CXDate()
        date.year = .year(2023)
        date.month = .month(1)
        date.day = .day(1)
        #expect(date.formattedValue == "2023-01-01")
    }
}
