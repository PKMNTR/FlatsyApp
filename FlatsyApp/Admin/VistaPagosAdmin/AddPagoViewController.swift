//
//  AddAvisoViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase
import Lottie

class AddPagoViewController: UIViewController {

    @IBOutlet weak var conceptoField: UITextField!
    @IBOutlet weak var descripcionField: UITextView!
    @IBOutlet weak var precioField: UITextField!
    @IBOutlet weak var diaPagoField: UITextField!
    @IBOutlet weak var animView: UIView!
    
    var animationView: LOTAnimationView?
    
    var ref: DocumentReference! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LOTAnimationView(name: "success")
        animationView!.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        animView.addSubview(animationView!)
        
        descripcionField!.layer.borderWidth = 0.25
        descripcionField!.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    let defaults = UserDefaults.standard

    @IBAction func onTapAddAviso(_ sender: Any)
    {
        guard let concepto = conceptoField.text,
            let descripcion = descripcionField.text,
            let precio = precioField.text,
            let diaPago = diaPagoField.text
            else{
                self.crearAlerta(mensaje: "Todos los campos son requeridos")
                return
        }

        let collection = Firestore.firestore().collection("pagos")
        
        let comunidad = defaults.object(forKey: "comunidad") as! String

        let pago = Pago(
            comunidad: comunidad,
            concepto: concepto,
            dia_pago: Int(diaPago)!,
            precio: Double(precio)!,
            descripcion: descripcion,
            recurrente: true,
            fecha: Date()
        )

        ref = collection.addDocument(data: pago.diccionario){ err in
            if let err = err{
                self.crearAlerta(mensaje: "No se puedo crear el usuario \(err.localizedDescription)")
            } else {
                self.animView.isHidden = false
                self.animationView!.play(){ (finished) in
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    func crearAlerta(mensaje: String){
        let alert = UIAlertController(title: "Advertencia", message: mensaje, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        conceptoField.resignFirstResponder()
        precioField.resignFirstResponder()
    }
}

extension AddPagoViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
