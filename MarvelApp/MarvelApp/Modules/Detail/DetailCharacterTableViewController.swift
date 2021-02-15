//
//  DetailCharacterTableViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 15/02/21.
//

import UIKit

class DetailCharacterTableViewController: UITableViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var presenter: ViewToPresenterDetailCharacterProtocol?
    var delegateComics: ComicsUpdate?
    var delegateSeries: SeriesUpdate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fill()
        presenter?.getSeriesAndComics()
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 300.0
        self.navigationController?.navigationBar.topItem?.title = presenter?.navigationTitle()

    }
    
    private func fill() {
        descriptionLabel.text = presenter?.fillDescription()
        presenter?.fillImage()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ExtrasCollectionViewController {
            self.delegateComics = destination
        }
        if let destination = segue.destination as? SeriesCollectionViewController {
            self.delegateSeries = destination
        }
    }
}

extension DetailCharacterTableViewController: PresenterToViewDetailCharacterProtocol {
    func updateWithImage(image: UIImage) {
        characterImage.image = image
    }
    
    func updateWithStringImage(stringImage: URL) {
        characterImage.kf.setImage(with: stringImage)
    }
    
    func updateComics(action: ActionCell, customLayout: CustomFlowLayout) {
        delegateComics?.update(character: presenter?.getCurrentCharacter(), action: action, customLayout: customLayout)
    }
    
    func updateSeries(action: ActionCell, customLayout: CustomFlowLayout) {
        delegateSeries?.update(character: presenter?.getCurrentCharacter(), action: action, customLayout: customLayout)
    }
}

