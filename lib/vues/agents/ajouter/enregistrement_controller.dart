import 'dart:convert';
import 'dart:io';
import 'package:ena_desktop/utils/utils.dart';
import 'package:ena_desktop/vues/abscence/abscence_controller.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class EnregistrementController extends GetxController {
  //
  EnregistrementConnexion enregistrementConnexion = EnregistrementConnexion();

  //
  RxString sexeC = 'F'.obs;
  RxString nEtude = "Licence".obs;
  RxString fonction = "Licence".obs;
  RxString division = "Licence".obs;
  RxString bureau = "Licence".obs;
  RxString grade = "Chef de Division".obs;
  RxList<String> options1 = RxList([
    "Responsable Finances",
    "Conseiller Juridique RGRH",
    "Responsable Recrutement et Scolaire",
    "Responsable Audit Interne",
    "Responsable Relations Publiques et Protocole",
    "Responsable Formation Continue",
    "Responsable Bibliothèque",
    "Responsable Stages et Recherche",
    "Responsable Partenariat",
    "Trésorière",
    "Scrétaire de Direction",
    "Responsable Log-SP CGPMP",
  ]);
  RxString option1 = "Responsable Finances".obs;
  //
  List<String> options2 = RxList([
    "Bureau Technique et maintenance",
    "Bureau Reception et Sécurité",
    "Bureau Courriers",
    "Bureau Programme Formation Continue",
    "Cellule Communication",
    "Comptable Public"
  ]);
  RxString option2 = "Bureau Technique et maintenance".obs;
  //
  RxList<String> options3 = RxList([
    "Classement et Archivage / Bibliothèque",
    "Cellule Charroi",
    "Traitement Documentaire / Bibliothèque",
    "Accueil et Op./Bibliothèque"
  ]);
  RxString option3 = "Classement et Archivage / Bibliothèque".obs;
  //
  RxList<String> options4 = RxList(
      ["Chauffeur", "Hotesse d'Acceuil", "Technicien Reception et Sécurité"]);
  RxString option4 = "Chauffeur".obs;
  //
  RxList<String> options5 = RxList(["Technicien de Surface"]);
  RxString option5 = "Technicien de Surface".obs;
  //
  RxList<String> options6 = RxList([]);
  RxString option6 = "".obs;

  saveAgent(Map<String, dynamic> u, String path) async {
    Response response = await enregistrementConnexion.saveAgent(u);
    if (response.isOk) {
      //
      var id = response.body["id"];
      //http.Response rep = await
      enregistrementConnexion.photo(path, id);
      //print("Lll ${rep.statusCode}");
      //print("Ll2 ${rep.body}");
      Get.back();
      Get.snackbar("Effectué", "Enregistrement éffectué avec succé!");
    } else {
      //
      Get.back();
      Get.snackbar("Erreur", "Code d'erreur: ${response.statusCode}!");
    }
  }

  //
  saveEleve(Map<String, dynamic> e, String path) async {
    Response response = await enregistrementConnexion.saveEleve(e);
    if (response.isOk) {
      //
      var id = response.body["id"];
      //http.Response rep = await
      enregistrementConnexion.photo(path, id);
      //print("Lll ${rep.statusCode}");
      //print("Ll2 ${rep.body}");
      //
      Get.back();
      Get.snackbar("Effectué", "Enregistrement éffectué avec succé!");
    } else {
      //
      Get.back();
      Get.snackbar("Erreur", "Code d'erreur: ${response.statusCode}");
    }
  }

  //
  update_agent(Map<String, dynamic> u, bool v, String path) async {
    Response response = await enregistrementConnexion.update_agent(u);
    if (response.isOk) {
      if (v) {
        var id = response.body["id"];
        enregistrementConnexion.photo(path, id);
      }
      //
      Get.back();
      Get.snackbar("Effectué", "Modification éffectué avec succé!");
      //
      //
      AbsenceController controller = Get.find();
      //
      controller.saveAgent();
      controller.saveEleve();
      //
    } else {
      //
      Get.back();
      Get.snackbar("Erreur", "Modification non éffectué avec succé!");
    }
  }

  update_eleve(Map<String, dynamic> u, bool v, String path) async {
    Response response = await enregistrementConnexion.update_eleve(u);
    if (response.isOk) {
      if (v) {
        var id = response.body["id"];
        enregistrementConnexion.photo(path, id);
      }
      //
      Get.back();
      Get.snackbar("Effectué", "Modification éffectué avec succé!");
      //
      //
      AbsenceController controller = Get.find();
      //
      controller.saveAgent();
      controller.saveEleve();
      //
    } else {
      //
      Get.back();
      Get.snackbar("Erreur ${response.statusCode}",
          "Modification non éffectué avec succé! ${response.body}");
    }
  }
}

class EnregistrementConnexion extends GetConnect {
  Future<Response> saveAgent(Map<String, dynamic> u) async =>
      await post("${Utils.url}/agent/save", jsonEncode(u));

  Future<Response> saveEleve(Map<String, dynamic> u) async =>
      await post("${Utils.url}/eleve/save", jsonEncode(u));

  Future<Response> update_agent(Map<String, dynamic> u) async =>
      await put("${Utils.url}/agent/update", jsonEncode(u));

  Future<Response> update_eleve(Map<String, dynamic> u) async =>
      await put("${Utils.url}/eleve/update", jsonEncode(u));

  photo(String path, var idpiece) async {
    var photo = await File(path).readAsBytes();

    final form = FormData({
      "file": MultipartFile(
        File(path).readAsBytesSync(),
        filename: path.split("/").last,
      )
    });
    List<int> vv = File(path).readAsBytesSync();
    print(vv.length);

    http.Response rep = await http.post(
      Uri.parse("${Utils.url}/piecejointe/save/$idpiece"),
      body: vv,
      headers: {"Content-Type": "application/octet-stream"},
    );
    //
    print('st: ${rep.statusCode}');
    if (true) print('Uploaded! ${rep.body}');
  }
}
