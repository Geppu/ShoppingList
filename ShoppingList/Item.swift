//
//  Item.swift
//  ShoppingList
//
//  Created by Mark Burpee on 2021/03/31.
//

class Item: Codable
    {
    var name: String
    init(name: String)
    {
        self.name = name
    }
    //Make the data in this class "Item" codable in UserDefaults
    enum CodingKeys: String, CodingKey{
        case name
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
