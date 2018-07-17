import Foundation
import Firebase

struct Pago {
    
    var comunidad: String
    var concepto: String
    var dia_pago: Int
    var precio: Double
    var descripcion:String
    var recurrente: Bool
    var fecha: Date
    
    var diccionario : [String: Any] {
        return [
            "comunidad": comunidad,
            "concepto": concepto,
            "dia_pago": dia_pago,
            "precio": precio,
            "descripcion":descripcion,
            "recurrente": recurrente,
            "fecha": fecha,
        ]
    }
}

extension Pago {
    init?(diccionario: [String : Any]) {
        guard let comunidad = diccionario["comunidad"] as? String,
        let concepto = diccionario["concepto"] as? String,
        let dia_pago = diccionario["dia_pago"] as? Int,
        let precio = diccionario["precio"] as? Double,
        let descripcion = diccionario["descripcion"] as? String,
        let recurrente = diccionario["recurrente"] as? Bool,
        let fecha = diccionario["fecha"] as? Timestamp
        else  {return nil}
        
        let timestamp:Date = fecha.dateValue()

        self.init(comunidad: comunidad,concepto: concepto,dia_pago : dia_pago, precio : precio, descripcion:descripcion ,recurrente : recurrente, fecha: timestamp)
  }
}
