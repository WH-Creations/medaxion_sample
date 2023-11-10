//
//  Config.swift
//  medaxion_sample
//
//  Created by Casey West on 11/10/23.
//
import Foundation

class Config {
    static let shared = Config()

    private var values: [String: Any] = [:]

    private init() {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let values = NSDictionary(contentsOfFile: path) as? [String: Any] {
            self.values = values
        }
    }

    func value(forKey key: String) -> Any? {
        return values[key]
    }
}
