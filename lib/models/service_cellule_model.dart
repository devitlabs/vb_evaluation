class ServiceCelluleModel {
  final String id;
  final String type;
  final String libelle;

  ServiceCelluleModel({
    required this.id,
    required this.type,
    required this.libelle,
  });

  factory ServiceCelluleModel.fromJson(Map<String, dynamic> json) {
    return ServiceCelluleModel(
      id: json['ID'],
      type: json['TYPE'],
      libelle: json['LIBELLE'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'TYPE': type,
      'LIBELLE': libelle,
    };
  }
}
