//
//  EnvironmentConfiguration.swift
//  chameleon
//
//  Created by Ilia Chub on 02.12.2023.
//

import Foundation

final class EnvironmentConfiguration {
    enum Error: Swift.Error {
        case missingKey
        case invalidValue
        case missingValue
    }
    
    static func value<T: LosslessStringConvertible>(for key: String) throws -> T {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }
        guard let string = object as? String, string.isEmpty == false else {
            throw Error.missingValue
        }
        guard let value = T(string) else {
            throw Error.invalidValue
        }
        
        return value
    }
    
    static func checkValue(for key: String) {
        do {
            let stringValue: String = try value(for: key)
            print("Find \(key): \(stringValue)")
        } catch EnvironmentConfiguration.Error.missingKey {
            print("Missing key \(key). Add key to Info.plist file")
        } catch EnvironmentConfiguration.Error.missingValue {
            print("Missing value for key \(key)")
        } catch EnvironmentConfiguration.Error.invalidValue {
            print("Invalid value for key \(key)")
        } catch {
            print("Undefind error for key: \(key)")
        }
    }
}
