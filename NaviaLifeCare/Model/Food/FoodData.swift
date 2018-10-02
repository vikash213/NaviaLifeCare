//
//  FoodData.swift
//  NaviaLifeCare
//
//  Created by vikash kumar on 10/2/18.
//  Copyright © 2018 NaviaLifeCare. All rights reserved.
//

import Foundation
import ObjectMapper

public class FoodData: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private let kFoodDataMealTimeKey: String = "meal_time"
    private let kFoodDataImageKey: String = "image"
    private let kFoodDataFoodKey: String = "food"
    
    // MARK: Properties
    public var mealTime: String?
    public var image: String?
    public var food: String?
    
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
        mealTime <- map[kFoodDataMealTimeKey]
        image <- map[kFoodDataImageKey]
        food <- map[kFoodDataFoodKey]
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = mealTime { dictionary[kFoodDataMealTimeKey] = value }
        if let value = image { dictionary[kFoodDataImageKey] = value }
        if let value = food { dictionary[kFoodDataFoodKey] = value }
        return dictionary
    }
    
}

