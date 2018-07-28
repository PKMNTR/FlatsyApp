//
//  PagosUserViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class PagosUserViewController: UIViewController {

    @IBOutlet weak var pagosTable : UITableView!
    @IBOutlet weak var seleccionTipoPago : UISegmentedControl!

    var pagos : [Pago] = []
    var documents : [DocumentSnapshot] = []
    var listener : ListenerRegistration!

    var selectedPago: Pago?

    var selectedIndex = Int()

    var query : Query?{
        didSet {
            if let listener = listener{
                listener.remove()
            }
        }   
    }
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pagosTable.dataSource = self
        pagosTable.delegate = self
        pagosTable.rowHeight = 100
    
        self.query = baseQuery()   
    }

    func baseQuery()->Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("pagos")
            .whereField("comunidad", isEqualTo: comunidad)
            .order(by: "fecha", descending: true)
        
    }

     override func viewWillAppear(_ animated: Bool) {
        self.listener = query?.addSnapshotListener{(documents, error) in
            guard let snapshot = documents else{
                print("error")
                return
            }
                        
            let results = snapshot.documents.map{(document) -> Pago in
                if let result = Pago(diccionario: document.data()){
                    return result
                }
                else {
                    fatalError("unable to initialize with \(document.data()) " )
                }
            }
            
            self.pagos = results
            self.documents = snapshot.documents
            
            self.pagosTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailPagoUser") {
            selectedPago = pagos[selectedIndex]
            
            let vc = segue.destination as! PagosDetailUserViewController
            vc.pago = selectedPago
        }
    } 

}

extension PagosUserViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pagosTable.dequeueReusableCell(withIdentifier: "PagoUserCell") as! PagosUserTableViewCell
        let pago = pagos[indexPath.row]
        print(pago.concepto)
        cell.rellenar(pago: pago)
        return cell
    }
}

extension PagosUserViewController: UITableViewDelegate{
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    selectedIndex = indexPath.row
    performSegue(withIdentifier: "DetailPagoUser", sender: self)
    }
}

