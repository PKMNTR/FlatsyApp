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
    @IBOutlet weak var avisoImage: UIImageView!
    @IBOutlet weak var pagoImage: UIImageView!
    @IBOutlet weak var tituloLastAviso: UILabel!
    @IBOutlet weak var tituloLastPago: UILabel!
    
    let defaults = UserDefaults.standard
    
    var avisos : [Aviso] = []
    var pagos : [Pago] = []
    var documentsAviso : [DocumentSnapshot] = []
    var documentsPagos : [DocumentSnapshot] = []
    
    var query : Query? {
        didSet{
            if let listener = listener {
                listener.remove()
            }
        }
    }
    
    var listener : ListenerRegistration!
    
    enum Concepto : String{
        case Agua
        case Gas
    }
    
    var selectedPago:Pago?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nombre = defaults.object(forKey: "nombre") as! String
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 0 && hour < 8{
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        query = queryAviso()
        callSnapshotAvisos()
        
        avisoImage.image = #imageLiteral(resourceName: "aviso")
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func queryAviso() -> Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("comunicados")
            .whereField("comunidad", isEqualTo: comunidad)
    }
    
    func queryPago() -> Query{
        let comunidad = defaults.object(forKey: "comunidad") as! String
        return Firestore.firestore().collection("pagos")
            .whereField("comunidad", isEqualTo: comunidad)
    }
    
    func callSnapshotAvisos(){
        guard let query = query else {return}
        listener?.remove()
        
        self.listener = query.addSnapshotListener{(documents, error) in
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
            self.documentsAviso = snapshot.documents
            
            self.avisos = self.avisos.sorted(by: {$0.fecha.timeIntervalSince1970 > $1.fecha.timeIntervalSince1970})
            
            self.tituloLastAviso.text = self.avisos[0].titulo
            self.query = self.queryPago()
            self.callSnapshotPagos()
            
        }
    }
    
    func callSnapshotPagos(){
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
            self.documentsPagos = snapshot.documents
            
            let date = Date()
            let calendar = Calendar.current
            
            let day = calendar.component(.day, from: date)
            var pagosGuardados:[Pago] = []
            var pagoProx: Pago
            for pago in self.pagos{
                if pago.dia_pago > day{
                    pagosGuardados.append(pago)
                }
            }
            
            if pagosGuardados.isEmpty{
                pagoProx = self.pagos.max{$0.dia_pago > $1.dia_pago}!
            } else{
                pagoProx = pagosGuardados.max{$0.dia_pago > $1.dia_pago}!
            }
            
            self.tituloLastPago.text = pagoProx.concepto
            switch pagoProx.concepto{
            case "Agua":
                self.pagoImage.image = #imageLiteral(resourceName: "agua")
            case "Gas":
                self.pagoImage.image = #imageLiteral(resourceName: "gas")
            default:
                self.pagoImage.image = #imageLiteral(resourceName: "pago")
            }
            
            self.selectedPago = pagoProx
        }
    }
    
    @IBAction func onTapLastAviso(_ sender: Any) {
         performSegue(withIdentifier: "DashDetailAvisoUser", sender: self)
    }
    
    @IBAction func onTapNextPayment(_ sender: Any) {
        performSegue(withIdentifier: "DashDetailPagoUser", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "DashDetailAvisoUser") {
            let vc = segue.destination as! AvisosDetailUserViewController
            vc.aviso = avisos[0]
        }
        
        if(segue.identifier == "DashDetailPagoUser") {
            let vc = segue.destination as! PagosDetailUserViewController
            vc.pago = selectedPago
        }
    }

}
