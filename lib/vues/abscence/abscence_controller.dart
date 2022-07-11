import 'dart:convert';

import 'package:get/get.dart';

class AbscenceController extends GetxController {
  //
  RxList l1 = [].obs;
  //
  RxList l2 = [].obs;
  //
  int v = 0;
  //
  @override
  onInit() {
    // while (v < 11) {
    //   l.add({"nom": "$v", "postnom": "$v", "matricule": "$v"});
    // }
  }

  AbscenceConnexion abscenceConnexion = AbscenceConnexion();
  //
  saveAgent() async {
    Response response = await abscenceConnexion.allAgent();
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      l1.value = response.body;
      //Get.back();
      //Get.snackbar("Success", "Enregistrement éffectué avec succé!");
    }
  }

  //
  saveEleve() async {
    Response response = await abscenceConnexion.allEleve();
    if (response.isOk) {
      //
      l2.value = response.body;
      //Get.back();http://localhost:8080/abscence/all/8/06
      //Get.snackbar("Success", "Enregistrement éffectué avec succé!");
    }
  }

  abscence(Map<String, dynamic> u) async {
    Response response = await abscenceConnexion.abscence(u);
    if (response.statusCode == 200 || response.statusCode == 200) {
      /**
       * "dateDebut": "$dtDebut",
          "dateFin": "$dtFin"
      */
      print("d1: ${u["dateDebut"]}");
      print("d2: ${u["dateFin"]}");
      Duration d = DateTime.parse(u["dateFin"])
          .difference(DateTime.parse(u["dateDebut"]));
      int j = d.inDays;
      print("dif1: $d");
      print("dif2: $j");
      int t = 0;
      var dd = DateTime.parse(u["dateDebut"]);
      while (t <= j) {
        var df = dd.add(Duration(hours: t * 24));
        print("jours: ${df}");
        Map<String, dynamic> ja = {
          "motifs": u["motifs"],
          "date": "$df",
          "idutilisateur": u["idutilisateur"]
        };
        //on ajoute
        Response rep = await abscenceConnexion.saveJourAbscence(ja);
        print(rep.statusCode);
        //print(rep.body);
        t++;
      }
      //
      Get.back();
      http: //localhost:8080/abscence/all/8/06
      Get.snackbar("Success", "Enregistrement éffectué avec succé!");
    }
  }
}

class AbscenceConnexion extends GetConnect {
  Future<Response> allAgent() async => await get(
        "http://localhost:8080/agent/all",
      );

  Future<Response> allEleve() async => await get(
        "http://localhost:8080/eleve/all",
      );
  Future<Response> abscence(Map<String, dynamic> u) async =>
      await post("http://localhost:8080/abscence/save", jsonEncode(u));

  Future<Response> saveJourAbscence(Map<String, dynamic> jour) async =>
      await post(
          "http://localhost:8080/abscence/savejourabscent", jsonEncode(jour));
}
