//
//  AddAvisoViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class AddPagoViewController: UIViewController {

    @IBOutlet weak var conceptoField: UITextField!
    @IBOutlet weak var descripcionField: UITextView!
    @IBOutlet weak var precioField: UITextField!
    @IBOutlet weak var diaPagoField: UITextField!
    
    var ref: DocumentReference! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let defaults = UserDefaults.standard

    @IBAction func onTapAddAviso(_ sender: Any)
    {
        guard let concepto = conceptoField.text,
            let descripcion = descripcionField.text,
            let precio = precioField.text,
            let diaPago = diaPagoField.text
            else {return}

        let collection = Firestore.firestore().collection("pagos")
        
        let comunidad = defaults.object(forKey: "comunidad") as! String

        let pago = Pago(
            comunidad: comunidad,
            concepto: concepto,
            dia_pago: Int(diaPago)!,
            precio: Double(precio)!,
            descripcion: descripcion,
            recurrente: true,
            fecha: NSDate(timeIntervalSince1970: NSDate().timeIntervalSince1970) as Date
        )

        ref = collection.addDocument(data: pago.diccionario){ err in
            if let err = err{
                print("Error agregando nuevo aviso: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
            }
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
