//
//  Card.swift
//  MemoryGame
//
//  Created by Ricardo Carra Marsilio on 12/10/20.
//

import Foundation

public class Card {
    
    let id: Int
    let image: String
    let identifier: String
    var show: Bool = false
    
    internal init(id: Int, image: String) {
        self.id = id
        self.image = image
        self.identifier = "\(image)_\(id)"
    }
}
