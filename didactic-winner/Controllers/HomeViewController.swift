//
//  HomeViewController.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import UIKit

import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: BaseViewModel = .init()
    
    // MARK: - IB Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Overidden Instance Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        bind()
    }
    
    // MARK: - Private Instance Methods
    private func bindTableView(source: Observable<[Item]>) {
        source.bind(to: self.tableView.rx.items(
                cellIdentifier: CustomTableViewCell.className,
                cellType: CustomTableViewCell.self
            )
        ) { (row, item, cell) in
            cell.populateData(item: item)
        }.disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.register(
            UINib(nibName: CustomTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: CustomTableViewCell.className
        )
        tableView
            .rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        tableView.separatorStyle = .none
    }
    
    // MARK: - Instance Methods
    func bind() {
        let output = self.viewModel.bind()
        
        bindTableView(source: output.collection)
        disposeBag.insert(output.title.drive(self.rx.title))
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let dvc = storyboard.instantiateViewController(withIdentifier: DetailViewController.className) as! DetailViewController
        dvc.bind(viewModel: DetailViewModel(item: viewModel.collection.value[indexPath.row]))
        
        navigationController?.pushViewController(dvc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
