//
//  FAQViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class DetailAvisoAdminViewController: UIViewController {

    var aviso: Aviso?
    var avisoReference: DocumentReference?
//
    @IBOutlet weak var tituloField: UITextField!
    @IBOutlet weak var descripcionField: UITextView!
    @IBOutlet weak var fechaField: UIDatePicker!
    @IBOutlet weak var selectTipoAviso: UISegmentedControl!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descripcionField!.layer.borderWidth = 1
        descripcionField!.layer.borderColor = UIColor.gray.cgColor
        tituloField.text = aviso?.titulo
        descripcionField.text = aviso?.descripcion
        if let junta = aviso?.junta{
            if junta {
                selectTipoAviso.selectedSegmentIndex = 0
            }
            else{
                selectTipoAviso.selectedSegmentIndex = 1
            }
        }
        if let fecha = aviso?.fecha{
             fechaField.setDate(fecha, animated: true)
        }
       
        // Do any additional setup after loading the view.
    }
    

   @IBAction func onTapUpdateAviso(_ sender: Any)
   {
       guard let titulo = tituloField.text,
           let descripcion = descripcionField.text,
           let fecha = fechaField?.date.timeIntervalSince1970
            else{
            self.crearAlerta(mensaje: "Todos los campos son requeridos")
            return
        }
        let tipo = selectTipoAviso.selectedSegmentIndex
        var junta: Bool
        if tipo == 0{
            junta = true
        } else{
            junta = false
        }
    
        let comunidad = defaults.object(forKey: "comunidad") as! String
       
        let aviso = Aviso(
           comunidad: comunidad,
           descripcion: descripcion,
           fecha: NSDate(timeIntervalSince1970: fecha) as Date,
           titulo: titulo,
           junta: junta
       )

    avisoReference?.setData(aviso.diccionario, completion: { (err) in
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
        tituloField.resignFirstResponder()
        descripcionField.endEditing(false)
    }
}

extension DetailAvisoAdminViewController: UITextViewDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
}
