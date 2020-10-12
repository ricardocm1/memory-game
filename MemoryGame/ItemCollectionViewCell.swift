//
//  ItemCollectionViewCell.swift
//  MemoryGame
//
//  Created by Ricardo Carra Marsilio on 12/10/20.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    func reveal(card: Card) {
        UIView.transition(
            with: self,
            duration: 0.5,
            options: .transitionCrossDissolve,
            animations: {
                self.imageView.image = UIImage(named: card.show ? card.image : "Card")
            },
            completion: nil)
    }
}
