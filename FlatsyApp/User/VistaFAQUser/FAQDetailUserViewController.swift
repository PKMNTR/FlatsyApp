//
//  FAQDetailViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/22/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class FAQDetailViewController: UIViewController {

    var pregunta: Pregunta?

    @IBOutlet weak var preguntaField: UILabel!
    @IBOutlet weak var respuestaField: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        preguntaLabel.text = pregunta?.pregunta
        respuestaLabel.text = pregunta?.respuesta
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
