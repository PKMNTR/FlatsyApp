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
            else {return}

       
       let preguntaModel = Pregunta(
           comunidad:"asadas",
           pregunta: pregunta,
           respuesta: respuesta
       )

    preguntaReference?.setData(preguntaModel.diccionario, completion: { (error) in
        if let error = error{
            print("Error agregando nuevo pregunta: \(error)")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailFAQAdminViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
