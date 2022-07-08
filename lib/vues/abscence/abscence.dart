import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'abscence_controller.dart';

//
enum BestTutorSite { ini, con }

class Abscence extends GetView<AbscenceController> {
  //

  //
  Abscence() {
    //
    controller.saveAgent();
    controller.saveEleve();
    //
  }
  //

  //RxList l = [].obs;
  //
  RxString absPonctuelle = "Congé maladie".obs;
  bool v = false;
  //
  //final box = GetStorage();
  //
  TextEditingController mat1 = TextEditingController();
  //
  TextEditingController mat2 = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    height: 50,
                    //color: Colors.blue,
                    alignment: Alignment.center,
                    child: Container(
                      width: 250,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: mat1,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Nom de l'agent",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {
                              //
                            },
                            icon: Icon(Icons.search),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children:
                            List.generate(controller.l1.value.length, (index) {
                          print("${controller.l1[index]['id']}");
                          //File f = File(
                          //   "http://localhost:8080/piecejointe/photo/1/1.jpg");

                          ///${controller.l1[index]['id']}
                          //print(f.length());
                          return ListTile(
                            onTap: () {
                              //
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Material(
                                    child: CreeAbscence(
                                        "${controller.l1[index]['id']}",
                                        "${controller.l1[index]['nom']} ${controller.l1[index]['postnom']}"),
                                  );
                                },
                              );
                            },
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "http://localhost:8080/piecejointe/photo/${controller.l1[index]['id']}",
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            title: Text(
                                "${controller.l1[index]['nom']}  ${controller.l1[index]['postnom']}"),
                            subtitle:
                                Text("${controller.l1[index]['matricule']}"),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 10,
            height: 500,
            color: Colors.grey,
          ),
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  Container(
                    height: 50,
                    //color: Colors.blue,
                    alignment: Alignment.center,
                    child: Container(
                      width: 250,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: TextField(
                              controller: mat2,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                hintText: "Nom de l'eleve",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () {
                              //
                              print(DateTime.now());
                            },
                            icon: Icon(Icons.search),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      //color: Colors.green,
                      padding: const EdgeInsets.all(20),
                      child: ListView(
                        children:
                            List.generate(controller.l2.value.length, (index) {
                          //print(l[index]);
                          return ListTile(
                            onTap: () {
                              //
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Material(
                                    child: CreeAbscence(
                                        "${controller.l2[index]['id']}",
                                        "${controller.l2[index]['nom']} ${controller.l2[index]['postnom']}"),
                                  );
                                },
                              );
                              //
                            },
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      "http://localhost:8080/piecejointe/photo/${controller.l1[index]['id']}",
                                    ),
                                    fit: BoxFit.fill),
                              ),
                            ),
                            title: Text(
                                "${controller.l2[index]['nom']}  ${controller.l2[index]['postnom']}"),
                            subtitle:
                                Text("${controller.l2[index]['telephone']}"),
                          );
                        }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

/*
          Expanded(
            flex: 4,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Nom: "),
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Abscence ponctuelle"),
                          SizedBox(
                            height: 20,
                          ),
                          CheckboxListTile(
                            value: v,
                            title: Text("Abscence ponctuelle"),
                            onChanged: (r) {
                              //
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Card(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("Abscence justifié"),
                            Padding(
                              padding: EdgeInsets.only(left: 50, right: 50),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Obx(
                                      () => DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: absPonctuelle.value,
                                          icon:
                                              const Icon(Icons.arrow_downward),
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.deepPurple),
                                          underline: Container(
                                            height: 2,
                                            color: Colors.blue,
                                          ),
                                          onChanged: (String? newValue) {},
                                          items: <String>[
                                            'Congé maladie',
                                            'Congé maternité',
                                            "Congé ",
                                            "",
                                            '',
                                            '',
                                            '',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text("Enregistrer"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Retard"),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Enregistrer")),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        
*/

class CreeAbscence extends StatefulWidget {
  String id;
  String nom;
  //
  CreeAbscence(this.id, this.nom);

  @override
  State<StatefulWidget> createState() {
    return _CreeAbscence();
  }
}

class _CreeAbscence extends State<CreeAbscence> {
  //

  RxString dtDebut = "".obs;
  RxString dtFin = "".obs;
  //
  BestTutorSite _site = BestTutorSite.ini;
  //
  AbscenceController abscenceController = Get.put(AbscenceController());
  //
  final justification = TextEditingController();
  //
  bool type = false;

  @override
  void initState() {
    dtDebut.value = "${DateTime.now()}";
    dtFin.value = "${DateTime.now()}";
    //;
    super.initState();
  }

  /*
  {
    "idutilisateur": 1,
    "type": true,
    "motifs": "En raison de maladie",
    "dateDebut": "2022-06-15 19:11:51.626998",
    "dateFin": "2022-06-15 19:11:51.626998"
  }
  */
  //
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 1.5,
      width: Get.width / 1.5,
      //color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                Text(
                  "${widget.nom}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container()
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Obx(
              () => Container(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 500,
                  width: 300,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                  "http://localhost:8080/piecejointe/photo/${widget.id}",
                                ),
                                fit: BoxFit.fill),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ListTile(
                              title: const Text('Ponctuel'),
                              leading: Radio(
                                value: BestTutorSite.ini,
                                groupValue: _site,
                                onChanged: (BestTutorSite? value) {
                                  setState(() {
                                    _site = value!;
                                    type = true;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Justifier'),
                              leading: Radio(
                                value: BestTutorSite.con,
                                groupValue: _site,
                                onChanged: (BestTutorSite? value) {
                                  setState(() {
                                    _site = value!;
                                    type = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: justification,
                          maxLines: 5,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir la justification';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "",
                            labelText: 'Justification',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text("Date de debut:  "),
                                  IconButton(
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(3000),
                                      ).then((value) {
                                        dtDebut.value = "$value";
                                      });
                                    },
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(dtDebut.value),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  const Text("Date de fin:      "),
                                  IconButton(
                                    onPressed: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(3000),
                                      ).then((value) {
                                        dtFin.value = "$value";
                                      });
                                    },
                                    icon: const Icon(Icons.calendar_today),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(dtFin.value),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.dialog(
                              const Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              name: "Attente...",
                            );
                            //
                            Map<String, dynamic> a = {
                              "idutilisateur": widget.id,
                              "type": type,
                              "motifs": "${justification.text}",
                              "dateDebut": "$dtDebut",
                              "dateFin": "$dtFin"
                            };
                            //
                            abscenceController.abscence(a);
                            //
                          },
                          child: Text("Enregistrer"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
