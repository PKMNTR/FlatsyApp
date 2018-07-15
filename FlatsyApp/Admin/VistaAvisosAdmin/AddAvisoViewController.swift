//
//  AddAvisoViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit

class AddAvisoViewController: UIViewController {

    @IBOutlet weak var tituloField: UITextField!
    @IBOutlet weak var descripcionField: UITextField!
    @IBOutlet weak var fechaField: UIDatePicker!
    @IBOutlet weak var tituloField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onTapAddAviso(_ sender: Any)
    {
        guard let titulo = tituloField.text,
            let descripcion = descripcionField.text,
            let fecha = fechaField.datePicker?.date.timeIntervalsince1970
            else {return}

        let collecttion = Firestore.firestore().collection("comunicados")

        let aviso = Aviso(
            comunidad:"asadas",
            titulo: titulo,
            descripcion: descripcion,
            fecha: fecha,
        )

        let restaurantRef = collection.addDocument(data: aviso.diccionario){ err in
            if let err = err{
                print("Error agregando nuevo aviso: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
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
