import 'dart:convert';

import 'package:get/get.dart';

class CalendrierController extends GetxController {
  //
  RxList l1 = [].obs;
  //
  RxList l2 = [].obs;
  //
  RxList listeDePresence = [].obs;
  //
  RxList listDeAbscence = [].obs;
  //
  RxList listDeAbscenceMonth = [].obs;
  //
  RxList listDeAbscenceJustifie = [].obs;
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
  abscence() async {
    Response response = await calendrierConnexion.abscence();
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
    //print("http://localhost:8080/presence/all/$idcarte/$mois/$annee");
    if (response.isOk) {
      //
      nombreJours = RxInt(0);
      nombreHeure = RxInt(0);
      nombreJourPartiel = RxInt(0);
      //
      listeDePresence.value = response.body;
      nombreJours.value = listeDePresence.value.length;
      print("listeDePresence: ${listeDePresence}");
      for (var e in listeDePresence) {
        if (e['present']) {
          nombreJourPartiel.value = nombreJourPartiel.value + 1;
          print("nombreJourPartiel 1: $nombreJourPartiel");
          if (e['dateDepart'] != null) {
            var d1 = DateTime.parse(e['dateArrive']);
            var d2 = DateTime.parse(e['dateDepart']);
            Duration du = d2.difference(d1);
            //print("durée en heure: ${du.inHours}");
            nombreHeure = nombreHeure + du.inHours;
          }
          //print("condition: ${e['lelo']} $venu : $parti");
        }
      }
      print(
          "nombreHeure: $nombreHeure et nombreJourPartiel 2: $nombreJourPartiel");
    }
  }

  mois_a(String idcarte, String mois, String annee) async {
    listDeAbscence = RxList();
    Response response = await calendrierConnexion.mois_a(idcarte, mois, annee);
    if (response.isOk) {
      //
      listDeAbscence.value = response.body;
      print("!!${listDeAbscence.value}");
    }
  }

  mois_all_m(String idcarte, String mois, String annee) async {
    listDeAbscenceMonth = RxList();
    Response response =
        await calendrierConnexion.mois_all_m(idcarte, mois, annee);
    if (response.isOk) {
      //
      listDeAbscenceMonth.value = response.body;
      print("::${listDeAbscence.value}");
    }
  }
}

class CalendrierConnexion extends GetConnect {
  Future<Response> abscence() async => await get(
        "http://localhost:8080/agent/all",
      );
  Future<Response> presence() async => await get(
        "http://localhost:8080/agent/all",
      );
  Future<Response> mois_p(String idcarte, String mois, String annee) async =>
      await get(
        "http://localhost:8080/presence/all/$idcarte/$mois/$annee",
      );
  Future<Response> mois_a(String idcarte, String mois, String annee) async =>
      await get(
        "http://localhost:8080/abscence/alljourabscent/$idcarte/$mois/$annee",
      );
  Future<Response> mois_all_m(
          String idcarte, String mois, String annee) async =>
      await get(
        "http://localhost:8080/abscence/all/$idcarte/$mois/$annee",
      );
}
