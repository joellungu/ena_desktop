import 'dart:convert';
import 'dart:io';
import 'package:ena_desktop/utils/utils.dart';
import 'package:ena_desktop/vues/abscence/abscence_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../agents/ajouter/enregistrement_controller.dart';
import 'update_controller.dart';

class Update extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Update();
  }
}

class _Update extends State<Update> with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  //
  List l = ["Agent", "Eleve"];
  List ll = [];
  Widget? vue;
  //
  late TabController _controller = TabController(length: 2, vsync: this);

  //
  AbsenceController controller = Get.find();
  UpdateController updateController = Get.find();

  String mois = "${DateTime.now().month}";
  RxInt jours = 0.obs;
  String noms = "";
  //

  _Calendrier() {
    //
    vue = Container();
    //
    controller.saveAgent();
    controller.saveEleve();
    //
  }

  @override
  void initState() {
    //
    controller.saveAgent();
    controller.saveEleve();
    //
    vue = Container();
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Container(
                  height: 50,
                  child: TabBar(
                    isScrollable: true,
                    controller: _controller,
                    indicatorWeight: 1,
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                    //indicator: BoxDecoration(),
                    indicatorColor: Colors.black,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey.shade800,
                    unselectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                    tabs: List.generate(2, (index) {
                      return Tab(
                        text: "${l[index]}",
                      );
                    }),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Obx(
                    () => TabBarView(
                      controller: _controller,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: ListView(
                            children: List.generate(controller.l1.value.length,
                                (index) {
                              return ListTile(
                                onTap: () {
                                  //
                                  setState(() {
                                    vue = Center(
                                      child: SizedBox(
                                        width: 400,
                                        child: MiseJA(controller.l1[index]),
                                      ),
                                    );
                                  });
                                },
                                leading: const Icon(Icons.person),
                                title: Text(
                                    "${controller.l1[index]['nom']}  ${controller.l1[index]['postnom']}"),
                                subtitle: Text(
                                    "${controller.l1[index]['matricule']}"),
                              );
                            }),
                          ),
                        ),
                        Container(
                          //color: Colors.green,
                          padding: const EdgeInsets.all(20),
                          child: ListView(
                            children: List.generate(controller.l2.value.length,
                                (index) {
                              //print(l[index]);
                              return ListTile(
                                onTap: () {
                                  //
                                  setState(() {
                                    vue = Center(
                                      child: SizedBox(
                                        width: 400,
                                        child: MiseJE(controller.l2[index]),
                                      ),
                                    );
                                  });
                                  //
                                },
                                leading: const Icon(Icons.person),
                                title: Text(
                                    "${controller.l2[index]['nom']}  ${controller.l2[index]['postnom']}"),
                                subtitle: Text(
                                    "${controller.l2[index]['telephone']}"),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: vue!,
          )
        ],
      ),
    );
  }
}

class MiseJA extends GetView<EnregistrementController> {
  Map<String, dynamic> map;
  //
  MiseJA(this.map) {
    _nom.text = map['nom'];
    _postnom.text = map['postnom'];
    _prenom.text = map['prenom'];
    _email.text = map['email'];
    _adresse.text = map['adresse'];
    _matricule.text = map['matricule'];
    _telephone.text = map['telephone'];
    fonction = map['fonction'];
    controller.sexeC.value = map['genre'];
    controller.nEtude.value = map['niveauEtude'];
    controller.grade.value = map['grade'];
    controller.fonction.value = map['fonction'];
    //var fonctions = [];
    photopath.value = "${Utils.url}/piecejointe/photo/${map['id']}";
  }
  //
  //var _formKey = GlobalKey<FormState>();
  final _nom = TextEditingController();
  final _postnom = TextEditingController();
  final _matricule = TextEditingController();
  final _telephone = TextEditingController();
  final _adresse = TextEditingController();
  final _email = TextEditingController();
  final _prenom = TextEditingController();
  var fonction = "";
  var fonctions = [];
  RxString photopath = "".obs;
  //
  RxBool photopathv = true.obs;
  //
  RxInt choix = 1.obs;
  //
  //
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              "Mise à jour Agent",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(75),
                      ),
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Align(
                                alignment: Alignment.center,
                                child: photopathv.value
                                    ? Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          //color: Colors.green.shade700,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              photopath.value,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                      )
                                    : Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          //color: Colors.green.shade700,
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(photopath.value),
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20, right: 10),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                    );
                                    //
                                    if (result != null) {
                                      photopathv.value = false;
                                      photopath.value =
                                          result.files.single.path!;
                                    }
                                  },
                                  icon: Icon(
                                    Icons.photo_camera_front,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                        ),
                        //child: Image.file(file),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nom,
                          //obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir votre Nom';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "exemple: Lungu Joel",
                            labelText: 'Nom',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _postnom,
                          //obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir votre Postnomm';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "exemple: Lungu Joel",
                            labelText: 'Postnom',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _prenom,
                          //obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Champ obligatoire';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "exemple: Lungu Joel",
                            labelText: 'Prenom',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _telephone,
                          //obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir le téléphone';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "exemple: 123456789",
                            labelText: 'Téléphone',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _email,
                          //obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Champ obligatoire';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "exemple: Lungu Joel",
                            labelText: 'email',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _adresse,
                          //obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Champ obligatoire';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "exemple: kinshasa ...",
                            labelText: 'adresse',
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          //obscureText: true,
                          controller: _matricule,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir votre Matricule';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "exemple: xyz123@",
                            labelText: 'Matricule',
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Genre  "),
                              Expanded(
                                flex: 1,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: controller.sexeC.value,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blue,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.sexeC.value = newValue!;
                                    },
                                    items: <String>['F', 'M']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Niveau d'étude  "),
                              Expanded(
                                flex: 1,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: controller.nEtude.value,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blue,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.nEtude.value = newValue!;
                                    },
                                    items: <String>[
                                      'Doctora (Docteur)',
                                      'Master (Maitrise)',
                                      'Licence',
                                      'Graduat',
                                      'D6',
                                      'PP2',
                                      'Autres',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Grade  "),
                              Expanded(
                                flex: 1,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: controller.grade.value,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blue,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.grade.value = newValue!;
                                      if (newValue == "Chef de Division") {
                                        //
                                        fonction = "Chef de Division";
                                        fonctions = controller.options1;
                                        choix.value = 1;
                                        //
                                      } else if (newValue == "Chef de Bureau") {
                                        //
                                        fonction = "Chef de Bureau";
                                        fonctions = controller.options2;
                                        choix.value = 1;
                                        //
                                      } else if (newValue ==
                                          "Attaché d'Administration de 1eme classe") {
                                        //
                                        fonction =
                                            "Attaché d'Administration de 1eme classe";
                                        fonctions = controller.options3;
                                        choix.value = 2;
                                        //
                                      } else if (newValue ==
                                          "Attaché d'Administration de 2eme classe") {
                                        //
                                        fonction =
                                            "Attaché d'Administration de 2eme classe";
                                        fonctions = controller.options4;
                                        choix.value = 3;
                                        //
                                      } else if (newValue ==
                                          "Agent Auxiliaire de 2eme Classe") {
                                        //
                                        fonction =
                                            "Agent Auxiliaire de 2eme Classe";
                                        fonctions = controller.options5;
                                        choix.value = 4;
                                        //
                                      } else if (newValue == "Huissier") {
                                        //
                                        fonction = "Huissier";
                                        fonctions = controller.options6;
                                        choix.value = 5;
                                        //
                                      } else {
                                        //
                                        fonction = newValue;
                                        fonctions = controller.options6;
                                        choix.value = 6;
                                        //
                                      }
                                    },
                                    items: <String>[
                                      'Chef de Division',
                                      'Chef de Bureau',
                                      "Attaché d'Administration de 1eme classe",
                                      "Attaché d'Administration de 2eme classe",
                                      'Agent Auxiliaire de 2eme Classe',
                                      'Huissier',
                                      'Stagiaire',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 8,
                                child: Text("Fonction  "),
                              ),
                              Text("${controller.option1.value}  "),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  width: 100,
                                  height: 50,
                                  alignment: Alignment.centerRight,
                                  child: PopupMenuButton<String>(
                                      child: Icon(Icons.arrow_drop_down),
                                      initialValue: fonction,
                                      onSelected: (e) {
                                        controller.option1.value = e;
                                        //controller.option1.value
                                      },
                                      itemBuilder: (context) {
                                        return List.generate(fonctions.length,
                                            (index) {
                                          return PopupMenuItem(
                                            value: fonctions[index],
                                            child: Text("${fonctions[index]}"),
                                          );
                                        });
                                      }),
                                ),
                                /*
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: choix.value == 1
                                        ? controller.option1.value
                                        : choix.value == 2
                                            ? controller.option2.value
                                            : choix.value == 3
                                                ? controller.option3.value
                                                : choix.value == 4
                                                    ? controller.option4.value
                                                    : choix.value == 5
                                                        ? controller
                                                            .option5.value
                                                        : controller
                                                            .option6.value,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blue,
                                    ),
                                    onChanged: (String? newValue) {
                                      controller.nEtude.value = newValue!;
                                    },
                                    items: List.generate(
                                        choix.value == 1
                                            ? controller.options1.length
                                            : choix.value == 2
                                                ? controller.options2.length
                                                : choix.value == 3
                                                    ? controller.options3.length
                                                    : choix.value == 4
                                                        ? controller
                                                            .options4.length
                                                        : choix.value == 5
                                                            ? controller
                                                                .options5.length
                                                            : controller
                                                                .options6
                                                                .length,
                                        (index) {
                                      return DropdownMenuItem<String>(
                                        value: choix.value == 1
                                            ? controller.option1.value
                                            : choix.value == 2
                                                ? controller.option2.value
                                                : choix.value == 3
                                                    ? controller.option3.value
                                                    : choix.value == 4
                                                        ? controller
                                                            .option4.value
                                                        : choix.value == 5
                                                            ? controller
                                                                .option5.value
                                                            : controller
                                                                .option6.value,
                                        child: Text(
                                          choix.value == 1
                                              ? controller.option1.value
                                              : choix.value == 2
                                                  ? controller.option2.value
                                                  : choix.value == 3
                                                      ? controller.option3.value
                                                      : choix.value == 4
                                                          ? controller
                                                              .option4.value
                                                          : choix.value == 5
                                                              ? controller
                                                                  .option5.value
                                                              : controller
                                                                  .option6
                                                                  .value,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                */
                              )
                            ],
                          ),
                        ),
                        /*
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Bureau    "),
                              Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _nEtude,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                                  onChanged: (String? newValue) {
                                    // setState(() {
                                    //   _sexeC = newValue!;
                                    // });
                                  },
                                  items: <String>[
                                    'Doctora (Docteur)',
                                    'Master (Maitrise)',
                                    'Licence',
                                    'Graduat',
                                    'D6',
                                    'PP2',
                                    'Autres',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                        
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Grade     "),
                              Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: _nEtude,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                                  onChanged: (String? newValue) {
                                    // setState(() {
                                    //   _sexeC = newValue!;
                                    // });
                                  },
                                  items: <String>[
                                    'Doctora (Docteur)',
                                    'Master (Maitrise)',
                                    'Licence',
                                    'Graduat',
                                    'D6',
                                    'PP2',
                                    'Autres',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                        
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 110,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Grade     "),
                                      Text("..."),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 50,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Direction     "),
                                      Text("..."),
                                    ],
                                  ),
                                ),
                              ],
                            ))
                        */
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        //
                        final box = GetStorage();
                        //
                        Map<String, dynamic> u = {
                          "nom": _nom.text,
                          "postnom": _postnom.text,
                          "prenom": _prenom.text,
                          "email": _email.text,
                          "adresse": _adresse.text,
                          "matricule": "${_matricule.text}",
                          "telephone": "${_telephone.text}",
                          "niveauEtude": controller.nEtude.value,
                          "genre": controller.sexeC.value,
                          "grade": controller.grade.value,
                          "fonction": fonction,
                        };
                        //
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
                        controller.update_agent(
                            u, photopathv.value, photopath.value);
                        //
                      },
                      child: const Text("Enregistrer"),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  showMessage(String message) {
    Get.snackbar("Action", message, duration: Duration(seconds: 7));
  }
}

enum BestTutorSite { ini, con }

class MiseJE extends StatelessWidget {
  //
  var box = GetStorage();
  //
  RxString filiere = "Autre".obs;
  //
  List listeFiliere = [];
  //
  Map<String, dynamic> map;
  //
  MiseJE(this.map) {
    _nom.text = map['nom'];
    _postnom.text = map['postnom'];
    _email.text = map['email'];
    _telephone.text = map['telephone'];
    _postnom.text = map['postnom'];
    _promotion.text = map['promotion'];
    _telephone.text = map['telephone'];
    //
    sexeC.value = '${map['genre']}';
    nEtude.value = "${map['niveauEtude']}";
    photopath.value = "${Utils.url}/piecejointe/photo/${map['id']}";
    //
    if (box.read("filiere") != null) {
      listeFiliere = box.read("filiere");
    } else {
      listeFiliere.add("Autre");
    }
  }
  //
  var _formKey = GlobalKey<FormState>();
  final _nom = TextEditingController();
  final _postnom = TextEditingController();
  final _filiere = TextEditingController();
  final _email = TextEditingController();
  final _telephone = TextEditingController();
  final _promotion = TextEditingController();
  RxString categorie = "Unitiale".obs;
  //
  BestTutorSite _site = BestTutorSite.ini;
  //
  RxString photopath = "".obs;
  //
  RxBool photopathv = true.obs;
  //
  RxString sexeC = 'F'.obs;
  RxString nEtude = "Licence".obs;
  RxString fonction = "Licence".obs;
  RxString division = "Licence".obs;
  RxString bureau = "Licence".obs;
  RxString grade = "Licence".obs;

  //
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            alignment: Alignment.center,
            child: Text(
              "Enregistrement Eleve",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(75),
                      ),
                      child: Container(
                        height: 150,
                        width: 150,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.zero,
                              child: Align(
                                alignment: Alignment.center,
                                child: photopathv.value
                                    ? Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          //color: Colors.green.shade700,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              photopath.value,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                      )
                                    : Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          //color: Colors.green.shade700,
                                          image: DecorationImage(
                                            image: FileImage(
                                              File(photopath.value),
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                      ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20, right: 10),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: IconButton(
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.image,
                                    );
                                    //
                                    if (result != null) {
                                      photopathv.value = false;
                                      photopath.value =
                                          result.files.single.path!;
                                    }
                                  },
                                  icon: Icon(
                                    Icons.photo_camera_front,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(75),
                        ),
                        //child: Image.file(file),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _nom,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir votre Nom';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "exemple: Lungu Joel",
                            labelText: 'Nom',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _postnom,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir votre Nom';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "exemple: Lungu Joel",
                            labelText: 'Post-nom',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _email,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Veuillez saisir l'email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "exemple: xyz123@gmail.com",
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _telephone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir votre téléphone';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "Téléphone",
                            labelText: 'Téléphone',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Genre  "),
                              Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: sexeC.value,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                                  onChanged: (String? newValue) {
                                    sexeC.value = newValue!;
                                  },
                                  items: <String>['F', 'M']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Niveau d'étude  "),
                              Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: nEtude.value,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                                  onChanged: (String? newValue) {
                                    nEtude.value = newValue!;
                                  },
                                  items: <String>[
                                    'Doctora (Docteur)',
                                    'Master (Maitrise)',
                                    'Licence',
                                    'Graduat',
                                    'D6',
                                    'PP2',
                                    'Autres',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Filière  "),
                              Expanded(
                                flex: 1,
                                child: DropdownButton<String>(
                                  isExpanded: true,
                                  value: filiere.value,
                                  icon: const Icon(Icons.arrow_downward),
                                  elevation: 16,
                                  style:
                                      const TextStyle(color: Colors.deepPurple),
                                  underline: Container(
                                    height: 2,
                                    color: Colors.blue,
                                  ),
                                  onChanged: (String? newValue) {
                                    filiere.value = newValue!;
                                  },
                                  items: listeFiliere
                                      .map<DropdownMenuItem<String>>((value) {
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
                        const SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            ListTile(
                              title: const Text('Unitiale'),
                              leading: Radio(
                                value: BestTutorSite.ini,
                                groupValue: _site,
                                onChanged: (BestTutorSite? value) {
                                  _site = value!;
                                  categorie.value = "Unitiale";
                                },
                              ),
                            ),
                            ListTile(
                              title: const Text('Continue'),
                              leading: Radio(
                                value: BestTutorSite.con,
                                groupValue: _site,
                                onChanged: (BestTutorSite? value) {
                                  _site = value!;
                                  categorie.value = "Continue";
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _promotion,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Veuillez saisir la promotion';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "exemple: ...",
                            labelText: 'Promotion',
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          //
                          EnregistrementController enregistrementController =
                              Get.find();
                          //
                          Map<String, dynamic> u = {
                            "id": "${map['id']}",
                            "nom": _nom.text,
                            "postnom": _postnom.text,
                            "email": "${_email.text}",
                            "telephone": "${_telephone.text}",
                            "idcarte": "${map['idcarte']}",
                            "filiere": filiere.value,
                            "genre": "${sexeC.value}",
                            "niveauEtude": "${nEtude.value}",
                            "categorie": "$categorie",
                            "promotion": "${_promotion.text}"
                          };
                          //
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
                          print("la valeur: ${jsonEncode(u)}");
                          //
                          enregistrementController.update_eleve(
                              u, photopathv.value, photopath.value);
                          //
                        },
                        child: Text("Enregistrer"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
