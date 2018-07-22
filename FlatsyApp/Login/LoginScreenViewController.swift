//
//  FAQViewController.swift
//  FlatsyApp
//
//  Created by user140663 on 7/10/18.
//  Copyright © 2018 pkmntr. All rights reserved.
//

import UIKit
import Firebase

class LoginScreenViewController: UIViewController {

    @IBOutlet weak var selectForm: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var loginText: UILabel!

    var signin: Bool = true

    var query: Query?
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil{
            print(Auth.auth().currentUser?.email)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.query = baseQuery()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func baseQuery()->Query{
        return Firestore.firestore().collection("usuarios")
    }

    @IBAction func onTapSendButton(){
        if self.signin == true{
            registerUser()
        }
        else{
            loginUser()
        }
    }

    @IBAction func onTapChangeForm() {
        emailField.text = ""
        passwordField.text = ""
        if self.signin == true{
            selectForm.setTitle("Inscribete", for: .normal)
            loginText.text = "¿Aun no tienes cuenta?"
            loginLabel.text = "Inicia Sesion"
            self.signin = false
        }
        else{
            selectForm.setTitle("Inicia sesion", for: .normal)
            loginText.text = "¿Ya tienes cuenta?"
            loginLabel.text = "Inscribete"
            self.signin = true
        }
    }

    func loginUser(){
        if let email = emailField.text, let password = passwordField.text{
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if user != nil{
                    print("Usuario autenticsdo")
                    
                    // let lc = LoginViewController()
                    // self.navigationController?.pushViewController(lc, animated: true)
                }
                else{
                    if let error = error?.localizedDescription{
                        print("Error al iniciar sesion por firebase", error)
                    }else{
                        print("Tu eres el error de sesion")
                    }
                }
            }
        }
    }

    func registerUser(){
        if let email = emailField.text, let password = passwordField.text{
            Auth.auth().createUser(withEmail: email, password: password){
                (user,error) in
                if user != nil{
                    print("se creo el usuario")
                    
                    // let values = ["name": email]
                    
                    guard let uid = user?.user.uid,
                        let email = user?.user.email else{
                        return
                    }

                    let defaults = UserDefaults.standard
                    defaults.set(uid, forKey: "UID")
                    defaults.set(email, forKey: "email")

                    self.goToNextScreen()

                    // let userReference = self.ref.child("users").child(uid)
                    
                    // userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                    //     if error != nil {
                    //         print("errror al instertar datos")
                    //         return
                    //     }else{
                    //         print("dato guardado en BD")
                    //     }
                    // })
                }else{
                    if let error = error?.localizedDescription{
                        print("Error al crear el usuario", error)
                    }else{
                        print("tu eres el error :v")
                    }
                }
            }
        }
    }
    
    func goToNextScreen(){
        performSegue(withIdentifier: "CodigoComunidad", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    // }
}
