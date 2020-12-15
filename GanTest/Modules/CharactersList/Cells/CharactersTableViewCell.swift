//
//  CharactersTableViewCell.swift
//  GanTest
//
//  Created by Eduardo Nieto on 15/12/2020.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    var viewModel: CharacterViewModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        characterNameLabel.text = viewModel?.name
        if let urlString = viewModel?.image, let url = URL(string: urlString) {
            characterImage.downloaded(from: url)
        }

    }
    
    func set(viewModel: CharacterViewModel?) {
        self.viewModel = viewModel
    }
    
    

}
