//
//  TestSpy.swift
//  TestSpy
//
//  Created by Franco Meloni on 03/04/2018.
//  Copyright © 2018 Franco Meloni. All rights reserved.
//
// https://github.com/f-meloni/TestSpy

protocol TestSpy {
    associatedtype Method: Equatable
    var callstack: CallstackContainer<Method> { get }
}

extension TestSpy {
    public func check<P: CallstackPredicate>(method: Method, predicate: P) -> Bool where P.Method == Method {
        return callstack.check(method: method, predicate: predicate)
    }
}
