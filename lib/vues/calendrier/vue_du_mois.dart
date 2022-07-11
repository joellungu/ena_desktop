import 'dart:async';

import 'package:ena_desktop/vues/calendrier/calendrier_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoisVue extends StatefulWidget {
  Map<String, dynamic> d;
  int mois;
  int annee;
  MoisVue(Key key, this.d, this.mois, this.annee) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoisVue();
  }
}

class _MoisVue extends State<MoisVue> {
  double v = 25;
  var d = 0;
  RxInt nombreDeJours = RxInt(0);
  //CalendrierController calendrierController = Get.find();
  //
  int x = 1; //Une variable pour le test
  //
  CalendrierController cc = Get.find();
  //
  @override
  void initState() {
    //
    while (x < 21) {
      cc.listeFictif.add({
        "idcarte": "1234567",
        "present": true,
        "lelo": "${widget.annee}-${widget.mois}-$x-8",
        "dateArrive": "${widget.annee}-${widget.mois}-$x-8",
        "dateDepart": "${widget.annee}-${widget.mois}-$x-18"
      });
      x++;
    }
    cc.listeFictif.add({
      "idcarte": "1234567",
      "present": true,
      "lelo": "${widget.annee}-${widget.mois}-21-8",
      "dateArrive": "${widget.annee}-${widget.mois}-21-8",
      "dateDepart": null
    });
    cc.listeFictif.add({
      "idcarte": "1234567",
      "present": true,
      "lelo": "${widget.annee}-${widget.mois}-22-8",
      "dateArrive": "${widget.annee}-${widget.mois}-22-8",
      "dateDepart": null
    });
    cc.listeFictif.add({
      "idcarte": "1234567",
      "present": false,
      "lelo": "${widget.annee}-${widget.mois}-23-8",
      "dateArrive": "${widget.annee}-${widget.mois}-23-8",
      "dateDepart": "${widget.annee}-${widget.mois}-23-18"
    });
    //
    //
    super.initState();
    //
    nombreDeJours.value = DateUtils.getDaysInMonth(widget.annee, widget.mois);
    //print("longueur du mois: ${nombreDeJours}");
    //
  }

  repartiteur() {
    //
    d = DateUtils.firstDayOffset(
      widget.annee,
      widget.mois,
      MaterialLocalizations.of(context),
    ); //

    nombreDeJours = nombreDeJours + (d - 2);
    d = d - 2;
    //print("La vaut: $d");
    //print("La vaut: $nombreDeJours");
    //var dd = DateTime(DateTime.now().year, DateTime.now().month);
    //print(dd);
  }

  @override
  Widget build(BuildContext context) {
    //
    repartiteur();
    //
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            //color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "L",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: v,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "M",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: v,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "M",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: v,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "J",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: v,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "V",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: v,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "S",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: v,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    //color: Colors.transparent,
                    alignment: Alignment.center,
                    child: Text(
                      "D",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: v,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(
              () => Container(
                child: GridView.count(
                  controller: ScrollController(),
                  crossAxisCount: 7,
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 2,
                  childAspectRatio: 1,
                  children: List.generate(nombreDeJours.value + 1, (index) {
                    if (index <= d) {
                      return Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Container(),
                      );
                    } else {
                      RxBool venu = false.obs;
                      RxBool parti = false.obs;
                      RxBool abscenceJ = false.obs;
                      cc.listeDePresence.forEach((e) {
                        //Timer(Duration(seconds: 1), () {
                        //setState(() {
                        if (int.parse("${e['lelo']}".split("-")[2]) ==
                            index - d) {
                          if (e['present']) {
                            venu = true.obs;
                            //print("Je suis venu $venu");
                            //print(":: ${e['dateDepart']}");
                            //var d1 = DateTime.parse("2022-07-09 08:59:13.831475");
                            //var d2 = DateTime.parse("2022-07-09 16:59:13.831475");
                            //
                            //Duration du = d2.difference(d1);
                            //print("durée en heure: ${du.inHours}");
                            //
                            if (e['dateDepart'] != null) {
                              parti = true.obs;
                              var d1 = DateTime.parse(e['dateArrive']);
                              var d2 = DateTime.parse(e['dateDepart']);
                              //
                              //var d1 =
                              //    DateTime.parse("2022-07-09 08:59:13.831475");
                              //var d2 =
                              //    DateTime.parse("2022-07-09 16:59:13.831475");
                              //
                              Duration du = d2.difference(d1);
                              //print("durée en heure: ${du.inHours}");
                              //cc.nombreHeure = cc.nombreHeure + du.inHours;
                            } else {
                              //cc.nombreJourPartiel.value =
                              //  cc.nombreJourPartiel.value + 1;
                              //print("datedepart: ${e['dateDepart']}");
                              parti = false.obs;
                            }
                            //print("condition: ${e['lelo']} $venu : $parti");
                          } else {
                            venu = false.obs;
                            parti = false.obs;
                          }
                        }
                        //});
                        //});
                      });
                      //
                      cc.listDeAbscence.forEach((e) {
                        if (int.parse(
                                "${e['date']}".split(" ")[0].split("-")[2]) ==
                            index - d) {
                          //print("jour abscent: $e");
                          abscenceJ = true.obs;
                        }
                      });
                      //
                      return InkWell(
                        onTap: () {
                          //
                          var d = DateUtils.firstDayOffset(
                              DateTime.now().year,
                              DateTime.now().month,
                              MaterialLocalizations.of(context));
                          print("La vaut: $d");
                          var dd = DateTime(
                              DateTime.now().year, DateTime.now().month);
                          print(dd);
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                color: abscenceJ.value
                                    ? Colors.blueGrey
                                    : getCouleur(venu.value, parti.value),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "${index - d}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: v,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color getCouleur(bool venu, bool partie) {
    print("$venu == $partie");
    if (venu && partie) {
      //print("cool");
      return Colors.blue;
    } else if (venu) {
      //print("demi cool");
      return Colors.orange;
    } else {
      //print("pas cool");
      return Colors.red;
    }
  }
}
