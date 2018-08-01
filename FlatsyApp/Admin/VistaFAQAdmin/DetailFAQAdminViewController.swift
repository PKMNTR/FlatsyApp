//
//  FAQViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class DetailFAQAdminViewController: UIViewController {

    var pregunta: Pregunta?
    var preguntaReference: DocumentReference?
//
    @IBOutlet weak var preguntaField: UITextField!
    @IBOutlet weak var respuestaField: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        preguntaField.text = pregunta?.pregunta
        respuestaField.text = pregunta?.respuesta
        
        respuestaField!.layer.borderWidth = 1
        respuestaField!.layer.borderColor = UIColor.gray.cgColor
       
        // Do any additional setup after loading the view.
    }

   @IBAction func onTapUpdateAviso(_ sender: Any)
   {
       guard let pregunta = preguntaField.text,
            let respuesta = respuestaField.text
        else{
            self.crearAlerta(mensaje: "Todos los campos son requeridos")
            return
    }
    

       
       let preguntaModel = Pregunta(
           comunidad:"asadas",
           pregunta: pregunta,
           respuesta: respuesta
       )

    preguntaReference?.setData(preguntaModel.diccionario, completion: { (err) in
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
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        preguntaField.resignFirstResponder()
        respuestaField.endEditing(false)
    }
    
    func crearAlerta(mensaje: String){
        let alert = UIAlertController(title: "Advertencia", message: mensaje, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}

extension DetailFAQAdminViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
