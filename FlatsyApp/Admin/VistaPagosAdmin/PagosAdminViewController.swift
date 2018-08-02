//
//  PagosAdminViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class PagosAdminViewController: UIViewController {

     @IBOutlet weak var pagosTable : UITableView!
     @IBOutlet weak var seleccionTipoPago : UISegmentedControl!

    var pagos : [Pago] = []
    var documents : [DocumentSnapshot] = []
    var listener : ListenerRegistration!
    
    var selectedPago: Pago?
    var selectedDocumentRef: DocumentReference?

    var query : Query?{
        didSet {
            if let listener = listener{
                listener.remove()
            }
        }   
    }
    
    var selectedIndex = Int()
    
    let defaults = UserDefaults.standard

    func baseQuery()->Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("pagos")
            .whereField("comunidad", isEqualTo: comunidad)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        pagosTable.dataSource = self
        pagosTable.delegate = self
        pagosTable.rowHeight = 100
//        avisosTable.rowHeight = UITableViewAutomaticDimension
    
        self.query = baseQuery()       
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
            
//            self.pagos = self.pagos.sorted(by: {$0.fecha.timeIntervalSince1970 > $1.fecha.timeIntervalSince1970})
            
            self.pagosTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailPagoAdmin") {
            selectedPago = pagos[selectedIndex]
            selectedDocumentRef = documents[selectedIndex].reference
            
            let vc = segue.destination as! DetailPagoAdminViewController
            vc.pago = selectedPago
            vc.pagoReference = selectedDocumentRef
        }
    } 
}

extension PagosAdminViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pagos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pagosTable.dequeueReusableCell(withIdentifier: "PagoAdminCell") as! PagosAdminTableViewCell
        let pago = pagos[indexPath.row]
        print(pago.concepto)
        cell.rellenar(pago: pago)
        return cell
    }
}

extension PagosAdminViewController: UITableViewDelegate{
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
    selectedIndex = indexPath.row
    performSegue(withIdentifier: "DetailPagoAdmin", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        let pago = documents[indexPath.row]
        pago.reference.delete()
    }
  }
}

