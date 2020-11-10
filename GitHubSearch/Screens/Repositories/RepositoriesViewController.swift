//
//  RepositoriesViewController.swift
//  GitHubSearch
//
//  Created by Philip on 10.11.2020.
//

import UIKit

class RepositoriesViewController: BaseViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var emptyListLabel: UILabel!
    
    private let repositoryCellId = String(describing: RepositoryCell.self)
    
    private var repositories: [Repository] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
    }
    
    // MARK: Private methods
    
    private func setupSubviews() {
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: repositoryCellId, bundle: nil), forCellReuseIdentifier: repositoryCellId)
        tableView.tableFooterView = UIView()
    }
    
    // TODO: Bad impementation
    // TODO: Add Error case (403)
    private func handleRepositoriesFetched(_ repositories: Repositories?) {
        guard let fetchedRepositories = repositories?.items, !fetchedRepositories.isEmpty else {
            emptyListLabel.text = "Nothing found"
            emptyListLabel.isHidden = false
            self.repositories = []
            return
        }
        
        self.repositories = fetchedRepositories
        emptyListLabel.isHidden = true
    }
    
    private func handleError(_ error: NSError) {
        emptyListLabel.text = "Error occured"
        emptyListLabel.isHidden = false
        self.repositories = []
    }
    
    // MARK: API
    
    private func loadRepositories(withString string: String) {
        showActivityIndicator()
        
        NetworkService.getRepositories(withString: string) { [weak self] result, error in
            DispatchQueue.main.async { [weak self] in
                self?.hideActivityIndicator()
                if let error = error {
                    self?.handleError(error)
                } else {
                    self?.handleRepositoriesFetched(result)
                }
            }
        }
    }

}

// MARK: - UISearchBarDelegate

extension RepositoriesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else { return repositories = [] }
        loadRepositories(withString: searchText)
    }
    
}

// MARK: - UITableViewDataSource

extension RepositoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: repositoryCellId) as? RepositoryCell else { return UITableViewCell() }

        let repository = repositories[indexPath.row]
        let cellModel = RepositoryCellModel(name: repository.fullName ?? "",
                                        description: repository.description,
                                        starsCount: repository.stargazersCount ?? 1)
        
        cell.setup(with: cellModel)
        
        return cell
        
    }
    
}
