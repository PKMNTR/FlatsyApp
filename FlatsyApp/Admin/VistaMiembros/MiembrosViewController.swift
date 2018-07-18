//
//  MiembrosViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class MiembrosViewController: UIViewController {

    @IBOutlet weak var miembrosTable : UITableView!

    var meiembros : [Miembro] = []
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
        return Firestore.firestore().collection("usuarios").whereField("admin", isEqualTo: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        miembrosTable.dataSource = self
        miembrosTable.delegate = self
        miembrosTable.rowHeight = 100
//        avisosTable.rowHeight = UITableViewAutomaticDimension
    
        self.query = baseQuery()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.listener = query?.addSnapshotListener{(documents, error) in
            guard let snapshot = documents else{
                print("error")
                return
            }
                        
            let results = snapshot.documents.map{(document) -> Miembro in
                if let result = Miembro(diccionario: document.data()){
                    return result
                }
                else {
                    fatalError("unable to initialize with \(document.data()) " )
                }
            }
            
            self.miembros = results
            self.documents = snapshot.documents
            
            self.avisosTable.reloadData()
        }
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

extension MiembrosViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return miembros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = miembrosTable.dequeueReusableCell(withIdentifier: "MiembroCell") as! MiembrosTableViewCell
        let miembro = miembros[indexPath.row]
        
        cell.rellenar(miembro: miembro)
        return cell
    }
}

extension MiembrosViewController: UITableViewDelegate{

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        let aviso = documents[indexPath.row]
        aviso.reference.delete()
    }
  }
}
