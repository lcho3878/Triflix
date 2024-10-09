//
//  CastResult.swift
//  Triflix
//
//  Created by 이찬호 on 10/10/24.
//

import Foundation

struct CastResult: Decodable {
    let id: Int
    let cast: [Cast]
    let crew: [Cast]
    
    var actor: [Cast] {
        var result = [Cast]()
        let crews = cast + crew
        for person in crews {
            if person.department == "Acting" {
                result.append(person)
            }
            if result.count == 3 {
                return result
            }
        }
        return result
    }
    
    var director: [Cast] {
        var result = [Cast]()
        let crews = cast + crew
        for person in crews {
            if person.department == "Directing" {
                result.append(person)
            }
            if result.count == 3 {
                return result
            }
        }
        return result
    }
    
    struct Cast: Decodable {
        let name: String
        let department: String
        
        enum CodingKeys: String, CodingKey {
            case name
            case department = "known_for_department"
        }
    }
}
