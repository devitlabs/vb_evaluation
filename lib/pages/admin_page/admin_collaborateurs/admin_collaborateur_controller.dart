import 'dart:convert';
import 'package:get/get.dart';
import 'package:vb_performance/utils/utils.dart';
import '../../../config/config.dart';
import '../../../models/collaborateur_model.dart';
import 'package:http/http.dart' as http;

class AdminCollaborateurController extends GetxController {
  final collaborateurs = <CollaborateurModel>[].obs;
  final filteredCollaborateurs = <CollaborateurModel>[].obs;
  final isLoading = false.obs;

  void filterCollaborateurs(String filter) {
    if (filter.isEmpty) {
      filteredCollaborateurs.value = collaborateurs;
    } else {
      filteredCollaborateurs.value = collaborateurs.where((collaborateur) {
        return collaborateur.email.toLowerCase().contains(filter.toLowerCase());
      }).toList();
    }
  }

  Future getAllCollaborateurs() async {
    isLoading.value = true;
    final String apiUrl = "${BASE_URL}/collaborateurs/read-all";
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        var collaborateurList = <CollaborateurModel>[];
        for (var json in jsonData ) {
          collaborateurList.add(CollaborateurModel(
              email: json['EMAIL'],
              motpasse: json['MOTPASSE'],
              nom: json['NOM'],
              prenoms: json['PRENOMS'],
              matricule: json['MATRICULE'],
              dateentreevb: json['DATEENTREEVB'],
              estbloque: json['ESTBLOQUE'],
          ));
        }
        collaborateurs.value = collaborateurList;
        filteredCollaborateurs.value = collaborateurList;
      }
      isLoading.value = false;
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 500));
      isLoading.value = false;
    }
    isLoading.value = false;
  }

  Future<bool> addCollaborateur({required CollaborateurModel collaborateurModel}) async {
    final String apiUrl = "${BASE_URL}/collaborateurs/create";

    final bodyJson = removeNullValues(collaborateurModel.toMap());

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyJson),
      );
      if (response.statusCode == 200) {
        await getAllCollaborateurs();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> deleteCollaborateur({required String email}) async {
    final String apiUrl = "${BASE_URL}/collaborateurs/delete/$email";

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        await getAllCollaborateurs();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> updateCollaborateur({required CollaborateurModel collaborateurModel}) async {
    final String apiUrl = "${BASE_URL}/collaborateurs/update/${collaborateurModel.email}";

    try {
      String requestBodyJson = json.encode(collaborateurModel.toJson());

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: requestBodyJson,
      );
      if (response.statusCode == 200) {
        await getAllCollaborateurs();
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}