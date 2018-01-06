//
//  AlternateTableViewCell.swift
//  banregio
//
//  Created by Benjamin on 04/01/18.
//  Copyright © 2018 rodo. All rights reserved.
//

import UIKit

class AlternateTableViewCell: UITableViewCell {

    @IBOutlet weak var hugeCountryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(with countryName:String)
    {
        hugeCountryLabel.text = countryName
    }

}
