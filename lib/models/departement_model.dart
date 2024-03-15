class DepartementModel {
  final String id;
  final String libelle;

  DepartementModel({
    required this.id,
    required this.libelle,
  });

  factory DepartementModel.fromJson(Map<String, dynamic> json) {
    return DepartementModel(
      id: json['ID'],
      libelle: json['LIBELLE'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'LIBELLE': libelle,
    };
  }
}
