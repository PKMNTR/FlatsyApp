//
//  AddAvisoViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class AddFAQViewController: UIViewController {

    @IBOutlet weak var preguntaField: UITextField!
    @IBOutlet weak var respuestaField: UITextView!
    
    var ref: DocumentReference! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTapAddAviso(_ sender: Any)
    {
        guard let pregunta = preguntaField.text,
            let respuesta = respuestaField.text
            else {return}

        let collection = Firestore.firestore().collection("faq")

        let preguntaModel = Pregunta(
            comunidad:"asadas",
            pregunta: pregunta,
            respuesta: respuesta
        )

        ref = collection.addDocument(data: preguntaModel.diccionario){ err in
            if let err = err{
                print("Error agregando nueva pregunta: \(err)")
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
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
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
