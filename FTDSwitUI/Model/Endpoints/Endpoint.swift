//
//  Endpoint.swift
//  FTDSwitUI
//
//  Created by Jon E on 11/5/21.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var headers: [String: String] { get }
    var method: String { get }
}
