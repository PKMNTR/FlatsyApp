//
//  FAQUserTableViewCell.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class FAQUserTableViewCell: UITableViewCell {

    @IBOutlet weak var preguntaLabel : UILabel!
    @IBOutlet weak var respuestaLabel: UILabel!

    func rellenar(pregunta: Pregunta){
        preguntaLabel.text = pregunta.pregunta
        preguntaLabel.sizeToFit()
        
        respuestaLabel.text = pregunta.respuesta
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
