//
//  Date+Transfrom.swift
//  MPM
//
//  Created by Артем Кулагин on 26/11/2018.
//  Copyright © 2018 Bell Integrator. All rights reserved.
//

import Foundation

extension Date {
    
    var year: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
    
    var month: Int? {
        return Calendar.current.dateComponents([.month], from: self).month
    }
    
    var startOfMonth: Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self))) ?? Date()
    }
    
    func appendMonth(count: Int = 1) -> Date? {
        return Calendar.current.date(byAdding: .month, value: count, to: self)
    }
    
    func appendDay(count: Int = 1) -> Date? {
        return Calendar.current.date(byAdding: .day, value: count, to: self)
    }
    
    func appendHour(count: Int = 1) -> Date? {
        return Calendar.current.date(byAdding: .hour, value: count, to: self)
    }
    
    func appendSecond(count: Int = 1) -> Date? {
        return Calendar.current.date(byAdding: .second, value: count, to: self)
    }
    
    //Костыль. Так как сервер посылает время по Москве (что не правильно) то минусуем 3 часа.
    //В дальнейшем если будут баги, то нужно что бы сервер присылал время по UTC
    var fixServerTimeMoscow: Date? {
        return appendHour(count: -3)
    }
    
    //Костыль. Так как сервер посылаемое время считает по Москве то добавляем к правильному времени 3 часа.
    //В дальнейшем если будут баги, то нужно что бы сервер принимал время по UTC
    var fixToSendServerTimeMoscow: Date? {
        return appendHour(count: 3)
    }
}
