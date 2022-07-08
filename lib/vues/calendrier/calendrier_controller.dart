import 'dart:convert';

import 'package:get/get.dart';

class CalendrierController extends GetxController {
  //
  RxList l1 = [].obs;
  //
  RxList l2 = [].obs;
  //
  RxList l3 = [].obs;
  //
  RxList l4 = [].obs;
  //
  RxList listeFictif = RxList();

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

  mois_p(String idcarte, String mois) async {
    Response response = await calendrierConnexion.mois_p(idcarte, mois);
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      l3.value = response.body;
      print(l3.value);
    }
  }

  mois_a(String idcarte, String mois) async {
    Response response = await calendrierConnexion.mois_a(idcarte, mois);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      l4.value = response.body;
      print("!!${l4.value}");
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
  Future<Response> mois_p(String idcarte, String mois) async => await get(
        "http://localhost:8080/presence/all/$idcarte/$mois",
      );
  Future<Response> mois_a(String idcarte, String mois) async => await get(
        "http://localhost:8080/abscence/all/$idcarte/$mois",
      );
}
