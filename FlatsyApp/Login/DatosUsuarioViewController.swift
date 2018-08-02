//
//  DatosUsuarioViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/21/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase
import Lottie

class DatosUsuarioViewController: UIViewController {

    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var apellidosField: UITextField!
    @IBOutlet weak var telefonoField: UITextField!
    @IBOutlet weak var viviendaField: UITextField!
    @IBOutlet weak var animView: UIView!

    var db: Firestore!
    
    let defaults = UserDefaults.standard
    
    var animationView : LOTAnimationView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        animationView = LOTAnimationView(name: "success")
        animationView!.frame = CGRect(x: 0, y: 0, width: 75, height: 75)
        animView.addSubview(animationView!)

        db = Firestore.firestore()
    }

    @IBAction func onTapSendDataCreateUser(){
        guard let nombre = nombreField.text, 
            let apellidos = apellidosField.text,
            let telefono = telefonoField.text,
            let vivienda = viviendaField.text else {
                return
            }

            if !(telefono.count == 8 || telefono.count == 10){
                self.crearAlerta(mensaje: "Numero de telefono invalido")
                telefonoField.text = ""
                return
            }

            self.defaults.set(nombre, forKey: "nombre")
            let uid = self.defaults.object(forKey: "UID") as! String
            let email = self.defaults.object(forKey: "email") as! String
            let comunidad = self.defaults.object(forKey: "comunidad") as! String

            db.collection("usuarios").document(uid).setData([
                "nombre": nombre,
                "apellidos": apellidos,
                "admin": false,
                "telefono": telefono,
                "numero_vivienda": vivienda,
                "email": email,
                "comunidad": comunidad
            ]) { err in
                if let err = err{
                    self.crearAlerta(mensaje: "No se puedo crear el usuario \(err.localizedDescription)")
                }
                else {
                    self.animView.isHidden = false
                    self.animationView!.play(){ (finished) in
                        self.goToNextScreen()
                        print("exito")
                    }
                }
            }
    }
    
    func goToNextScreen(){
        performSegue(withIdentifier: "InicioUsuarios", sender: self)
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
}

extension DatosUsuarioViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        nombreField.resignFirstResponder()
        apellidosField.resignFirstResponder()
        telefonoField.resignFirstResponder()
        viviendaField.resignFirstResponder()
    }
}
