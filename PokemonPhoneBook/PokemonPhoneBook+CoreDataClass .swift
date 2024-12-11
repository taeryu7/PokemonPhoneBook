//
//  PokemonPhoneBook+CoreDataClass .swift
//  PokemonPhoneBook
//
//  Created by 유태호 on 12/10/24.
//

import Foundation
import CoreData

@objc(PokemonPhoneBook)
public class PokemonPhoneBook: NSManagedObject {
    public static let className = "PokemonPhoneBook"
    
    public enum Key {
        static let name = "name"
        static let phoneNumber = "phoneNumber"
        static let profileImage = "profileImage"
    }
}
