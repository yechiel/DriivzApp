//
//  NewsArticleViewController.swift
//  DriivzApp
//
//  Created by Yechiel Amar on 28/03/2023.
//

import UIKit

class NewsFeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    lazy var viewModel = {
        NewsFeedViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        initViewModel()
    }

    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        tableView.register(NewsArticleCell.nib, forCellReuseIdentifier: NewsArticleCell.identifier)
    }

    func initViewModel() {
        // Get employees data
        viewModel.getNewsFeed()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.title = self?.viewModel.title
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDelegate
extension NewsFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsArticleViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsArticleViewController") as! DetailsArticleViewController
        detailsArticleViewController.cellViewModel = viewModel.getCellViewModel(at: indexPath)
        self.navigationController?.pushViewController(detailsArticleViewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension NewsFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsArticleCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsArticleCell.identifier, for: indexPath) as? NewsArticleCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
