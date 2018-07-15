//
//  AvisosAdminTableViewCell.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class AvisosAdminTableViewCell: UITableViewCell {
    
    @IBOutlet weak var testLabel : UILabel!

    func rellenar(aviso: Aviso = nil, junta: Junta = nil){
        if aviso == nil && jnuta == nil{
            return
        }

        if aviso =! nil{
            testLabel.text = aviso.titulo
        } else {
            testLabel.text = junta.titulo
        }
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
