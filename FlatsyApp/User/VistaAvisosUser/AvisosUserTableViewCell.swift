//
//  AvisosUserTableViewCell.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class AvisosUserTableViewCell: UITableViewCell {

    @IBOutlet weak var testLabel : UILabel!

    func rellenar(aviso: Aviso){
        testLabel.text = aviso.titulo
        testLabel.sizeToFit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
