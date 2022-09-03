/*
import 'package:ena_desktop/vues/calendrier/calendrier_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;

class EntiteListe extends StatefulWidget {
  String grade;
  List listeDeAgent = [];
  String mois;
  String annee;
  //
  EntiteListe(
    this.grade,
    this.listeDeAgent,
    this.mois,
    this.annee,
  );
  //
  @override
  State<StatefulWidget> createState() {
    return _EntiteListe();
  }
}

class _EntiteListe extends State<EntiteListe> {
  //
  CalendrierController calendrierController = Get.find();
  //
  RxList ll = RxList();
  //
  final pdf = pw.Document();
  //
  @override
  void initState() {
    //
    //l1 = RxList([]);
    //l2 = RxList([]);
    //
    print("J'ai bien initialisé longueur vaut: ${widget.listeDeAgent.length}");
    //
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    //
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 25,
          alignment: Alignment.center,
          child: Text(
            widget.grade,
          ),
        ),
        Column(
          children: List.generate(
            widget.listeDeAgent.length,
            (index) {
              //Timer(Duration(milliseconds: 5), () {
              //

              //
              //});
              //getDataPp(index);
              if (widget.listeDeAgent[index]['grade'] == widget.grade) {
                //
                //l1.add({});
                //l2.add({});
                //
                //getDataPp(index);
                return Container(
                  color: Colors.grey.shade200,
                  height: 35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        alignment: Alignment.center,
                        width: 50,
                        child: const Text(""),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            " ${widget.listeDeAgent[index]['nom']} ${widget.listeDeAgent[index]['postnom']}",
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              " ${widget.listeDeAgent[index]['fonction']}"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: FutureBuilder(
                              future: getDataPp(index),
                              builder: (c, t) {
                                if (t.hasData) {
                                  var v = t.data! as Map;
                                  //l1.add({"nombreJours": v['nombreJours']});
                                  return Text("${v['nombreJours']}");
                                } else if (t.hasError) {
                                  return Container();
                                }

                                return Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            )
                            //Obx(
                            //  () => Text("${l1[index]['nombreJours'] ?? ''}")),
                            ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: FutureBuilder(
                              future: getDataPp(index),
                              builder: (c, t) {
                                if (t.hasData) {
                                  var v = t.data! as Map;
                                  //l1.add({
                                  //"nombreJourPartiel": v['nombreJourPartiel']
                                  //});
                                  return Text("${v['nombreJourPartiel']}");
                                } else if (t.hasError) {
                                  return Container();
                                }

                                return Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            )
                            //Obx(() =>
                            //  Text("${l1[index]['nombreJourPartiel'] ?? ''}")),
                            ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text("A.N.J"),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: FutureBuilder(
                              future: getDataPp(index),
                              builder: (c, t) {
                                if (t.hasData) {
                                  var v = t.data! as Map;
                                  //l2.add({"lam": v['lam']});
                                  return Text("${v['lam']}");
                                } else if (t.hasError) {
                                  return Container();
                                }

                                return Center(
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              },
                            )
                            //Obx(() => Text("${l2[index]['lam'] ?? ''}")),
                            ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        )
      ],
    );
  }

  Future<Map> getDataPp(int index) async {
    Map pp = await calendrierController.mois_pp(
      //idcarte
      "${widget.listeDeAgent[index]['idcarte']}",
      widget.mois.length == 1 ? "0${widget.mois}" : widget.mois,
      widget.annee,
    );
    //
    Map lam = await calendrierController.mois_all_mm(
      //idcarte
      "${widget.listeDeAgent[index]['id']}",
      widget.mois.length == 1 ? "0${widget.mois}" : widget.mois,
      widget.annee,
    );
    Map c = {
      "id": "${widget.listeDeAgent[index]['id']}",
      "nombreJours": pp["nombreJours"],
      "nombreJourPartiel": pp["nombreJourPartiel"],
      "lam": lam["lam"]
    };
    print(c);
    l1.add(c);
    return c;
  }
}
*/