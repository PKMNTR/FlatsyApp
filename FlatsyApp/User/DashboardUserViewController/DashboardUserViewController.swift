//
//  DashboardUserViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/22/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class DashboardUserViewController: UIViewController {
    
    @IBOutlet weak var bienvenidalabel: UILabel!
    @IBOutlet weak var avisoImage: UIImage!
    @IBOutlet weak var pagoImage: UIImage!
    @IBOutlet weak var tituloLastAviso: UILabel!
    @IBOutlet weak var tituloLastPago: UILabel!
    
    let defaults = UserDefaults.standard

    var queryAviso : Query?
    var queryPago : Query?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nombre = defaults.object(forKey: "nombre") as! String
        let hour = Calendar.current.component(.hour, from: Date())
        if hour > 0 && hour < 8{
            bienvenidalabel.text = "Buena noche" + " " + nombre
        }
        if hour >= 8 && hour < 12{
            bienvenidalabel.text = "Buen dia" + " " + nombre
        }
        if hour >= 12 && hour < 18{
            bienvenidalabel.text = "Buena tarde" + " " + nombre
        }
        if hour >= 18 && hour < 24{
            bienvenidalabel.text = "Buena noche" + " " + nombre
        }

        self.queryAviso = queryAviso()
        queryAviso.getDocument { (document, error) in
            if let city = document.flatMap({
                $0.data().flatMap({ (data) in
                    return Aviso(dictionary: data)
                })
            }) {
                 print("City: \(city)")
            } else {
                print("Document does not exist")
            }
        }
        
        
    }

    func queryAviso()->Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("comunicados")
            .whereField("comunidad", isEqualTo: comunidad)
            .order(by: "fecha", descending: true)
            .limit(to: 1)
    }
    
    func queryPago()->Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("pagos")
            .whereField("comunidad", isEqualTo: comunidad)
            .order(by: "fecha", descending: true)
            .limit(to: 1)
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
