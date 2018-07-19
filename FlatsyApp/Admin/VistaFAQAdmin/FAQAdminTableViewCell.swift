//
//  FAQAdminTableViewCell.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class FAQAdminTableViewCell: UITableViewCell {

    @IBOutlet weak var preguntaLabel : UILabel!

    func rellenar(pregunta: Pregunta){
        preguntaLabel.text = pregunta.pregunta
        preguntaLabel.sizeToFit()
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
