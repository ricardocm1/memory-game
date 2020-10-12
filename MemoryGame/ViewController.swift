//
//  ViewController.swift
//  MemoryGame
//
//  Created by Ricardo Carra Marsilio on 10/10/20.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "ItemCollectionViewCell"
    var game: MemoryGame = MemoryGame.newGame()
    
    @IBAction func resetGameButtonTouched(_ sender: Any) {
        newGame()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    func setupCollectionViewItems() {
        if (collectionViewFlowLayout == nil) {
            let lineSpacing: CGFloat = 2
            let internItemSpacing: CGFloat = 2
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: 130, height: 130)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = internItemSpacing
            
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        setupCollectionViewItems()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        game.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ItemCollectionViewCell
                
        let card = game.cards[indexPath.item]
        let image = game.cardsFound.contains(where: { currentCard in return card.identifier == currentCard.identifier }) ||
            game.attemptCards.contains(where: { currentCard in return card.identifier == currentCard.identifier }) ? game.cards[indexPath.item].image : "Card"
                
        cell.imageView.image = UIImage(named: image)
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell else {
            return
        }
        
        if !game.isShowingCards {
            game.attempt(cardIndex: indexPath.item)
                    
            if game.attemptCards.count == 2 {
                game.isShowingCards = true
                        
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.game.isShowingCards = false
                    self.game.resetAttemptCards()
                    collectionView.reloadData()
                }
            }
                    
            if game.cards[indexPath.item].show {
                cell.reveal(card: game.cards[indexPath.item])
                collectionView.reloadData()
            }
                    
            if game.endGame {
                self.showMessage()
            }
        }
    }
    
    private func newGame() {
        game = MemoryGame.newGame()
        collectionView.reloadData()
    }
    
    func showMessage() {
        let alert = UIAlertController(title: "Boa, você terminou!", message: "Você precisou de \(game.attempts) tentativas para finalizar o jogo.", preferredStyle: .alert)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
    
    var alertAction: UIAlertAction {
        UIAlertAction(title: "Bacana, bora de novo", style: .default, handler: { _ in self.newGame()})
   }
}
