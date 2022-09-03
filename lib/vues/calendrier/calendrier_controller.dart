import 'dart:convert';

import 'package:ena_desktop/utils/utils.dart';
import 'package:get/get.dart';

class CalendrierController extends GetxController {
  //
  RxList l1 = [].obs;
  //
  RxList l2 = [].obs;
  //
  RxList listeDePresence = [].obs;
  //
  RxList listDeabsence = [].obs;
  //
  RxList listDeabsenceMonth = [].obs;
  //
  RxList listDeabsenceJustifie = [].obs;
  //
  RxList listeFictif = RxList();
  //
  RxInt nombreHeure = 0.obs;
  //
  RxInt nombreJours = 0.obs;
  //
  RxInt nombreJourPartiel = 0.obs;

  CalendrierConnexion calendrierConnexion = CalendrierConnexion();
  //
  absence() async {
    Response response = await calendrierConnexion.absence();
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      l1.value = response.body;
    }
  }

  presence() async {
    Response response = await calendrierConnexion.presence();
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      l1.value = response.body;
    }
  }

  mois_p(String idcarte, String mois, String annee) async {
    listeDePresence = RxList();
    Response response = await calendrierConnexion.mois_p(idcarte, mois, annee);
    //print("${Utils.url}/presence/all/$idcarte/$mois/$annee");
    if (response.isOk) {
      //
      nombreJours = RxInt(0);
      nombreHeure = RxInt(0);
      nombreJourPartiel = RxInt(0);
      //
      listeDePresence.value = response.body;
      //nombreJours.value = listeDePresence.value.length;
      print("listeDePresence: ${listeDePresence}");
      for (var e in listeDePresence) {
        if (e['present']) {
          if (e['dateDepart'] == null || e['dateArrive'] == null) {
            nombreJourPartiel.value = nombreJourPartiel.value + 1;
          }
          print("nombreJourPartiel 1: $nombreJourPartiel");
          if (e['dateDepart'] != null && e['dateArrive'] != null) {
            List<String> td1 = "${e['dateArrive']}".split(" ");
            var v1 = td1[0].split("-");
            var v2 = td1[1].split(":");
            //
            List<String> td2 = "${e['dateDepart']}".split(" ");
            var s1 = td2[0].split("-");
            var s2 = td2[1].split(":");
            //

            var d1 = DateTime(
              int.parse(v1[0]),
              int.parse(v1[1]),
              int.parse(v1[2]),
              int.parse(v2[0]),
              int.parse(v2[1]),
              int.parse(v2[2].split(".")[0]),
            );
            var d2 = DateTime(
              int.parse(s1[0]),
              int.parse(s1[1]),
              int.parse(s1[2]),
              int.parse(s2[0]),
              int.parse(s2[1]),
              int.parse(s2[2].split(".")[0]),
            );
            Duration du = d2.difference(d1);
            //print("durée en heure: ${du.inHours}");
            nombreHeure = nombreHeure + du.inHours;
            nombreJours.value++;
          }
          //print("condition: ${e['lelo']} $venu : $parti");
        }
      }
      print(
          "nombreHeure: $nombreHeure et nombreJourPartiel 2: $nombreJourPartiel");
    }
  }

  mois_a(String idcarte, String mois, String annee) async {
    listDeabsence = RxList();
    Response response = await calendrierConnexion.mois_a(idcarte, mois, annee);
    if (response.isOk) {
      //
      listDeabsence.value = response.body;
      print("!!${listDeabsence.value}");
    }
  }

  mois_all_m(String idcarte, String mois, String annee) async {
    listDeabsenceMonth = RxList();
    Response response =
        await calendrierConnexion.mois_all_m(idcarte, mois, annee);
    if (response.isOk) {
      //
      listDeabsenceMonth.value = response.body;
      print("::${listDeabsence.value}");
    }
  }

  //Pour la partie impression
  Future<Map<String, dynamic>> mois_pp(
      String idcarte, String mois, String annee) async {
    listeDePresence = RxList();
    //
    RxInt nombreJours_ = RxInt(0);
    RxInt nombreHeure_ = RxInt(0);
    RxInt nombreJourPartiel_ = RxInt(0);
    //
    Response response = await calendrierConnexion.mois_p(idcarte, mois, annee);
    //print("${Utils.url}/presence/all/$idcarte/$mois/$annee");
    if (response.isOk) {
      //

      //
      listeDePresence.value = response.body;
      //nombreJours.value = listeDePresence.value.length;
      //print("listeDePresence: ${listeDePresence}");
      for (var e in listeDePresence) {
        if (e['present']) {
          if (e['dateDepart'] == null || e['dateArrive'] == null) {
            nombreJourPartiel_.value = nombreJourPartiel_.value + 1;
          }

          //print("nombreJourPartiel 1: $nombreJourPartiel_");
          if (e['dateDepart'] != null && e['dateArrive'] != null) {
            List<String> td1 = "${e['dateArrive']}".split(" ");
            var v1 = td1[0].split("-");
            var v2 = td1[1].split(":");
            //
            List<String> td2 = "${e['dateDepart']}".split(" ");
            var s1 = td2[0].split("-");
            var s2 = td2[1].split(":");
            //

            var d1 = DateTime(
              int.parse(v1[0]),
              int.parse(v1[1]),
              int.parse(v1[2]),
              int.parse(v2[0]),
              int.parse(v2[1]),
              int.parse(v2[2].split(".")[0]),
            );
            var d2 = DateTime(
              int.parse(s1[0]),
              int.parse(s1[1]),
              int.parse(s1[2]),
              int.parse(s2[0]),
              int.parse(s2[1]),
              int.parse(s2[2].split(".")[0]),
            );
            Duration du = d2.difference(d1);
            //print("durée en heure: ${du.inHours}");
            nombreHeure_ = nombreHeure_ + du.inHours;
            nombreJours_.value++;
          }
          //print("condition: ${e['lelo']} $venu : $parti");
        }
      }
      //print(
      //  "nombreHeure: $nombreHeure_ et nombreJourPartiel 2: $nombreJourPartiel_");
    }
    return {
      "nombreJours": nombreJours_.value,
      "nombreHeure": nombreHeure_.value,
      "nombreJourPartiel": nombreJourPartiel_.value,
    };
  }

  Future<Map<String, dynamic>> mois_aa(
      String idcarte, String mois, String annee) async {
    listDeabsence = RxList();
    Response response = await calendrierConnexion.mois_a(idcarte, mois, annee);
    if (response.isOk) {
      //
      listDeabsence.value = response.body;
      //print("!!${listDeabsence.value}");
    }
    return {"liste": listDeabsence.length};
  }

  Future<Map<String, dynamic>> mois_all_mm(
      String idcarte, String mois, String annee) async {
    RxList listDeabsenceMonth_ = RxList();
    Response response =
        await calendrierConnexion.mois_all_m(idcarte, mois, annee);
    if (response.isOk) {
      //
      listDeabsenceMonth_.value = response.body;
      print("::${listDeabsence.value}");
    }
    int lam = 0;
    //
    listDeabsenceMonth_.forEach((element) {
      var d1 = DateTime.parse(element['dateDebut']);
      var d2 = DateTime.parse(element['dateFin']);
      //
      Duration du = d2.difference(d1);
      lam = lam + du.inDays;
    });
    print(lam);
    return {"lam": lam};
  }
}

class CalendrierConnexion extends GetConnect {
  Future<Response> absence() async => await get(
        "${Utils.url}/agent/all",
      );
  Future<Response> presence() async => await get(
        "${Utils.url}/agent/all",
      );
  Future<Response> mois_p(String idcarte, String mois, String annee) async =>
      await get(
        "${Utils.url}/presence/all/$idcarte/$mois/$annee",
      );
  Future<Response> mois_a(String idcarte, String mois, String annee) async =>
      await get(
        "${Utils.url}/absence/alljourabscent/$idcarte/$mois/$annee",
      );
  Future<Response> mois_all_m(
          String idcarte, String mois, String annee) async =>
      await get(
        "${Utils.url}/absence/all/$idcarte/$mois/$annee",
      );
}
