//
//  MiembrosTableViewCell.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class MiembrosTableViewCell: UITableViewCell {

     @IBOutlet weak var nombreLabel : UILabel!

    func rellenar(miembro: Miembro){
        nombreLabel.text = miembro.nombre
        nombreLabel.sizeToFit()
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
