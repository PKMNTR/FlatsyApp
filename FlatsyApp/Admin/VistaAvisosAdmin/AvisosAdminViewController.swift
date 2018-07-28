//
//  AvisosAdminViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/9/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class AvisosAdminViewController: UIViewController {
    
    @IBOutlet weak var avisosTable : UITableView!
    @IBOutlet weak var seleccionTipoAviso : UISegmentedControl!

    var avisos : [Aviso] = []
    var documents : [DocumentSnapshot] = []
    var listener : ListenerRegistration!
    
    var selectedAviso: Aviso?
    var selectedDocumentRef: DocumentReference?
    
    var selectedIndex = Int()
    
    var query : Query?{
        didSet {
            if let listener = listener{
                listener.remove()
            }
        }   
    }
    
    let defaults = UserDefaults.standard

    func baseQuery()->Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("comunicados")
            .whereField("comunidad", isEqualTo: comunidad)
            .order(by: "fecha", descending: true)
    }

    func baseQueryAvisos()->Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("comunicados").whereField("junta", isEqualTo: true)
            .whereField("comunidad", isEqualTo: comunidad)
        .order(by: "fecha", descending: true)
    }

    func baseQueryJuntas()->Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("comunicados").whereField("junta", isEqualTo: false)
            .whereField("comunidad", isEqualTo: comunidad)
            .order(by: "fecha", descending: true)
    }

   override func viewDidLoad() {
        super.viewDidLoad()

        avisosTable.dataSource = self
        avisosTable.delegate = self
        avisosTable.rowHeight = 100
//        avisosTable.rowHeight = UITableViewAutomaticDimension
    
        self.query = baseQuery()       
    }

    override func viewWillAppear(_ animated: Bool) {
        callSnapshot()
    }
   
    @IBAction func segementedChanged(_ sender: Any) {
        
        switch seleccionTipoAviso.selectedSegmentIndex{
        case 0:
            self.query = baseQueryJuntas()
            callSnapshot()
        case 1:
            self.query = baseQueryAvisos()
            callSnapshot()
        default:
            break
        }
    }
    
    func callSnapshot(){
        self.listener = query?.addSnapshotListener{(documents, error) in
            guard let snapshot = documents else{
                print("error")
                return
            }
            
            let results = snapshot.documents.map{(document) -> Aviso in
                if let result = Aviso(diccionario: document.data()){
                    return result
                }
                else {
                    fatalError("unable to initialize with \(document.data()) " )
                }
            }
            
            self.avisos = results
            self.documents = snapshot.documents
            
            self.avisosTable.reloadData()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailAvisoAdmin") {

            selectedAviso = avisos[selectedIndex]
            selectedDocumentRef = documents[selectedIndex].reference

            let vc = segue.destination as! DetailAvisoAdminViewController
            vc.aviso = selectedAviso
            vc.avisoReference = selectedDocumentRef
        }
    }
}

extension AvisosAdminViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avisos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = avisosTable.dequeueReusableCell(withIdentifier: "AvisoAdminCell") as! AvisosAdminTableViewCell
        let aviso = avisos[indexPath.row]
        print(aviso.titulo)
        cell.rellenar(aviso: aviso)
        return cell
    }
}

extension AvisosAdminViewController: UITableViewDelegate{
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
//    let detail = self.storyboard?.instantiateViewController(withIdentifier: "DetailAvisoCtrl") as? DetailAvisoAdminViewController
//
//    detail?.aviso = avisos[indexPath.row]
//    detail?.avisoReference = documents[indexPath.row].reference
//    self.navigationController?.pushViewController(detail!, animated: true)
    selectedIndex = indexPath.row
    performSegue(withIdentifier: "DetailAvisoAdmin", sender: self)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        let aviso = documents[indexPath.row]
        aviso.reference.delete()
    }
  }
}
