//
//  TeamCell.swift
//  Stadium
//
//  Created by Rafael Moura on 16/11/16.
//  Copyright © 2016 BEPiD. All rights reserved.
//

import UIKit

class TreinerCell: UITableViewCell {

    @IBOutlet weak var treinerNameLabel: UILabel!
    @IBOutlet weak var pokemonsCountLabel: UILabel!
    @IBOutlet weak var treinerPicture: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
