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

class AddAvisoViewController: UIViewController {

    @IBOutlet weak var tituloField: UITextField!
    @IBOutlet weak var descripcionField: UITextView!
    @IBOutlet weak var fechaField: UIDatePicker!
    @IBOutlet weak var selectTipoAviso: UISegmentedControl!
    @IBOutlet weak var animView: UIView!
    
    var animationView: LOTAnimationView?
    var ref: DocumentReference! = nil
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LOTAnimationView(name: "success")
        animationView!.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        animView.addSubview(animationView!)
    
        descripcionField!.layer.borderWidth = 0.25
        descripcionField!.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func onTapAddAviso(_ sender: Any)
    {
        guard let titulo = tituloField.text,
            let descripcion = descripcionField.text,
            let fecha = fechaField?.date.timeIntervalSince1970
            else{
                self.crearAlerta(mensaje: "Todos los campos son requeridos")
                return
        }
        
        let comunidad = defaults.object(forKey: "comunidad") as! String

        let collection = Firestore.firestore().collection("comunicados")
        let tipo = selectTipoAviso.selectedSegmentIndex
        var junta: Bool
        if tipo == 0{
            junta = true
        } else{
            junta = false
        }

        let aviso = Aviso(
            comunidad: comunidad,
            descripcion: descripcion,
            fecha: NSDate(timeIntervalSince1970: fecha) as Date,
            titulo: titulo,
            junta: junta
        )

        ref = collection.addDocument(data: aviso.diccionario){ err in
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
}

extension AddAvisoViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        tituloField.resignFirstResponder()
        descripcionField.endEditing(false)
    }
}


