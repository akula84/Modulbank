//
//  Parser.swift
//  SwiftAPIWrapper
//
//  Created by Alexander Kozin on 27.03.16.
//  Copyright © 2016 el-machine. All rights reserved.
//

import Foundation

protocol APIParser: class {

    func parsed(_ rawReply: Any?, to: APIModel.Type) -> Any?

    func models(from array: [Any]) -> [APIModel]

    @discardableResult
    func model(from raw: Any) -> APIModel?


    var model: APIModel? {get set}

}

class Parser: NSObject, APIParser {

    var modelClass: APIModel.Type!
    var model: APIModel? {
        didSet {
            if let model = self.model {
                modelClass = type(of: model)
            }
        }
    }
    
    private lazy var propertyMappingCache: [String: String] = self.modelClass.propertyMapping()
    private lazy var classMappingCache: [String: String] = self.modelClass.classMapping()

    ///  Parses reply to array of objects or object, entry point for parsing
    ///
    /// - Parameters:
    ///   - rawReply: object for parse (from backend)
    ///   - to: class for parsing
    /// - Returns: Array of objects or object
    func parsed(_ rawReply: Any?, to: APIModel.Type) -> Any? {
        modelClass = to

        if let rawObject = rawReply as? [String: Any] {
            return model(from: rawObject)
        }

        if let rawObjectsArray = rawReply as? [Any] {
            return models(from: rawObjectsArray)
        }

        return nil
    }
    
    /**
     Parses array of objects
     Calls objectFromDictionary: iteratively

     - parameter modelClass: Class for parsing data to
     - parameter array:      Array of dictionaries that represent an object

     - returns: Array of parsed objects
     */
    func models(from array: [Any]) -> [APIModel] {
        var models = [APIModel]()
        models.reserveCapacity(array.count)

        for raw in array {
            models.appendOptional(model(from: raw))

            //Prevent parsing all data to one stored model for array parcing
            model = nil
        }
        
        return models
    }

    /**
     Parses object with property values filled according to source object

     - parameter modelClass: Class for parsing data to
     - parameter source:     Source dictionary which represents object

     - returns: Parsed object
     */
    @discardableResult
    func model(from raw: Any) -> APIModel? {
        guard let dictionary = raw as? AliasDictionary else {
            return nil
        }

        if model == nil {
            model = modelClass.init()
        }

        for (key, value) in dictionary {
            parse(value, forKey: key)
        }

        return model
    }

    func parse(_ value: Any, forKey key: String) {

        // We should use mapping because some values should be saved to different keys
        // E.g. we should save value for key 'id' to key 'uid'
        // That's why we should use mapping
        // If key isn't exist in map we should convert it from backend representation
        // To our camel style

        // Try to find property name in mapping first
        var keyToSet = propertyMappingCache[key]
        if keyToSet == nil {
            // Convert key to property name
            keyToSet = propertyName(from: key)
            
            // And save it to mapping
            propertyMappingCache[key] = keyToSet
        }

        // Try to find class in mapping first
        var className = classMappingCache[key]
        // If can't find
        if className == nil {
            // Convert key to class name
            className = self.className(for: value, from: key)
            
            // And save it to mapping
            // Don't care it's class or not, just cache it to prevent converting again
            classMappingCache[key] = className
        }

        // Try to convert key to model class
        let valueToSet: Any?

        // Firstly we should check maybe key is some of our classes?
        if let objectClass = APIUtils.swiftClassFromString(className!) as? APIModel.Type {
            // If class exist, parse value to model
            valueToSet = Parser().parsed(value, to: objectClass) ?? value
        } else {
            // Otherwise just use value
            valueToSet = value
        }
        
        // And set value (parsed or not) to property
        guard let key = keyToSet else {
            return
        }
        model?.setValue(valueToSet, forKey: key)
    }

}
