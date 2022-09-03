import 'dart:convert';

import 'package:ena_desktop/utils/utils.dart';
import 'package:get/get.dart';

class AbsenceController extends GetxController {
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

  AbsenceConnexion absenceConnexion = AbsenceConnexion();
  //
  saveAgent() async {
    Response response = await absenceConnexion.allAgent();
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      l1.value = response.body;

      //Get.back();
      //Get.snackbar("Effectué", "Enregistrement éffectué avec succé!");
    }
  }

  Future<List> saveAgent2() async {
    Response response = await absenceConnexion.allAgent();
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      List l = response.body;
      //print("J'ai la l une foi: $l");
      return l;

      //Get.back();
      //Get.snackbar("Effectué", "Enregistrement éffectué avec succé!");
    } else {
      return [];
    }
  }

  //
  saveEleve() async {
    Response response = await absenceConnexion.allEleve();
    if (response.isOk) {
      //
      l2.value = response.body;
      //Get.back();${Utils.url}/absence/all/8/06
      //Get.snackbar("Effectué", "Enregistrement éffectué avec succé!");
    }
  }

  absence(Map<String, dynamic> u) async {
    Response response = await absenceConnexion.absence(u);
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
        int va = 0;
        var df = dd.add(Duration(hours: va));
        print("jours: ${df}");
        Map<String, dynamic> ja = {
          "motifs": u["motifs"],
          "date": "$df",
          "idutilisateur": u["idutilisateur"]
        };
        //on ajoute
        if (df.weekday != 7) {
          //Tous les jours sauf dimanche...
          Response rep = await absenceConnexion.saveJourabsence(ja);
          print(rep.statusCode);
          //print(rep.body);
        }

        va = t * 24;
        t++;
      }
      //
      Get.back();
      http: //localhost:8080/absence/all/8/06
      Get.snackbar("Effectué", "Enregistrement éffectué avec succé!");
    }
  }
}

class AbsenceConnexion extends GetConnect {
  Future<Response> allAgent() async => await get(
        "${Utils.url}/agent/all",
      );

  Future<Response> allEleve() async => await get(
        "${Utils.url}/eleve/all",
      );
  Future<Response> absence(Map<String, dynamic> u) async =>
      await post("${Utils.url}/absence/save", jsonEncode(u));

  Future<Response> saveJourabsence(Map<String, dynamic> jour) async =>
      await post("${Utils.url}/absence/savejourabscent", jsonEncode(jour));
}
