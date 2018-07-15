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

    var query : Query?{
        didSet {
            if let listener = listener{
                listener.remove()
            }
        }   
    }

    func baseQuery()->Query{
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings

        return Firestore.firestore().collection("comunicados")
    }

    func baseQueryAvisos()->Query{
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings

        return Firestore.firestore().collection("comunicados").whereField("junta", isEqualTo: true)
    }

    func baseQueryJuntas()->Query{
        let db = Firestore.firestore()
        let settings = db.settings
        settings.areTimestampsInSnapshotsEnabled = true
        db.settings = settings

        return Firestore.firestore().collection("comunicados").whereField("junta", isEqualTo: false)
    }

   override func viewDidLoad() {
        super.viewDidLoad()

        avisosTable.dataSource = self
        avisosTable.delegate = self
        
        self.query = baseQuery()       
    }

    override func viewWillAppear(_ animated: Bool) {
        self.listener = query?.addSnapshotListener{(documents, error) in
            guard let snapshot = documents else{
                print("error")
                return
            }
            
            let results = snapshot.documents.map{(document) -> Aviso in
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
   
    @IBAction func segmentedControlAction(sender: AnyObject){
        if seleccionTipoAviso.selectedSegmentIndex == 0{
            muestraAvisos()
        } else{
            muestraJuntas()
        }
    }

    func muestraAvisos(){

    }

    func muestraJuntas(){

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailAvisoAdminView") {
            var vc = segue.destinationViewController as DetailAvisoAdminViewController 
            vc.aviso = avisos[indexPath.row]
            vc.avisoReference = documents[indexPath.row].reference
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

    }
}