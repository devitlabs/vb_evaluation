import 'dart:convert';

class CollaborateurModel {
  String email;
  String? motpasse;
  String? nom;
  String? prenoms;
  String? matricule;
  String? dateentreevb;
  bool? estbloque;

  CollaborateurModel({
    required this.email,
    this.motpasse,
    this.nom,
    this.prenoms,
    this.matricule,
    this.dateentreevb,
    this.estbloque,
  });

  factory CollaborateurModel.fromJson(String str) => CollaborateurModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  bool isCompleteProfil() {
    return email.isNotEmpty &&
        nom != null && nom!.isNotEmpty &&
        prenoms != null && prenoms!.isNotEmpty &&
        matricule != null && matricule!.isNotEmpty &&
        dateentreevb != null && dateentreevb!.isNotEmpty;
  }

  factory CollaborateurModel.fromMap(Map<String, dynamic> json) => CollaborateurModel(
    email: json["EMAIL"],
    motpasse: json["MOTPASSE"],
    nom: json["NOM"],
    prenoms: json["PRENOMS"],
    matricule: json["MATRICULE"],
    dateentreevb: json["DATEENTREEVB"],
    estbloque: json["ESTBLOQUE"],
  );

  Map<String, dynamic> toMap() => {
    "EMAIL": email,
    "MOTPASSE": motpasse,
    "NOM": nom,
    "PRENOMS": prenoms,
    "MATRICULE": matricule,
    "DATEENTREEVB": dateentreevb,
    "ESTBLOQUE": estbloque,
  };
}
