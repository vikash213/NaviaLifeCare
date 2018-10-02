//
//  FoodDataBaseClass.swift
//
//  Created by vikash kumar on 10/2/18
//  Copyright (c) Naive. All rights reserved.
//

import Foundation
import ObjectMapper

public class FoodDataBaseClass: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kFoodDataBaseClassWeekDietDataKey: String = "week_diet_data"
  private let kFoodDataBaseClassDietDurationKey: String = "diet_duration"

  // MARK: Properties
  public var weekDietData: FoodDataWeekDietData?
  public var dietDuration: Int?

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
    weekDietData <- map[kFoodDataBaseClassWeekDietDataKey]
    dietDuration <- map[kFoodDataBaseClassDietDurationKey]
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = weekDietData { dictionary[kFoodDataBaseClassWeekDietDataKey] = value.dictionaryRepresentation() }
    if let value = dietDuration { dictionary[kFoodDataBaseClassDietDurationKey] = value }
    return dictionary
  }

}
