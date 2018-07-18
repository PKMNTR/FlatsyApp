//
//  FAQViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class DetailPagoAdminViewController: UIViewController {

    var pago: Pago?
    var pagoReference: DocumentReference?
//
    @IBOutlet weak var conceptoField: UITextField!
    @IBOutlet weak var descripcionField: UITextView!
    @IBOutlet weak var precioField: UITextField!
    @IBOutlet weak var diaPagoField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
       concpetoField.text = pago?.concepto
       descripcionField.text = pago?.descripcion
       precioField.text = pago?.precio
       diaPagoField.text = pago?.dia_pago
    //    if let fecha = pago?.fecha{
    //         fechaField.setDate(fecha, animated: true)
    //    }
       
        // Do any additional setup after loading the view.
    }

   @IBAction func onTapUpdatePago(_ sender: Any)
   {
     guard let concepto = conceptoField.text,
            let descripcion = descripcionField.text,
            let precio = precioField.text,
            let diaPago = diaPagoField.text
            else {return}

      
       let pago = Pago(
            comunidad:"asadas",
            concepto: concepto,
            dia_pago: Int(diaPago)!,
            precio: Double(precio)!,
            descripcion: descripcion,
            recurrente: true,
            fecha: NSDate(timeIntervalSince1970: NSDate().timeIntervalSince1970) as Date
       )

       pagoReference?.setData(pago.diccionario, completion: { (error) in
       if let error = error{
           print("Error agregando nuevo aviso: \(error)")
       } else {
           print("Document updated")
       }
   })
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
