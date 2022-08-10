//
//  WeatherModel.swift
//  MyWeatherApp
//
//  Created by Doolot on 26/2/22.
//
import Foundation
struct WeatherModel: Codable {
    let headline: Headline?
    let dailyForecasts: [DailyForecast]?

    enum CodingKeys: String, CodingKey {
        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }
}

// MARK: - DailyForecast
struct DailyForecast: Codable {
    let date: String?
    let epochDate: Int?
    let temperature: Temperature?
    let day, night: Day?
    let sources: [String]?
    let mobileLink, link: String?

    enum CodingKeys: String, CodingKey {
        case date = "Date"
        case epochDate = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - Day
struct Day: Codable {
    let icon: Int?
    let iconPhrase: String?
    let hasPrecipitation: Bool?

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    let minimum, maximum: Imum?

    enum CodingKeys: String, CodingKey {
        case minimum = "Minimum"
        case maximum = "Maximum"
    }
}

// MARK: - Imum
struct Imum: Codable {
    let value: Double?
    let unit: String?
    let unitType: Int?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

// MARK: - Headline
struct Headline: Codable {
    let effectiveDate: String?
    let effectiveEpochDate, severity: Int?
    let text, category, endDate: String?
    let endEpochDate: Int?
    let mobileLink, link: String?

    enum CodingKeys: String, CodingKey {
        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}
