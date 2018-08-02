//
//  FAQViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase
import Lottie

class DetailFAQAdminViewController: UIViewController {

    var pregunta: Pregunta?
    var preguntaReference: DocumentReference?
//
    @IBOutlet weak var preguntaField: UITextField!
    @IBOutlet weak var respuestaField: UITextView!
    @IBOutlet weak var animView: UIView!
    
    var animationView: LOTAnimationView?
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LOTAnimationView(name: "success")
        animationView!.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        animView.addSubview(animationView!)
        
        preguntaField.text = pregunta?.pregunta
        respuestaField.text = pregunta?.respuesta
        
        respuestaField!.layer.borderWidth = 0.25
        respuestaField!.layer.borderColor = UIColor.lightGray.cgColor
       
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
    
        let comunidad = defaults.object(forKey: "comunidad") as! String
    
        let preguntaModel = Pregunta(
           comunidad: comunidad,
           pregunta: pregunta,
           respuesta: respuesta
        )

        preguntaReference?.setData(preguntaModel.diccionario, completion: { (err) in
        if let err = err{
            self.crearAlerta(mensaje: "No se puedo crear el usuario \(err.localizedDescription)")
        } else {
            self.animView.isHidden = false
            self.animationView!.play(){ (finished) in
                self.navigationController?.popViewController(animated: true)
            }
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
