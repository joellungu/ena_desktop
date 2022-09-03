import 'dart:io';
import 'package:ena_desktop/vues/abscence/abscence.dart';
import 'package:ena_desktop/vues/impression/impression.dart';
import 'package:ena_desktop/vues/update/update.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../admin/admin.dart';
import '../agents/agents.dart';
import '../calendrier/calendrier.dart';
import '../presence/presence.dart';
import '../propos.dart';
import '../statistique/statistique.dart';
import 'accueilController.dart';

class Accueil extends StatelessWidget {
  //

  //
  AccueilController accueilController = Get.find();
  //
  List listeMenu = [
    {
      "libelle": "Feuille de présence",
      "v": "presence",
      "icon": const Icon(Icons.checklist_outlined)
    },
    {
      "libelle": "Gestionnaire des absences",
      "v": "absence",
      "icon": const Icon(Icons.history)
    },
    {
      "libelle": "Impression",
      "v": "impression",
      "icon": const Icon(Icons.print_outlined),
    },
    {
      "libelle": "Mise à jour",
      "v": "Mise à jour",
      "icon": const Icon(Icons.person_add_alt),
    },
    {
      "libelle": "Enregistrement & Suppression Agent",
      "v": "agent",
      "icon": const Icon(Icons.person_add_outlined)
    },
    {
      "libelle": "Calendrier",
      "v": "calendrier",
      "icon": const Icon(Icons.event_note_outlined)
    }, //
    {
      "libelle": "Admin",
      "v": "admin",
      "icon": const Icon(Icons.manage_accounts)
    },
    {
      "libelle": "À propos",
      "v": "propos",
      "icon": const Icon(Icons.text_fields)
    },
    {
      "libelle": "Quitter",
      "v": "close",
      "icon": const Icon(Icons.close),
    },
  ];
  //
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        drawer: Drawer(
          elevation: 0,
          child: ListView(
            controller: ScrollController(),
            padding: const EdgeInsets.only(
              top: 20,
            ),
            children: [
              Container(
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Container(
                      //width: 110,
                      height: 110,
                      child: Image.asset(
                        "assets/WhatsApp Image 2022-06-12 at 19.45.12.jpeg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 20),
                      child: const Text.rich(
                        TextSpan(
                          text: "ENA\n",
                          children: [
                            TextSpan(
                              text: "www.ena.com",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
              Divider(),
              Column(
                children: List.generate(listeMenu.length, (index) {
                  return ListTile(
                    onTap: () {
                      //Impression
                      var v = listeMenu[index]["v"];
                      if (v == "presence" ||
                          v == "agent" ||
                          v == "Mise à jour" ||
                          v == "impression" ||
                          v == "absence" ||
                          v == "statistique" ||
                          v == "calendrier" ||
                          v == "admin" ||
                          v == "propos" ||
                          v == "admin") {
                        //
                        print(DateTime.now());
                        accueilController.sVue = listeMenu[index]["v"];
                        Navigator.of(context).pop();
                      } else {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(""),
                                content: Text(
                                    "Voulez-vous vraiment quitter l'application?"),
                                actions: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.close,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      exit(0);
                                    },
                                    icon: Icon(
                                      Icons.check,
                                    ),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    leading: listeMenu[index]["icon"],
                    title: Text(
                      listeMenu[index]["libelle"],
                    ),
                    //trailing: const Icon(Icons.arrow_forward_ios),
                  );
                }),
              )
            ],
          ),
        ),
        appBar: AppBar(
          elevation: 0,
          title: accueilController.gVue.value == "presence"
              ? const Text("Feuille de présence")
              : accueilController.gVue.value == "agent"
                  ? const Text("Enregistrement & Suppression Agent")
                  : accueilController.gVue.value == "statistique"
                      ? const Text("Statistique")
                      : accueilController.gVue.value == "absence"
                          ? const Text("Gestionnaire des absences")
                          : accueilController.gVue.value == "impression"
                              ? const Text("Impression")
                              : accueilController.gVue.value == "Mise à jour"
                                  ? const Text("Mise à jour")
                                  : accueilController.gVue.value == "calendrier"
                                      ? const Text("Calendrier")
                                      : accueilController.gVue.value == "admin"
                                          ? const Text("Admin")
                                          : const Text("À propos"),
        ),
        body: accueilController.gVue.value == "presence"
            ? Presence()
            : accueilController.gVue.value == "agent"
                ? Agents()
                : accueilController.gVue.value == "statistique"
                    ? Statistique()
                    : accueilController.gVue.value == "absence"
                        ? Absence()
                        : accueilController.gVue.value == "impression"
                            ? Impressions()
                            : accueilController.gVue.value == "Mise à jour"
                                ? Update()
                                : accueilController.gVue.value == "calendrier"
                                    ? Calendrier()
                                    : accueilController.gVue.value == "admin"
                                        ? Admin()
                                        : Propos(),
      ),
    );
  }
}
