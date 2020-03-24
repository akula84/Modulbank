//
//  Array+Utils.swift
//  MPM
//
//  Created by Alex Kozin on 09.07.2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    @discardableResult
    mutating
    func remove(_ object: Array.Element) -> Array.Element? {
        guard let index = self.firstIndex(of: object) else {
            return nil
        }

        return remove(at: index)
    }
    
    @discardableResult
    public mutating func removeOptional(at index: Int?) -> Element? {
        guard let index = index else {return nil}
        return remove(at: index)
    }

    public mutating func append(_ newElement: Element?) {
        if let element = newElement {
            append(element)
        }
    }
    
    func firstIndexOptional(of element: Element?) -> Int? {
        guard let element = element  else {
            return nil
        }
        return firstIndex(of: element)
    }
}

extension Array where Element: Any {
    
    func valueAt(_ index: Int?) -> Element? {
        guard let index = index,
            index < count,
            index >= 0  else {
                return nil
        }
        return self[index]
    }
    
    public mutating func appendOptional(_ newElement: Element?) {
        if let element = newElement {
            append(element)
        }
    }
    
    public mutating func appendOptional(_ newElements: [Element]?) {
        if let newElements = newElements {
            append(contentsOf: newElements)
        }
    }
    
    public mutating func insertOptional(_ newElement: Element?, at i: Int?) {
        guard let newElement = newElement, let i = i else {
            return
        }
        insert(newElement, at: i)
    }
}

extension Array where Element: Equatable {
    
    public func containsOptional(_ element: Element?) -> Bool {
        guard let element = element else {
            return false
        }
        return contains(element)
    }
    
}
