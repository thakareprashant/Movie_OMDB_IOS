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
    func configureCell(model:MovieViewModel){
        if let url = URL(string: model.search.Poster ?? ""){
            imageV.load(url: url) { (isSuccess) in
                
            };
        }
        
         movieNameLbl.text = model.search.Title;
        releaseYearLbl.text = "Released Year : \(model.search.Year ?? "")";
        
    }

}
