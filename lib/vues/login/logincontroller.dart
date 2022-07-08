import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';
import '../principal.dart';

class LoginController extends GetxController {
  RxMap<dynamic, dynamic> client = {}.obs;
  var loager = false.obs;

  load(String email, password) async {
    //
    http.Response response = await http.get(Utils.lienUrl);
    //
    Get.dialog(
      const AlertDialog(
        content: Text("Login en cours..."),
      ),
    );
    //
    if (response.statusCode == 201 || response.statusCode == 200) {
      //
      Get.back();
      //
      setClient(jsonDecode(response.body)); //
      //
      Get.off(Principal());
    } else {
      //Get.dialog(widget)
      Get.snackbar(
        "Erreur",
        "Une erreur c'est produit!",
        icon: Icon(
          Icons.warning_outlined,
          color: Colors.red.shade700,
        ),
      );
    }
  }

  setClient(Map<dynamic, dynamic> cl) {
    client.value = cl;
  }

  getLoager() {
    return loager;
  }

  setLoager(bool loag) {
    loager.value = loag;
  }
}
