

import Foundation
import Firebase

struct Pregunta {
    
    var comunidad: String
    var pregunta : String
    var respuesta : String
    
    var diccionario : [String: Any] {
        return [
            "comunidad" : comunidad,
            "pregunta" : pregunta,
            "respuesta" : respuesta,
        ]
    }
}

extension Pregunta {
    init?(diccionario: [String : Any]) {
        guard let comunidad = diccionario["comunidad"] as? String,
        let pregunta = diccionario["pregunta"] as? String,
        let respuesta = diccionario["respuesta"] as? String
        else {return nil}
           
        self.init(comunidad: comunidad,pregunta: pregunta ,respuesta: respuesta)
  }
}
