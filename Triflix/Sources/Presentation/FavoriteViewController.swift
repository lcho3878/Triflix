//
//  FavoriteViewController.swift
//  Triflix
//
//  Created by 이찬호 on 10/8/24.
//

import UIKit
import RxSwift
import RxCocoa

class FavoriteViewController: UIViewController {
    private let favoriteView = FavoriteView()
    
    private let viewModel = FavoriteViewModel()
    
    private let disposeBag = DisposeBag()
    
    private let viewDidLoadTrigger = PublishSubject<Void>()
    
    private let deleteIndex = PublishSubject<Int>()
    
    override func loadView() {
        view = favoriteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoadTrigger.onNext(())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind()
    }
}

extension FavoriteViewController {
    private func configureUI() {
        title = "내가 찜한 리스트"
    }
}

extension FavoriteViewController {
    private func bind() {
        let input = FavoriteViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger,
            deleteIndex: deleteIndex
        )
        let output = viewModel.transform(input: input)
        
        favoriteView.tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        output.mediaOutput
            .bind(to: favoriteView.tableView.rx.items(cellIdentifier: FavoriteTableViewCell.id, cellType: FavoriteTableViewCell.self)) { row, element, cell in
                cell.configureData(element)
            }
            .disposed(by: disposeBag)
        
        viewDidLoadTrigger.onNext(())
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "밀어서 삭제") { [weak self] _, _, success in
            self?.deleteIndex.onNext(indexPath.row)
            success(true)
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
}
