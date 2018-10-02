//
//  FoodDataWeekDietData.swift
//
//  Created by vikash kumar on 10/2/18
//  Copyright (c) Naive. All rights reserved.
//

import Foundation
import ObjectMapper

public class FoodDataWeekDietData: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kFoodDataWeekDietDataWednesdayKey: String = "wednesday"
  private let kFoodDataWeekDietDataMondayKey: String = "monday"
  private let kFoodDataWeekDietDataThursdayKey: String = "thursday"

  // MARK: Properties
  public var wednesday: [FoodData]?
  public var monday: [FoodData]?
  public var thursday: [FoodData]?

  // MARK: ObjectMapper Initializers
  /**
   Map a JSON object to this class using ObjectMapper
   - parameter map: A mapping from ObjectMapper
  */
    public required init?(map: Map){

  }

  /**
  Map a JSON object to this class using ObjectMapper
   - parameter map: A mapping from ObjectMapper
  */
  public func mapping(map: Map) {
    wednesday <- map[kFoodDataWeekDietDataWednesdayKey]
    monday <- map[kFoodDataWeekDietDataMondayKey]
    thursday <- map[kFoodDataWeekDietDataThursdayKey]
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = wednesday { dictionary[kFoodDataWeekDietDataWednesdayKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = monday { dictionary[kFoodDataWeekDietDataMondayKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = thursday { dictionary[kFoodDataWeekDietDataThursdayKey] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

}
