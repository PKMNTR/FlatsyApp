//
//  PagosUserTableViewCell.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class PagosUserTableViewCell: UITableViewCell {

    @IBOutlet weak var conceptoLabel : UILabel!
    @IBOutlet weak var precioLabel: UILabel!

    func rellenar(pago: Pago){
        conceptoLabel.text = pago.concepto
        conceptoLabel.sizeToFit()
        
        precioLabel.text = "$" + String(format: "%.2f", pago.precio)
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
