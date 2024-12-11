//
//  pokemonPhoneBook+CoreDataProperties.swift
//  PokemonPhoneBook
//
//  Created by 유태호 on 12/10/24.
//

import Foundation
import CoreData

extension PokemonPhoneBook {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonPhoneBook> {
        return NSFetchRequest<PokemonPhoneBook>(entityName: "PokemonPhoneBook")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var profileImage: String?
}

extension PokemonPhoneBook : Identifiable {
}
