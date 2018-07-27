


import Foundation
import Firebase

struct Aviso {
    
    var comunidad: String
    var descripcion : String
    var fecha : Date
    var titulo : String
    var junta : Bool
    
    var diccionario : [String: Any] {
        return [
            "comunidad" : comunidad,
            "descripcion" : descripcion,
            "fecha" : fecha,
            "titulo" : titulo,
            "junta" : junta
        ]
    }
}

extension Aviso {
    init?(diccionario: [String : Any]) {
        guard let comunidad = diccionario["comunidad"] as? String,
        let descripcion = diccionario["descripcion"] as? String,
        let fecha = diccionario["fecha"] as? Timestamp,
        let titulo = diccionario["titulo"] as? String,
        let junta = diccionario["junta"] as? Bool
        else {return nil}
        
        let timestamp:Date = fecha.dateValue()
           
        self.init(comunidad: comunidad,descripcion: descripcion, fecha: timestamp ,titulo: titulo, junta: junta)
  }
}
