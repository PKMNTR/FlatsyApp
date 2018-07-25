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
    @IBOutlet weak var fechaLabel: UILabel!
   
    let dateFormatter = DateFormatter()

    func rellenar(aviso: Aviso){
        dateFormatter.dateStyle = .medium
        
        testLabel.text = aviso.titulo
        testLabel.sizeToFit()
        
        fechaLabel.text = dateFormatter.string(from: aviso.fecha)
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
