//
//  ListCharactersTableViewController.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 13/02/21.
//

import UIKit

class ListCharactersTableViewController: UITableViewController, PresenterToViewListCharactersProtocol {
    
    var presenter: ViewToPresenterListCharactersProtocol?


    var charactersss: [Character] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
         presenter?.getCharacters()
        
//        let teste = ListCharactersInteractor()
//        teste.getCharacters { (characters, error) in
//            if let characters = characters {
//                self.charactersss = characters
//                self.tableView.reloadData()
//            }
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

   
    func getCharactersSuccess() {
//        charactersss = characters
        tableView.beginUpdates()
        let deadlineTime = DispatchTime.now() + .seconds(5)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            self.tableView.reloadData()
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.updateViewConstraints()
            self.loadViewIfNeeded()
        }
        tableView.reloadData()
//        self.tableView.reloadData()
//        self.updateViewConstraints()
//        self.loadViewIfNeeded()
    }
    
    func getCharactersFail(errorMessage: String) {
        print(errorMessage)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = presenter?.getCharacter(index: indexPath.row)?.name
        // Configure the cell...

        return cell
    }
    
}
