//
//  AvisosUserTableViewCell.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class AvisosUserTableViewCell: UITableViewCell {

    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var tituloLabel : UILabel!

    func rellenar(aviso: Aviso){
        tituloLabel.text = aviso.titulo
        tituloLabel.sizeToFit()
        descripcionLabel.text = aviso.descripcion
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
