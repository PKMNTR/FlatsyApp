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
    @IBOutlet weak var conceptoField: UITextField!
    @IBOutlet weak var descripcionField: UITextView!
    @IBOutlet weak var precioField: UITextField!
    @IBOutlet weak var diaPagoField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descripcionField!.layer.borderWidth = 1
        descripcionField!.layer.borderColor = UIColor.gray.cgColor
       conceptoField.text = pago?.concepto
       descripcionField.text = pago?.descripcion
       precioField.text = pago?.precio.description
       diaPagoField.text = pago?.dia_pago.description
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
            else{
            self.crearAlerta(mensaje: "Todos los campos son requeridos")
            return
    }
    
      
       let pago = Pago(
            comunidad:"asadas",
            concepto: concepto,
            dia_pago: Int(diaPago)!,
            precio: Double(precio)!,
            descripcion: descripcion,
            recurrente: true,
            fecha: NSDate(timeIntervalSince1970: NSDate().timeIntervalSince1970) as Date
       )

       pagoReference?.setData(pago.diccionario, completion: { (err) in
        if let err = err{
            self.crearAlerta(mensaje: "No se puedo crear el usuario \(err.localizedDescription)")
        } else {
           print("Document updated")
       }
   })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func crearAlerta(mensaje: String){
        let alert = UIAlertController(title: "Advertencia", message: mensaje, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        conceptoField.resignFirstResponder()
        descripcionField.endEditing(false)
        precioField.resignFirstResponder()
        diaPagoField.resignFirstResponder()
    }
    
}

extension DetailPagoAdminViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
