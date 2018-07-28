//
//  AvisosUserViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class AvisosUserViewController: UIViewController {

    @IBOutlet weak var avisosTable : UITableView!
    @IBOutlet weak var seleccionTipoAviso : UISegmentedControl!

    var avisos : [Aviso] = []
    var documents : [DocumentSnapshot] = []
    var listener : ListenerRegistration!

    var selectedAviso: Aviso?

    var selectedIndex = Int()
    
    let defaults = UserDefaults.standard
    
    var query : Query?{
        didSet {
            if let listener = listener{
                listener.remove()
            }
        }   
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        avisosTable.dataSource = self
        avisosTable.delegate = self
        avisosTable.rowHeight = 100
    
        self.query = baseQuery()
    }

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

    override func viewWillAppear(_ animated: Bool) {
        callSnapshot()
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
    @IBAction func segmentedChange(_ sender: Any) {
        
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
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailAvisoUser") {

            selectedAviso = avisos[selectedIndex]

            let vc = segue.destination as! AvisosDetailUserViewController
            vc.aviso = selectedAviso
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

}

extension AvisosUserViewController: UITableViewDataSource {

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avisos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = avisosTable.dequeueReusableCell(withIdentifier: "AvisoUserCell") as! AvisosUserTableViewCell
        let aviso = avisos[indexPath.row]
        print(aviso.titulo)
        cell.rellenar(aviso: aviso)
        return cell
    }    
}

extension AvisosUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "DetailAvisoUser", sender: self)
    }    
}
