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
    private var viewModel: HomeViewModel = .init()
    
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
                cellIdentifier: ItemTableViewCell.className,
                cellType: ItemTableViewCell.self
            )
        ) { (row, item, cell) in
            cell.populateData(item: item)
        }.disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.register(
            UINib(nibName: ItemTableViewCell.className, bundle: nil),
            forCellReuseIdentifier: ItemTableViewCell.className
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
        
        output.error.asObservable().subscribe({ event in
            let error = event.element ?? ""
            
            if error != "" {
                self.showControllerAlert(message: error, title: "Warning")
            }
        }).disposed(by: disposeBag)
        
        output.isLoading.subscribe({ event in
            let isLoading = event.element ?? false
            
            if isLoading {
                self.addBlurView()
            } else {
                self.removeBlurView()
            }
        }).disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let dvc = storyboard.instantiateViewController(withIdentifier: DetailsViewController.className) as! DetailsViewController
        dvc.bind(viewModel: DetailViewModel(item: viewModel.collection.value[indexPath.row]))
        
        navigationController?.pushViewController(dvc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
