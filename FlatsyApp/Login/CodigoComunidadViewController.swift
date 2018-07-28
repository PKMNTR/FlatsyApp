//
//  CodigoComunidadViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/21/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class CodigoComunidadViewController: UIViewController {

    @IBOutlet weak var codigoField: UITextField!
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTapCheckComunidad(){
        guard let codigo = codigoField.text else {
            return
        }

        let docRef = Firestore.firestore().collection("comunidad").document(codigo)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                self.defaults.set(self.codigoField.text, forKey: "comunidad")
                self.goToNextScreen()
            } else {
                print("No existe la comunidad")
                self.codigoField.text = ""
            }
        }
    }
    
    func goToNextScreen(){
        performSegue(withIdentifier: "DatosUsuario", sender: self)
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

extension CodigoComunidadViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        codigoField.resignFirstResponder()
    }
    
}
