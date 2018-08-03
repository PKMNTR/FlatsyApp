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
    @IBOutlet weak var diasRestantesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let pagoLocal = pago else {return}
        
        conceptoLabel.text = pagoLocal.concepto
        descripcionLabel.text = pagoLocal.descripcion
        descripcionLabel.sizeToFit()
        precioLabel.text = "$" + pagoLocal.precio.description + " MXN"
        diaPagoLabel.text = pagoLocal.dia_pago.description + " de cada mes"
        let dia = calculaDiasPago(diaPago: pagoLocal.dia_pago)
        diasRestantesLabel.text = "Restan " + dia.description + " dias para el pago"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func calculaDiasPago(diaPago: Int) -> Int{
        let calendar = Calendar.current
        let date = Date()
        
        let currentDay = calendar.component(.day, from: date)
        let interval = calendar.dateInterval(of: .month, for: date)!
        let days = calendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        print(days)
        if diaPago == currentDay{
            return 0
        }else if diaPago > currentDay{
            return diaPago - currentDay
        } else{
            return ((days - currentDay) + diaPago)
        }
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

