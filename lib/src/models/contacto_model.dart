

class ContactoModel {

  int id;
  String nombre;
  String alias;
  String empresa;
  String numero;

  ContactoModel({
    this.id,
    this.nombre,
    this.alias,
    this.empresa,
    this.numero
  });

  ContactoModel.fromJson( Map<String, dynamic> json ) {

    id = json["id"];
    nombre = json["nombre"];
    alias = json["alias"];
    empresa = json["empresa"];
    numero = json["numero"];

  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> tempMap = new Map<String, dynamic>();
    
    tempMap["nombre"] = this.nombre;
    tempMap["alias"] = this.alias;
    tempMap["empresa"] = this.empresa;
    tempMap["numero"] = this.numero;

    return tempMap;

  }

}