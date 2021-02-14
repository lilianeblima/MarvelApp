//
//  ListCharactersViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit

class ListCharactersViewController: UIViewController {
    
    @IBOutlet weak var rightButtonItem: UIBarButtonItem!
    var currentLayoutCollection: CustomLayout = .grid
    @IBAction func changeListStyleAction(_ sender: UIBarButtonItem) {

        var customLayout = CustomLayout.grid
        var buttonTitle = "Lista"
        if currentLayoutCollection == .grid {
            customLayout = CustomLayout.list
            buttonTitle = "Grid"
        }
        
        rightButtonItem.title = buttonTitle
        currentLayoutCollection = customLayout
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(CustomFlowLayout(custom: customLayout), animated: true)
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: ViewToPresenterListCharactersProtocol?
    
    let Array = ["River Cruise", "North Island", "Mountain trail", "Southern Coast", "Fishing Place", "Green Themeland", "Sunset Park"]
    
    var arr: [Character] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let te = ListCharactersInteractor()
        te.getCharacters { (charac, testo) in
            if let charac = charac {
                self.arr = charac
                self.collectionView.reloadData()
            }
        }
       // presenter?.getCharacters()
        collectionView.collectionViewLayout = CustomFlowLayout(custom: .grid)
        collectionView.dataSource = self
        collectionView.delegate = self

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ListCharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource, PresenterToViewListCharactersProtocol {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCell else { //
            return UICollectionViewCell()
        }
        let character = arr[indexPath.row]
        cell.configure(character: character)
        return cell
    }
    
    func getCharactersSuccess() {
        
        DispatchQueue.main.async {
//            self.collectionView.reloadData()
//            self.collectionView.reloadData()
//            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
//            self.collectionView.reloadData()
            self.collectionView.layoutSubviews()
            self.collectionView.reloadData()
//            self.collectionView.updateConstraints()
//            self.collectionView.updateConstraintsIfNeeded()
        }
    }
    
    func getCharactersFail(errorMessage: String) {
        print(errorMessage)
    }
}
