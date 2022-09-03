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
                      RxBool absenceJ = false.obs;
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
                            if (e['dateDepart'] != null &&
                                e['dateArrive'] != null) {
                              parti = true.obs;
                              //var d1 = DateTime.parse(e['dateArrive']);
                              //var d2 = DateTime.parse(e['dateDepart']);
                              List<String> td1 =
                                  "${e['dateArrive']}".split(" ");
                              var v1 = td1[0].split("-");
                              var v2 = td1[1].split(":");
                              //
                              List<String> td2 =
                                  "${e['dateDepart']}".split(" ");
                              var s1 = td2[0].split("-");
                              var s2 = td2[1].split(":");
                              //

                              var d1 = DateTime(
                                int.parse(v1[0]),
                                int.parse(v1[1]),
                                int.parse(v1[2]),
                                int.parse(v2[0]),
                                int.parse(v2[1]),
                                int.parse(v2[2].split(".")[0]),
                              );
                              var d2 = DateTime(
                                int.parse(s1[0]),
                                int.parse(s1[1]),
                                int.parse(s1[2]),
                                int.parse(s2[0]),
                                int.parse(s2[1]),
                                int.parse(s2[2].split(".")[0]),
                              );
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
                      cc.listDeabsence.forEach((e) {
                        if (int.parse(
                                "${e['date']}".split(" ")[0].split("-")[2]) ==
                            index - d) {
                          //print("jour abscent: $e");
                          absenceJ = true.obs;
                        }
                      });
                      //
                      return JourAffiche(index, absenceJ, venu, parti, d,
                          widget.mois, widget.annee);
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
}

class JourAffiche extends StatefulWidget {
  RxBool absenceJ;
  int index;
  RxBool venu;
  RxBool parti;
  int d;
  int mois;
  int annee;
  JourAffiche(
    this.index,
    this.absenceJ,
    this.venu,
    this.parti,
    this.d,
    this.mois,
    this.annee,
  );

  @override
  State<StatefulWidget> createState() {
    return _JourAffiche();
  }
}

class _JourAffiche extends State<JourAffiche> {
  @override
  Widget build(BuildContext context) {
    var dd = DateTime(widget.annee, widget.mois, widget.index - widget.d);
    return InkWell(
      onTap: () {
        //
        var d = DateUtils.firstDayOffset(DateTime.now().year,
            DateTime.now().month, MaterialLocalizations.of(context));
        //print("La vaut: $d");
        var dd = DateTime(widget.annee, widget.mois, widget.index - widget.d);
        print(dd.weekday);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: dd.weekday == 7
                ? Colors.red
                : widget.absenceJ.value
                    ? Colors.blueGrey
                    : getCouleur(widget.venu.value, widget.parti.value),
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: Text(
            "${widget.index - widget.d}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }

  //
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
