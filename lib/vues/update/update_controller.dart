import 'dart:convert';

import 'package:ena_desktop/utils/utils.dart';
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
      await put("${Utils.url}/agent/update", jsonEncode(u));
  Future<Response> update_eleve(Map<String, dynamic> u) async =>
      await put("${Utils.url}/eleve/update", jsonEncode(u));
}
