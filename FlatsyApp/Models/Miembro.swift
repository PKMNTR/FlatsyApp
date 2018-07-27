import Foundation
import Firebase

struct Miembro {
    
    var comunidad: String
    var nombre: String
    var apellidos: String
    var email: String
    var admin: Bool
    var telefono: String
    var numero_vivienda: String

    
    var diccionario : [String: Any] {
        return [
            "comunidad": comunidad,
            "nombre" : nombre,
            "apellidos" : apellidos,
            "email" : email,
            "admin" : admin,
            "telefono" : telefono,
            "numero_vivienda" : numero_vivienda
        ]
    }
}

extension Miembro {
    init?(diccionario: [String : Any]) {
        guard let comunidad = diccionario["comunidad"] as? String,
        let nombre = diccionario["nombre"] as? String,
        let apellidos = diccionario["apellidos"] as? String,
        let email = diccionario["email"] as? String,
        let admin = diccionario["admin"] as? Bool,
        let telefono = diccionario["telefono"] as? String,
        let numero_vivienda = diccionario["numero_vivienda"] as? String
        else {return nil}
           
        self.init(comunidad: comunidad,nombre: nombre, apellidos: apellidos ,email: email, admin: admin, telefono: telefono, numero_vivienda: numero_vivienda)
  }
}
