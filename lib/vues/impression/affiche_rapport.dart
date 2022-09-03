/*import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AfficheRapport extends StatefulWidget {
  //
  List la;
  //
  AfficheRapport(this.la);
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
                    ld = [];
                    for (var agent in widget.listeAgent) {
                      if (agent["matricule"] == matricule.text) {
                        print("la liste des agents: $agent");
                        grade.value = agent["grade"];
                        ld.add(agent);
                        break;
                      }
                    }
                    //
                    widget.listeAgent.clear();
                    widget.listeAgent = ld;
                    //
                    print("la liste des agents:::: ${widget.listeAgent}");
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
                            widget.listeAgent = widget.l2;
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
                              ? getVue("Chef de Division", widget.listeAgent)
                              : pw.Container(),
                          grade.value == "Chef de Bureau" || tous
                              ? getVue("Chef de Bureau", widget.listeAgent)
                              : pw.Container(),
                          grade.value ==
                                      "Attaché d'Administration de 1eme classe" ||
                                  tous
                              ? getVue(
                                  "Attaché d'Administration de 1eme classe",
                                  widget.listeAgent)
                              : pw.Container(),
                          grade.value ==
                                      "Attaché d'Administration de 2eme classe" ||
                                  tous
                              ? getVue(
                                  "Attaché d'Administration de 2eme classe",
                                  widget.listeAgent)
                              : pw.Container(),
                          grade.value == "Agent Auxiliaire de 2eme Classe" ||
                                  tous
                              ? getVue("Agent Auxiliaire de 2eme Classe",
                                  widget.listeAgent)
                              : pw.Container(),
                          grade.value == "Huissier" || tous
                              ? getVue("Huissier", widget.listeAgent)
                              : pw.Container(),
                          grade.value == "Stagiaire" || tous
                              ? getVue("Stagiaire", widget.listeAgent)
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
                              ? EntiteListe("Chef de Division",
                                  widget.listeAgent, mois.text, annee.text)
                              : Container(),
                          grade.value == "Chef de Bureau" || tous
                              ? EntiteListe("Chef de Bureau", widget.listeAgent,
                                  mois.text, annee.text)
                              : Container(),
                          grade.value ==
                                      "Attaché d'Administration de 1eme classe" ||
                                  tous
                              ? EntiteListe(
                                  "Attaché d'Administration de 1eme classe",
                                  widget.listeAgent,
                                  mois.text,
                                  annee.text)
                              : Container(),
                          grade.value ==
                                      "Attaché d'Administration de 2eme classe" ||
                                  tous
                              ? EntiteListe(
                                  "Attaché d'Administration de 2eme classe",
                                  widget.listeAgent,
                                  mois.text,
                                  annee.text)
                              : Container(),
                          grade.value == "Agent Auxiliaire de 2eme Classe" ||
                                  tous
                              ? EntiteListe("Agent Auxiliaire de 2eme Classe",
                                  widget.listeAgent, mois.text, annee.text)
                              : Container(),
                          grade.value == "Huissier" || tous
                              ? EntiteListe("Huissier", widget.listeAgent,
                                  mois.text, annee.text)
                              : Container(),
                          grade.value == "Stagiaire" || tous
                              ? EntiteListe("Stagiaire", widget.listeAgent,
                                  mois.text, annee.text)
                              : Container(),
                        ],
                      )
                    : ListView(
                        children: [
                          EntiteListe(grade.value, widget.listeAgent, mois.text,
                              annee.text)
                        ],
                      ),
              )
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
*/