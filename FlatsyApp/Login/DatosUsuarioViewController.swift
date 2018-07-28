//
//  DatosUsuarioViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/21/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class DatosUsuarioViewController: UIViewController {

    @IBOutlet weak var nombreField: UITextField!
    @IBOutlet weak var apellidosField: UITextField!
    @IBOutlet weak var telefonoField: UITextField!
    @IBOutlet weak var viviendaField: UITextField!

    var db: Firestore!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

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
                print("error en tel")
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
                if err != nil{
                    print("Error agregando documento")
                }
                else {
                    self.goToNextScreen()
                    print("exito")
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
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
