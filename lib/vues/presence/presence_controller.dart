import 'dart:convert';

import 'package:ena_desktop/utils/utils.dart';
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
  alls(String date, State? state) async {
    Response response = await presenceConnexion.alls(date);
    print("${response.body}, == $date");
    if (response.isOk) {
      //
      Map<String, dynamic> map = response.body;
      l1.value = map["listeagent"];
      l2.value = map["listeeleve"];

      //print("Liste principale: ${lid.value}");
      //state!.setState(() {});
      //Get.back();${Utils.url}/absence/all/8/06
      //Get.snackbar("Effectué", "Enregistrement éffectué avec succé!");
    }
    /*

    lid.value.forEach((element) {
      getAgent(element['idcarte'], "${element['dateDepart'] ?? ''}",
          "${element['dateArrive'] ?? ''}");
      getEleve(element['idcarte'], "${element['dateDepart'] ?? ''}",
          "${element['dateArrive'] ?? ''}");
    });
    */
  }

  //
  getAgent(String id, String dd, String da) async {
    Response response = await presenceConnexion.getAgent(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      //print("!!!${response.bodyString!}");
      if (response.body != null || response.body != []) {
        Map map = response.body;
        //DateTime d1 = DateTime.parse(dd.split(" ")[0]);
        //DateTime d2 = DateTime.parse(da);

        l1 = RxList();
        print(dd);
        print("::");
        print(da);

        if (dd.isNotEmpty) {
          DateTime d1 = DateTime.parse(dd);
          map['dd'] = "${d1.hour}:${d1.minute}:${d1.second}";
        }
        if (da.isNotEmpty) {
          DateTime d1 = DateTime.parse(da);
          map['da'] = "${d1.hour}:${d1.minute}:${d1.second}";
        }

        l1.value.add(map);
      }
    }
  }

  getEleve(String id, String dd, String da) async {
    Response response = await presenceConnexion.getEleve(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      //
      print("...${response.body}");
      if (response.body != null || response.body != []) {
        Map map = response.body;
        //DateTime d1 = DateTime.parse(dd.split(" ")[0]);
        //DateTime d2 = DateTime.parse(da);

        l2 = RxList();
        print(dd);
        print("::");
        print(da);

        if (dd.isNotEmpty) {
          DateTime d1 = DateTime.parse(dd);
          map['dd'] = "${d1.hour}:${d1.minute}:${d1.second}";
        }
        if (da.isNotEmpty) {
          DateTime d1 = DateTime.parse(da);
          map['da'] = "${d1.hour}:${d1.minute}:${d1.second}";
        }

        l2.value.add(map);
      }
    }
  }
}

class PresenceConnexion extends GetConnect {
  Future<Response> alls(String date) async => await get(
        "${Utils.url}/presence/allbydate/$date",
      );

  Future<Response> getEleve(String id) async => await get(
        "${Utils.url}/eleve/details/$id",
      );

  Future<Response> getAgent(String id) async => await get(
        "${Utils.url}/agent/details/$id",
      );
}
