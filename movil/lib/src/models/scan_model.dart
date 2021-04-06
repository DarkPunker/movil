import 'dart:convert';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

ScanModel scanModelFromString(List<String> str) {
  final scan = new ScanModel();
  str.forEach((element) {
    if (element.contains("NumFac:")) {
      scan.numFac = element.substring(7).trim();
    }
    if (element.contains("FecFac:")) {
      scan.fecFac = element.substring(7).trim();
    }
    if (element.contains("HorFac:")) {
      scan.horFac = element.substring(7).trim();
    }
    if (element.contains("NitFac:")) {
      scan.nitFac = element.substring(7).trim();
    }
    if (element.contains("NitFac:")) {
      scan.nitFac = element.substring(7).trim();
    }
    if (element.contains("DocAdq:")) {
      scan.docAdq = element.substring(7).trim();
    }
    if (element.contains("ValFac:")) {
      scan.valFac = double.parse(element.substring(7).trim());
    }
    if (element.contains("ValIva:")) {
      scan.valIva = double.parse(element.substring(7).trim());
    }
    if (element.contains("ValOtroIm:")) {
      scan.valOtroIm = double.parse(element.substring(10).trim());
    }
    if (element.contains("ValTolFac:")) {
      scan.valTolFac = double.parse(element.substring(10).trim());
    }
    if (element.contains("ValFacIm:")) {
      scan.valTolFac = double.parse(element.substring(9).trim());
    }
    if (element.contains("CUFE:")) {
      scan.cufe = element.substring(5).trim();
    }
    if (element.contains("QRCode:")) {
      scan.qrcufe = element.substring(7).trim();
    }
  });
  if (scan.numFac == "") {
    return null;
  }
  return scan;
}

class ScanModel {
  ScanModel({
    this.id,
    this.numFac = "",
    this.fecFac = "",
    this.horFac = "",
    this.nitFac = "",
    this.docAdq = "",
    this.valFac = 0,
    this.valIva = 0,
    this.valOtroIm = 0,
    this.valTolFac = 0,
    this.cufe = "",
    this.qrcufe = "",
  });

  int id;
  String numFac;
  String fecFac;
  String horFac;
  String nitFac;
  String docAdq;
  double valFac;
  double valIva;
  double valOtroIm;
  double valTolFac;
  String cufe;
  String qrcufe;

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        numFac: json["NumFac"],
        fecFac: json["FecFac"],
        horFac: json["HorFac"],
        nitFac: json["NitFac"],
        docAdq: json["DocAdq"],
        valFac: json["ValFac"].toDouble(),
        valIva: json["ValIva"].toDouble(),
        valOtroIm: json["ValOtroIm"].toDouble(),
        valTolFac: json["ValTolFac"].toDouble(),
        cufe: json["CUFE"],
        qrcufe: json["QRCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "NumFac": numFac,
        "FecFac": fecFac,
        "HorFac": horFac,
        "NitFac": nitFac,
        "DocAdq": docAdq,
        "ValFac": valFac,
        "ValIva": valIva,
        "ValOtroIm": valOtroIm,
        "ValTolFac": valTolFac,
        "CUFE": cufe,
        "QRCode" : qrcufe,
      };
}
