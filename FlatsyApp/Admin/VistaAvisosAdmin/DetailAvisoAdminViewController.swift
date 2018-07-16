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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tituloField.text = aviso?.titulo
        descripcionField.text = aviso?.descripcion
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
           else {return}

       
       let aviso = Aviso(
           comunidad:"asadas",
           descripcion: descripcion,
           fecha: NSDate(timeIntervalSince1970: fecha) as Date,
           titulo: titulo
       )

    avisoReference?.setData(aviso.diccionario, completion: { (error) in
        if let error = error{
            print("Error agregando nuevo aviso: \(error)")
        } else {
            print("Document updated")
        }
    })
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
