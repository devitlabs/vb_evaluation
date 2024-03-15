class DirectionModel {
  final String id;
  final String libelle;

  DirectionModel({
    required this.id,
    required this.libelle,
  });

  factory DirectionModel.fromJson(Map<String, dynamic> json) {
    return DirectionModel(
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
