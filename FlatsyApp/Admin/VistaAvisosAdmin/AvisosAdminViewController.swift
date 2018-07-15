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
    var documents : [DocumentSnapshot]= []
    var listener : ListenerRegistration!

    var query : Query?(
        didSet {
            if let listener = listener{
                listener.remove
            }
        }   
    )

    func baseQuery()->Query{
        return Firestore.firestore().collection(avisos).limit(to:50)
    }

    let data = ["uno","dos"]

    override func viewDidLoad() {
        super.viewDidLoad()

        avisosTable.dataSource = self
        avisosTable.delegate = self
    }

    override func viewWillAppear()
    {
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
                    print("error")
                }
            }

            self.avisos = results
            self.documents = snapshot.documents

            self.avisosTable.reloadData
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

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AvisosAdminViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avisos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = avisosTable.dequeueReusableCell(withIdentifier: "AvisoAdminCell") as! AvisosAdminTableViewCell
        let aviso = avisos[indexPath.row]
        cell.rellenar(aviso: aviso)
        return cell
    }
}

extension AvisosAdminViewController: UITableViewDelegate{
    
}
