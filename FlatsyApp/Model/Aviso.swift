


import Foundation

struct Aviso{

    var descripcion : String
    var titulo : String
    var fecha : Date

    var diccionario : [String: Any] {
        return [
            "titulo" : titulo,
            "fecha" : fecha,
            "descripcion" : descripcion,
        ]
    }
}

extension Aviso : DocumentSerializable{
    init?(diccionario: [String : Any]) {
    guard let titulo = diccionario["titulo"] as? String,
        let descripcion = diccionario["descripcion"] as? String,
        let fecha = diccionario["fecha"] as? Date,
           
    self.init(titulo: titulo, descripcion: descripcion, fecha: fecha)
  }
}