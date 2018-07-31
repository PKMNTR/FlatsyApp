//
//  PagosDetailUserViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/22/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class PagosDetailUserViewController: UIViewController {

    var pago: Pago?

    @IBOutlet weak var conceptoLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var precioLabel: UILabel!
    @IBOutlet weak var diaPagoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        conceptoLabel.text = pago?.concepto
        descripcionLabel.text = pago?.descripcion
        precioLabel.text = pago?.precio.description
        diaPagoLabel.text = pago?.dia_pago.description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
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
