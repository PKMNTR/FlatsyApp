//
//  FAQUserViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class FAQUserViewController: UIViewController {

    @IBOutlet weak var preguntasTable : UITableView!

    var preguntas : [Pregunta] = []
    var documents : [DocumentSnapshot] = []
    var listener : ListenerRegistration!

    var selectedPregunta: Pregunta?

    var selectedIndex = Int()

    var query : Query?{
        didSet {
            if let listener = listener{
                listener.remove()
            }
        }   
    }

    override func viewDidLoad() {
        super.viewDidLoad()

         preguntasTable.dataSource = self
        preguntasTable.delegate = self
        preguntasTable.rowHeight = 100
    
        self.query = baseQuery()   
    }

    func baseQuery()->Query{
        return Firestore.firestore().collection("faq")
    }

    override func viewWillAppear(_ animated: Bool) {
        self.listener = query?.addSnapshotListener{(documents, error) in
            guard let snapshot = documents else{
                print("error")
                return
            }
                        
            let results = snapshot.documents.map{(document) -> Pregunta in
                if let result = Pregunta(diccionario: document.data()){
                    return result
                }
                else {
                    fatalError("unable to initialize with \(document.data()) " )
                }
            }
            
            self.preguntas = results
            self.documents = snapshot.documents
            
            self.preguntasTable.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DetailFAQUser") {
            selectedPregunta = preguntas[selectedIndex]
            
            let vc = segue.destination as! FAQDetailUserViewController
            vc.pregunta = selectedPregunta
        }
    }

}

extension FAQUserViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preguntas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = preguntasTable.dequeueReusableCell(withIdentifier: "FAQUserCell") as! FAQUserTableViewCell
        let pregunta = preguntas[indexPath.row]
        print(pregunta.pregunta)
        cell.rellenar(pregunta: pregunta)
        return cell
    }
}

extension FAQUserViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "DetailFAQUser", sender: self)
    }
}
