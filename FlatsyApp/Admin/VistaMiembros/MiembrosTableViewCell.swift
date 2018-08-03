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
     @IBOutlet weak var telefonoLabel : UILabel!
     @IBOutlet weak var numeroLabel : UILabel!

    func rellenar(miembro: Miembro){
        nombreLabel.text = miembro.nombre + " " + miembro.apellidos
        nombreLabel.sizeToFit()
        telefonoLabel.text = "Telefono: " + miembro.telefono
        numeroLabel.text = "Numero de casa: " + miembro.numero_vivienda
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
