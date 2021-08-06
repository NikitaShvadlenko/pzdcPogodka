//
//  URL+ExpressibleByLiteral.swift
//  pzdcPogodka
//
//  Created by Vladislav Lisianskii on 06.08.2021.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    // By using 'StaticString' we disable string interpolation, for safety
    public init(stringLiteral literal: StaticString) {
        guard let url = URL(string: "\(literal)") else {
            preconditionFailure("Invalid static URL string: \(literal)")
        }
        self = url
    }
}
