//
//  MovieTableViewCell.swift
//  MovieOMDB
//
//  Created by prashant thakare on 13/07/22.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var releaseYearLbl: UILabel!
    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var movieNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
