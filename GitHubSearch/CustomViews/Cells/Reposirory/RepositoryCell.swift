//
//  RepositoryCell.swift
//  GitHubSearch
//
//  Created by Philip on 10.11.2020.
//

import UIKit

struct RepositoryCellModel {
    var name: String
    var description: String?
    var starsCount: Int = 0
    
    init(name: String, description: String?, starsCount: Int) {
        self.name = name
        self.description = description
        self.starsCount = starsCount
    }
}

class RepositoryCell: UITableViewCell {
    @IBOutlet private weak var fullName: UILabel!
    @IBOutlet private weak var shortDescription: UILabel!
    @IBOutlet private weak var starsCount: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(with model: RepositoryCellModel) {
        fullName.text = model.name
        shortDescription.text = model.description
        starsCount.text = String(model.starsCount)
        
        shortDescription.isHidden = model.description == nil
    }
    
}
