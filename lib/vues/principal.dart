import 'package:ena_desktop/vues/abscence/abscence_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'accueil/accueil.dart';
import 'accueil/accueilController.dart';
import 'agents/ajouter/enregistrement_controller.dart';
import 'calendrier/calendrier_controller.dart';
import 'login/login.dart';
import 'login/logincontroller.dart';
import 'presence/presence_controller.dart';
import 'update/update_controller.dart';

class Principal extends StatelessWidget {
  LoginController loginController = Get.put(LoginController());
  AccueilController accueilController = Get.put(AccueilController());
  EnregistrementController enregistrementController =
      Get.put(EnregistrementController());
  //
  //
  AbsenceController absenceController = Get.put(AbsenceController());
  //
  CalendrierController calendrierController = Get.put(CalendrierController());
  //
  PresenceController presenceController = Get.put(PresenceController());
  //
  UpdateController updateController = Get.put(UpdateController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => loginController.loager.value ? Accueil() : Login(),
      ),
    );
  }
}
