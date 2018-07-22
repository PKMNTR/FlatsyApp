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

    @IBOutlet weak var codigoField: UITextField

    var db: Firestore!

    override func viewDidLoad() {
        super.viewDidLoad()

        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
    }

    @IBAction func onTapCheckComunidad(){
        guard let codigo = codigoField.text else {
            return
        }

        let docRef = db.collection("comunidad").document(codigo)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let defaults = UserDefaults.standard
                defaults.set(self.codigoField.text, forKey: "comunidad")
                performSegue(withIdentifier: "DatosUsuario", sender: self)
            } else {
                print("No existe la comunidad")
                codigoField.text = ""
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

}
