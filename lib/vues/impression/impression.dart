import 'dart:io';

import 'package:ena_desktop/vues/abscence/abscence_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:url_launcher/url_launcher.dart';

class Impressions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Impression();
  }
}

class _Impression extends State<Impressions> {
  RxString gp = "Presence".obs; //
  RxString grade = "Tous".obs; //
  //
  TextEditingController mois = TextEditingController();
  TextEditingController annee = TextEditingController();
  TextEditingController matricule = TextEditingController();
  //
  //
  AbsenceController controller = Get.find();
  //||
  bool tous = true;

  @override
  void initState() {
    //
    controller.saveAgent();
    //
    mois.text = "${DateTime.now().month}";
    //mois.text.annee.text.grade.value
    annee.text = "${DateTime.now().year}";
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 55,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 200,
                padding: const EdgeInsets.all(5),
                child: Expanded(
                  flex: 1,
                  child: TextField(
                    controller: matricule,
                    decoration: const InputDecoration(
                      hintText: "Matricule",
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.search),
                label: const Text(""),
              ),
              Container(
                width: 200,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: mois,
                        decoration: InputDecoration(
                          hintText: "$mois",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: annee,
                        decoration: InputDecoration(
                          hintText: "$annee",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //height: 40,
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text("Grade  "),
                    Expanded(
                      flex: 1,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: grade.value,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 0,
                          color: Colors.blue,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            grade.value = newValue!;
                            if (grade.value == "Tous") {
                              tous = true;
                            } else {
                              tous = false;
                            }
                          });
                        },
                        items: <String>[
                          'Tous',
                          'Chef de Division',
                          'Chef de Bureau',
                          "Attaché d'Administration de 1eme classe",
                          "Attaché d'Administration de 2eme classe",
                          'Agent Auxiliaire de 2eme Classe',
                          'Huissier',
                          'Stagiaire',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final pdf = pw.Document();
                  pdf.addPage(
                    pw.MultiPage(
                      //pageFormat: PdfPageFormat.undefined,
                      build: (pw.Context context) {
                        return [
                          pw.Container(
                            height: 150,
                            child: pw.Column(children: [
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Text("ENA"),
                                  pw.Text(
                                      "Date: Le ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}"),
                                ],
                              ),
                              pw.Row(
                                mainAxisAlignment: pw.MainAxisAlignment.start,
                                children: [
                                  pw.Text(
                                      "Relevé de presence du mois de ${DateTime.now().month} année ${DateTime.now().year}"),
                                ],
                              ),
                            ]),
                          ),
                          pw.Container(
                            color: PdfColors.yellow,
                            height: 30,
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                      color: PdfColors.black,
                                    ),
                                  ),
                                  alignment: pw.Alignment.center,
                                  width: 25,
                                  child: pw.Text("N°"),
                                ),
                                pw.Expanded(
                                  flex: 3,
                                  child: pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                      ),
                                    ),
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      "Non et post-nom",
                                      style: pw.TextStyle(
                                        fontSize: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 3,
                                  child: pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                      ),
                                    ),
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      "Fonction",
                                      style: pw.TextStyle(
                                        fontSize: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                      ),
                                    ),
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      "P",
                                      style: pw.TextStyle(
                                        fontSize: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                      ),
                                    ),
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      "P.P",
                                      style: const pw.TextStyle(
                                        fontSize: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                      ),
                                    ),
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      "A.N.J",
                                      style: const pw.TextStyle(
                                        fontSize: 7,
                                      ),
                                    ),
                                  ),
                                ),
                                pw.Expanded(
                                  flex: 1,
                                  child: pw.Container(
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                        color: PdfColors.black,
                                      ),
                                    ),
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      "A.J",
                                      style: pw.TextStyle(
                                        fontSize: 7,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          grade.value == "Chef de Division" || tous
                              ? getVue("Chef de Division", controller.l1)
                              : pw.Container(),
                          grade.value == "Chef de Bureau" || tous
                              ? getVue("Chef de Bureau", controller.l1)
                              : pw.Container(),
                          grade.value ==
                                      "Attaché d'Administration de 1eme classe" ||
                                  tous
                              ? getVue(
                                  "Attaché d'Administration de 1eme classe",
                                  controller.l1)
                              : pw.Container(),
                          grade.value ==
                                      "Attaché d'Administration de 2eme classe" ||
                                  tous
                              ? getVue(
                                  "Attaché d'Administration de 2eme classe",
                                  controller.l1)
                              : pw.Container(),
                          grade.value == "Agent Auxiliaire de 2eme Classe" ||
                                  tous
                              ? getVue("Agent Auxiliaire de 2eme Classe",
                                  controller.l1)
                              : pw.Container(),
                          grade.value == "Huissier" || tous
                              ? getVue("Huissier", controller.l1)
                              : pw.Container(),
                          grade.value == "Stagiaire" || tous
                              ? getVue("Stagiaire", controller.l1)
                              : pw.Container(),
                        ];
                      },
                    ),
                  );
                  //
                  //
                  Directory appDocDir =
                      await getApplicationDocumentsDirectory();
                  String appDocPath = appDocDir.path;
                  //
                  print("$appDocPath/${mois.text}.${annee.text}.rapport.pdf");
                  //
                  final file = File(
                      "$appDocPath/${mois.text}.${annee.text}.rapport.pdf");
                  await file.writeAsBytes(await pdf.save());
                  /*
                  launchUrl(
                    Uri.parse(
                        "$appDocPath/${mois.text}.${annee.text}.${grade.value}.pdf"),
                  );
                  */
                  //await shell.run('''cd /''');
                  //await shell.run(
                  //  '''open $appDocPath/${mois.text}.${annee.text}.rapport.pdf''');

                  if (matricule.text.isNotEmpty) {
                    //
                  } else {
                    //
                    // On Flutter, use the [path_provider](https://pub.dev/packages/path_provider) library:
                    // final output = await getTemporaryDirectory();
                    // final file = File("${output.path}/example.pdf");

                    int v1 = 0;
                    int v2 = 0;
                    int v3 = 0;
                    int v4 = 0;
                    int v5 = 0;
                    int v6 = 0;

                    /*
                    for (var e in controller.l1) {
                      if (e["grade"] == "Chef de Division" || tous) {
                        //
                        v1++;
                        //
                      } else if (e["grade"] == "Chef de Bureau" || tous) {
                      } else if (e["grade"] ==
                              "Attaché d'Administration de 1eme classe" ||
                          tous) {
                      } else if (e["grade"] ==
                              "Attaché d'Administration de 2eme classe" ||
                          tous) {
                      } else if (e["grade"] == "Huissier" || tous) {
                      } else if (e["grade"] == "Stagiaire" || tous) {
                        //
                      }
                    }
                    print("la division modulaire de 10 par 30 = ${10 % 30}");
                    //
                    // Page
                    
                    */
                  }
                },
                icon: const Icon(Icons.print),
                label: const Text("Impression"),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                //color: Colors.white,
                height: 40,
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
                      child: const Text("N°"),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const Text("Non et post-nom°"),
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
                        alignment: Alignment.center,
                        child: const Text("Fonction"),
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
                        child: const Text("P"),
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
                        child: const Text("P.P"),
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
                        child: const Text("A.J"),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Obx(
                  () => ListView(
                    children: [
                      grade.value == "Chef de Division" || tous
                          ? EntiteListe("Chef de Division", controller.l1)
                          : Container(),
                      grade.value == "Chef de Bureau" || tous
                          ? EntiteListe("Chef de Bureau", controller.l1)
                          : Container(),
                      grade.value ==
                                  "Attaché d'Administration de 1eme classe" ||
                              tous
                          ? EntiteListe(
                              "Attaché d'Administration de 1eme classe",
                              controller.l1)
                          : Container(),
                      grade.value ==
                                  "Attaché d'Administration de 2eme classe" ||
                              tous
                          ? EntiteListe(
                              "Attaché d'Administration de 2eme classe",
                              controller.l1)
                          : Container(),
                      grade.value == "Agent Auxiliaire de 2eme Classe" || tous
                          ? EntiteListe(
                              "Agent Auxiliaire de 2eme Classe", controller.l1)
                          : Container(),
                      grade.value == "Huissier" || tous
                          ? EntiteListe("Huissier", controller.l1)
                          : Container(),
                      grade.value == "Stagiaire" || tous
                          ? EntiteListe("Stagiaire", controller.l1)
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget getVue(String grade, List listeAgent) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Container(
          height: 30,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey,
            border: pw.Border.all(
              color: PdfColors.black,
            ),
          ),
          alignment: pw.Alignment.center,
          child: pw.Text(
            grade,
          ),
        ),
        pw.Column(
          children: List.generate(
            listeAgent.length,
            (index) {
              if (listeAgent[index]['grade'] == grade) {
                return pw.Container(
                  height: 30,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Container(
                        decoration: pw.BoxDecoration(
                          border: pw.Border.all(
                            color: PdfColors.black,
                          ),
                        ),
                        alignment: pw.Alignment.center,
                        width: 25,
                        child: pw.Text("N°"),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.only(left: 5),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                            ),
                          ),
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            "${listeAgent[index]['nom']} ${listeAgent[index]['postnom']}",
                            style: const pw.TextStyle(
                              fontSize: 7,
                            ),
                            //textAlign: ,
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          //padding: const pw.EdgeInsets.only(left: 10),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                            ),
                          ),
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            " ${listeAgent[index]['fonction']}",
                            style: pw.TextStyle(
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          //padding: const pw.EdgeInsets.only(left: 10),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                            ),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "P",
                            style: pw.TextStyle(
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          //padding: const pw.EdgeInsets.only(left: 10),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                            ),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "P.P",
                            style: pw.TextStyle(
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          //padding: const pw.EdgeInsets.only(left: 10),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                            ),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "A.N.J",
                            style: pw.TextStyle(
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 1,
                        child: pw.Container(
                          //padding: const pw.EdgeInsets.only(left: 10),
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              color: PdfColors.black,
                            ),
                          ),
                          alignment: pw.Alignment.center,
                          child: pw.Text(
                            "A.J",
                            style: pw.TextStyle(
                              fontSize: 7,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return pw.Container();
              }
            },
          ),
        )
      ],
    );
  }
}

class EntiteListe extends StatefulWidget {
  String grade;
  List listeDeAgent = [];
  //
  EntiteListe(
    this.grade,
    this.listeDeAgent,
  );
  //
  @override
  State<StatefulWidget> createState() {
    return _EntiteListe();
  }
}

class _EntiteListe extends State<EntiteListe> {
  //
  final pdf = pw.Document();
  //
  @override
  void initState() {
    //
    super.initState();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            widget.grade,
          ),
        ),
        Column(
          children: List.generate(
            widget.listeDeAgent.length,
            (index) {
              if (widget.listeDeAgent[index]['grade'] == widget.grade) {
                return Container(
                  color: Colors.grey.shade200,
                  height: 40,
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
                        child: const Text("N°"),
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
                          child: const Text("P"),
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
                          child: const Text("P.P"),
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
                          child: const Text("A.J"),
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
}
