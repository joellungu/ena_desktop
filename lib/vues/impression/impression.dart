import 'dart:async';
import 'dart:io';
import 'package:ena_desktop/vues/abscence/abscence_controller.dart';
import 'package:ena_desktop/vues/calendrier/calendrier_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

RxList l1 = [].obs;
RxList l2 = [].obs;

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
  //
  List ld = [];
  //
  Widget? vue;
  //
  Future<List> getListeAgent() async {
    return controller.saveAgent2();
  }

  @override
  void initState() {
    //
    controller.saveAgent();
    //
    //l1 = listeAgent;
    //l2 = listeAgent;
    //
    mois.text = "${DateTime.now().month}";
    //mois.text.annee.text.grade.value
    annee.text = "${DateTime.now().year}";
    //
    vue = Container();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getListeAgent(),
        builder: (c, t) {
          if (t.hasData) {
            List listeAgent = t.data as List;

            return AfficheRapport(listeAgent);
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
        });
  }
}

class AfficheRapport extends StatefulWidget {
  //
  List listeAgent;
  //
  AfficheRapport(this.listeAgent);
  @override
  State<StatefulWidget> createState() {
    return _AfficheRapport();
  }
}

class _AfficheRapport extends State<AfficheRapport> {
  //
  RxString gp = "Presence".obs; //
  RxString grade = "Tous".obs; //
  //
  String repertoire = "";
  //
  TextEditingController mois = TextEditingController();
  TextEditingController annee = TextEditingController();
  TextEditingController matricule = TextEditingController();
  //
  //
  AbsenceController controller = Get.find();
  //||
  bool tous = true;
  //
  List listeAgent = [];
  //
  Widget? vue;
  //
  @override
  void initState() {
    //
    //l1 = listeAgent;
    //l2 = listeAgent;
    //
    mois.text = "${DateTime.now().month}";
    //mois.text.annee.text.grade.value
    annee.text = "${DateTime.now().year}";
    //
    vue = Container();
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
                ///456.214
                onPressed: () {
                  setState(() {
                    listeAgent = [];
                    for (var agent in widget.listeAgent) {
                      if (agent["matricule"] == matricule.text) {
                        print("la liste des agents: $agent");
                        grade.value = agent["grade"];
                        listeAgent.add(agent);
                        break;
                      }
                    }
                    //
                    //widget.listeAgent.clear();
                    //widget.listeAgent = ld;
                    //
                    print("la liste des agents:::: ${listeAgent}");
                  });
                },
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
                          //color: Colors.blue,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            //
                            l1 = RxList([]);
                            l2 = RxList([]);
                            //
                            matricule.text = "";
                            //
                            listeAgent = widget.listeAgent;
                            //
                            grade.value = newValue!;
                            if (grade.value == "Tous") {
                              tous = true;
                            } else {
                              tous = false;
                            }
                            //
                            print(
                                "J'ai la longueur vaut: ${widget.listeAgent.length}");
                            /*
                                    List lw = [
                                      //
                                      grade.value == "Chef de Division" || tous
                                          ? EntiteListe("Chef de Division",
                                              listeAgent, mois.text, annee.text)
                                          : Container(),
                                      grade.value == "Chef de Bureau" || tous
                                          ? EntiteListe("Chef de Bureau",
                                              listeAgent, mois.text, annee.text)
                                          : Container(),
                                      grade.value ==
                                                  "Attaché d'Administration de 1eme classe" ||
                                              tous
                                          ? EntiteListe(
                                              "Attaché d'Administration de 1eme classe",
                                              listeAgent,
                                              mois.text,
                                              annee.text)
                                          : Container(),
                                      grade.value ==
                                                  "Attaché d'Administration de 2eme classe" ||
                                              tous
                                          ? EntiteListe(
                                              "Attaché d'Administration de 2eme classe",
                                              listeAgent,
                                              mois.text,
                                              annee.text)
                                          : Container(),
                                      grade.value ==
                                                  "Agent Auxiliaire de 2eme Classe" ||
                                              tous
                                          ? EntiteListe(
                                              "Agent Auxiliaire de 2eme Classe",
                                              listeAgent,
                                              mois.text,
                                              annee.text)
                                          : Container(),
                                      grade.value == "Huissier" || tous
                                          ? EntiteListe("Huissier", listeAgent,
                                              mois.text, annee.text)
                                          : Container(),
                                      grade.value == "Stagiaire" || tous
                                          ? EntiteListe("Stagiaire", listeAgent,
                                              mois.text, annee.text)
                                          : Container(),
                                    ];
                                    vue = ListView(
                                      children: List.generate(
                                          lw.length, (index) => lw[index]),
                                    );
                                    */
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
                  final image1 = await imageFromAssetBundle(
                      'assets/Coat_of_arms_of_the_Democratic_Republic_of_the_Congo.svg.png');
                  final image2 = await imageFromAssetBundle(
                      'assets/WhatsApp Image 2022-06-12 at 19.45.12.jpeg');
                  pdf.addPage(
                    pw.MultiPage(
                      //pageFormat: PdfPageFormat.undefined,
                      build: (pw.Context context) {
                        return [
                          pw.Container(
                            height: 50,
                            child: pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Container(
                                  width: 40,
                                  height: 40,
                                  child: pw.Image(image2),
                                  alignment: pw.Alignment(0, 0),
                                  //color: PdfColor.fromRYB(0.6, 0.6, 0.8),
                                ),
                                pw.Flexible(
                                  //fit: 1,
                                  child: pw.Column(
                                    children: [
                                      pw.Align(
                                        alignment: pw.Alignment(0, 0),
                                        child: pw.Text(
                                            "REPUBLIQUE DEMOCRATIQUE DU CONGO"),
                                      ),
                                      pw.Align(
                                        alignment: pw.Alignment(0, 0),
                                        child: pw.Text(
                                          "MINISTERE DE LA FONCTION PUBLIQUE, MODERNISATION DE L'ADMINISTRATION ET INNOVATION DU SERVICE PUBLIC",
                                          textAlign: pw.TextAlign.center,
                                          style: pw.TextStyle(
                                            fontSize: 6,
                                          ),
                                        ),
                                      ),
                                      pw.Row(
                                        mainAxisAlignment:
                                            pw.MainAxisAlignment.center,
                                        children: [
                                          pw.Text(
                                              "Relevé du ${DateTime.now().month} année ${DateTime.now().year}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                pw.Container(
                                  width: 40,
                                  height: 40,
                                  alignment: pw.Alignment(0, 0),
                                  child: pw.Image(image1),
                                  //color: PdfColor.fromRYB(0.7, 0.6, 0.8),
                                ),
                              ],
                            ),
                          ),
                          pw.Container(
                            //color: PdfColors.yellow,
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
                              ? getVue("Chef de Division", listeAgent)
                              : pw.Container(),
                          grade.value == "Chef de Bureau" || tous
                              ? getVue("Chef de Bureau", listeAgent)
                              : pw.Container(),
                          grade.value ==
                                      "Attaché d'Administration de 1eme classe" ||
                                  tous
                              ? getVue(
                                  "Attaché d'Administration de 1eme classe",
                                  listeAgent)
                              : pw.Container(),
                          grade.value ==
                                      "Attaché d'Administration de 2eme classe" ||
                                  tous
                              ? getVue(
                                  "Attaché d'Administration de 2eme classe",
                                  listeAgent)
                              : pw.Container(),
                          grade.value == "Agent Auxiliaire de 2eme Classe" ||
                                  tous
                              ? getVue(
                                  "Agent Auxiliaire de 2eme Classe", listeAgent)
                              : pw.Container(),
                          grade.value == "Huissier" || tous
                              ? getVue("Huissier", listeAgent)
                              : pw.Container(),
                          grade.value == "Stagiaire" || tous
                              ? getVue("Stagiaire", listeAgent)
                              : pw.Container(),
                        ];
                      },
                    ),
                  );
                  //
                  print("${l1[1]['nombreJours'] ?? '...'}");
                  print("${l1[1]['nombreJourPartiel'] ?? '...'}");
                  print("${l1[1]['lam'] ?? '...'}");
                  //
                  Directory? appDownDir = await getDownloadsDirectory();
                  Directory appDocDir =
                      await getApplicationDocumentsDirectory();
                  String appDocPath = appDocDir.path;
                  String appDownDirPath = appDownDir!.path;
                  //
                  print("$appDocPath/${mois.text}.${annee.text}.rapport.pdf");
                  repertoire =
                      "$appDocPath/${mois.text}.${annee.text}.rapport.pdf";
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
                  setState(() {}); //
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
                          for (var e in listeAgent) {
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
              SizedBox(
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
                child: matricule.text.isEmpty
                    ? ListView(
                        children: [
                          //
                          grade.value == "Chef de Division" || tous
                              ? EntiteListe("Chef de Division", listeAgent,
                                  mois.text, annee.text)
                              : Container(),
                          grade.value == "Chef de Bureau" || tous
                              ? EntiteListe("Chef de Bureau", listeAgent,
                                  mois.text, annee.text)
                              : Container(),
                          grade.value ==
                                      "Attaché d'Administration de 1eme classe" ||
                                  tous
                              ? EntiteListe(
                                  "Attaché d'Administration de 1eme classe",
                                  listeAgent,
                                  mois.text,
                                  annee.text)
                              : Container(),
                          grade.value ==
                                      "Attaché d'Administration de 2eme classe" ||
                                  tous
                              ? EntiteListe(
                                  "Attaché d'Administration de 2eme classe",
                                  listeAgent,
                                  mois.text,
                                  annee.text)
                              : Container(),
                          grade.value == "Agent Auxiliaire de 2eme Classe" ||
                                  tous
                              ? EntiteListe("Agent Auxiliaire de 2eme Classe",
                                  listeAgent, mois.text, annee.text)
                              : Container(),
                          grade.value == "Huissier" || tous
                              ? EntiteListe(
                                  "Huissier", listeAgent, mois.text, annee.text)
                              : Container(),
                          grade.value == "Stagiaire" || tous
                              ? EntiteListe("Stagiaire", listeAgent, mois.text,
                                  annee.text)
                              : Container(),
                        ],
                      )
                    : ListView(
                        children: [
                          EntiteListe(
                              grade.value, listeAgent, mois.text, annee.text)
                        ],
                      ),
              ),
              Text(repertoire)
            ],
          ),
        ),
      ],
    );
  }

  //
  pw.Widget getVue(String grade, List listeAgent) {
    return pw.Column(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Container(
          height: 20,
          decoration: pw.BoxDecoration(
            //color: PdfColors.grey,
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
                        child: pw.Text(""),
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
                            "${getRaps(listeAgent[index]['id'])['nombreJours'] ?? ''}",
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
                            "${getRaps(listeAgent[index]['id'])['nombreJourPartiel'] ?? ''}",
                            style: const pw.TextStyle(
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
                            "${getRaps(listeAgent[index]['id'])['nombreJourAbsent'] ?? ''}",
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
                            "${getRaps(listeAgent[index]['id'])['lam'] ?? ''}",
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

  Map getRaps(int id) {
    Map m = {};
    for (Map mm in l1) {
      if ("$id" == mm["id"]) {
        m = mm;
        break;
      }
    }
    return m;
  }
}

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
                          child: FutureBuilder(
                            future: getDataPp(index), //
                            builder: (c, t) {
                              if (t.hasData) {
                                var v = t.data! as Map;
                                //l2.add({"lam": v['lam']});
                                return Text("${v['nombreJourAbsent']}");
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
                          ),
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
                              future: getDataPp(index), //nombreJourAbsent
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
    //
    print(widget.annee);
    print(widget.mois);
    DateTime moisEnQuestion =
        DateTime(int.parse(widget.annee), int.parse(widget.mois));
    //
    DateTime md = DateTime(int.parse(widget.annee), int.parse(widget.mois));
    DateTime mListe = DateTime(int.parse(widget.annee), int.parse(widget.mois));
    List listeDeDate = [];
    int t = 0;
    var e = DateUtils.getDaysInMonth(
        int.parse(widget.annee), int.parse(widget.mois));

    print("//////////////??$e");
    print("//////////////00${moisEnQuestion.month}");
    print("//////////////11${md.month}");
    print("//////////////LL${md.add(Duration(hours: 24))}");
    print("//////////////::${md.month}");
    while (t < e) {
      //moisEnQuestion.month == md.month
      md.add(const Duration(hours: 24));
      //
      var va = t * 24;
      //
      var dt = mListe.add(Duration(days: t));
      if (dt.weekday != 7) {
        listeDeDate.add(dt);
      }

      t++;
    }
    //
    print("//////////////::$listeDeDate");
    //
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
      "nombreJourAbsent":
          "${listeDeDate.length - lam["lam"] - pp["nombreJourPartiel"] - pp["nombreJours"]}",
      "lam": lam["lam"]
    };
    print(c);
    l1.add(c);
    return c;
  }
}
