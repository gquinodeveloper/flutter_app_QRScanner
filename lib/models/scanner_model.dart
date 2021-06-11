//Creado el modelo volver al db_provider
class ScannerModel {
  int id;
  String tipo;
  String valor;

  ScannerModel({
    this.id,
    this.tipo,
    this.valor,
  });

   //Convierte el archivo Json en un modelo ScannerModelo
  factory ScannerModel.fromJson(Map<String, dynamic> json) => ScannerModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );
  
  //Conviene el modelo en un archivo Json tipo MAP
  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
