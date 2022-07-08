import 'dart:convert';

import 'package:get/get.dart';

class UpdateController extends GetxController {
  //

  UpdateConnexion calendrierConnexion = UpdateConnexion();
  //
  update_agent(Map<String, dynamic> u) async {
    Response response = await calendrierConnexion.update_agent(u);
    if (response.statusCode == 200 || response.statusCode == 200) {
      //
    }
  }

  update_eleve(Map<String, dynamic> u) async {
    Response response = await calendrierConnexion.update_eleve(u);
    if (response.statusCode == 200 || response.statusCode == 200) {}
  }
}

class UpdateConnexion extends GetConnect {
  Future<Response> update_agent(Map<String, dynamic> u) async =>
      await put("http://localhost:8080/agent/update", jsonEncode(u));
  Future<Response> update_eleve(Map<String, dynamic> u) async =>
      await put("http://localhost:8080/eleve/update", jsonEncode(u));
}
