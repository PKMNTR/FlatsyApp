import Foundation
import Firebase

struct Pago {
    
    var comunidad: String
    var concepto: String
    var diaPago: Int?
    var precio: Float
    var recurrente: Bool
    var fecha: Date?
    
    var diccionario : [String: Any] {
        return [
            "comunidad": comunidad,
            "concepto": concepto,
            "diaPago": diaPago,
            "precio": precio,
            "recurrente": recurrente,
            "fecha": fecha,
        ]
    }
}

extension Aviso {
    init?(diccionario: [String : Any]) {
        guard let comunidad = diccionario["comunidad"] as? String,
        let concepto = diccionario["concepto"] as? String,
        let diaPago = diccionario["diaPago"] as? Int,
        let precio = diccionario["precio"] as? Float,
        let recurrente = diccionario["recurrente"] as? Bool,
        let fecha = diccionario["fecha"] as? Timestamp,
        else {return nil}
        
        let timestamp:Date = fecha.dateValue()
           
        self.init(comunidad: comunidad,concepto: concepto,diaPago : diaPago, precio : precio, recurrente : recurrente , fecha: timestamp)
  }
}
