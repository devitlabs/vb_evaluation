class ExerciceModel {
  final String ID;
  final int ANNEE;
  final String ETAT;
  final String PHASE;
  final String DATEDEBUT;
  final String DATEFIN;
  final String PFIXOBJECTIFS;
  final String PEVALMPARCOURS;
  final String PEVALFINALE;

  ExerciceModel({
    required this.ID,
    required this.ANNEE,
    required this.ETAT,
    required this.PHASE,
    required this.DATEDEBUT,
    required this.DATEFIN,
    required this.PFIXOBJECTIFS,
    required this.PEVALMPARCOURS,
    required this.PEVALFINALE,
  });

  factory ExerciceModel.fromJson(Map<String, dynamic> json) {
    return ExerciceModel(
      ID: json['ID'] as String,
      ANNEE: json['ANNEE'] as int,
      ETAT: json['ETAT'] as String,
      PHASE: json['PHASE'] as String,
      DATEDEBUT: json['DATEDEBUT'] as String,
      DATEFIN: json['DATEFIN'] as String,
      PFIXOBJECTIFS: json['PFIXOBJECTIFS'] as String,
      PEVALMPARCOURS: json['PEVALMPARCOURS'] as String,
      PEVALFINALE: json['PEVALFINALE'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': ID,
      'ANNEE': ANNEE,
      'ETAT': ETAT,
      'PHASE': PHASE,
      'DATEDEBUT': DATEDEBUT,
      'DATEFIN': DATEFIN,
      'PFIXOBJECTIFS': PFIXOBJECTIFS,
      'PEVALMPARCOURS': PEVALMPARCOURS,
      'PEVALFINALE': PEVALFINALE,
    };
  }
}
