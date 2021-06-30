//
//  HomeViewController.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var viewModel: BaseViewModel = .init()
    
    // MARK: - IB Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Overidden Instance Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        title = "The Milky Way"
    }
    
    // MARK: - Private Instance Methods
    private func configureTableView() {
        tableView.separatorStyle = .none
    }
    
    // MARK: - Instance Methods
    func bind() {
        
    }
}
