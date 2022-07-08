import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresenceController extends GetxController {
  //
  PresenceConnexion presenceConnexion = PresenceConnexion();
  //
  RxList lid = [].obs;
  RxList l1 = [].obs;
  RxList l2 = [].obs;
  //
  alls(String ann, String mois, String jour, State? state) async {
    Response response = await presenceConnexion.alls(ann, mois, jour);
    print("$ann, $mois, $jour");
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
      lid.value = response.body;
      print("Liste principale: ${lid.value}");
      state!.setState(() {});
      //Get.back();http://localhost:8080/abscence/all/8/06
      //Get.snackbar("Success", "Enregistrement éffectué avec succé!");
    }

    l1 = RxList();
    l2 = RxList();

    lid.value.forEach((element) {
      getAgent(element['idcarte'], "${element['dateDepart']}",
          "${element['dateArrive']}");
      getEleve(element['idcarte']);
    });
  }

  //
  getAgent(String id, String dd, String da) async {
    Response response = await presenceConnexion.getAgent(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("!!!${response.bodyString!}");
      if (response.body != null || response.body != []) {
        Map map = response.body;
        //DateTime d1 = DateTime.parse(dd.split(" ")[0]);
        //DateTime d2 = DateTime.parse(da);

        map['dd'] = dd.length != 0
            ? '${dd.split(" ")[1]}'.split('.')[0]
            : ""; //:${d1.minute}
        map['da'] = da.length != 0 ? '${da.split(" ")[1]}'.split('.')[0] : "";

        l1.value.add(map);
      }
    }
  }

  getEleve(String id) async {
    Response response = await presenceConnexion.getEleve(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("...${response.body}");
      if (response.body != null || response.body != []) {
        l2.value.add(response.body);
      }
    }
  }
}

class PresenceConnexion extends GetConnect {
  Future<Response> alls(String ann, String mois, String jour) async =>
      await get(
        "http://localhost:8080/presence/allbydate/$ann/$mois/$jour",
      );

  Future<Response> getEleve(String id) async => await get(
        "http://localhost:8080/eleve/details/$id",
      );

  Future<Response> getAgent(String id) async => await get(
        "http://localhost:8080/agent/details/$id",
      );
}
