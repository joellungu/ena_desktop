import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'enregistrement_controller.dart';

class EnregistrementAgent extends GetView<EnregistrementController> {
  //
  var _formKey = GlobalKey<FormState>();
  final _nom = TextEditingController();
  final _postnom = TextEditingController();
  final _matricule = TextEditingController();
  final _telephone = TextEditingController();
  final _adresse = TextEditingController();
  final _email = TextEditingController();
  final _prenom = TextEditingController();
  var fonction = "";
  var fonctions = [];
  List listeFonction = [];
  //
  RxString photopath = "".obs;
  //
  RxInt choix = 1.obs;
  //
  var box = GetStorage();
  //
  EnregistrementAgent() {
    fonction = "${controller.option1.value}";
    fonctions = controller.options1;
  }
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
              "Enregistrement Agent",
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
                                child: photopath.value == ""
                                    ? Container(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.person,
                                          size: 100,
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
                        const SizedBox(
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
                        const SizedBox(
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
                        const SizedBox(
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Genre  "),
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text("Niveau d'étude  "),
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
                        const SizedBox(
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
                                        loadBySelect(fonction);
                                        //
                                      } else if (newValue == "Chef de Bureau") {
                                        //
                                        fonction = "Chef de Bureau";
                                        fonctions = controller.options2;
                                        choix.value = 1;
                                        loadBySelect(fonction);
                                        //
                                      } else if (newValue ==
                                          "Attaché d'Administration de 1eme classe") {
                                        //
                                        fonction =
                                            "Attaché d'Administration de 1eme classe";
                                        fonctions = controller.options3;
                                        choix.value = 2;
                                        loadBySelect(fonction);
                                        //
                                      } else if (newValue ==
                                          "Attaché d'Administration de 2eme classe") {
                                        //
                                        fonction =
                                            "Attaché d'Administration de 2eme classe";
                                        fonctions = controller.options4;
                                        choix.value = 3;
                                        loadBySelect(fonction);
                                        //
                                      } else if (newValue ==
                                          "Agent Auxiliaire de 2eme Classe") {
                                        //
                                        fonction =
                                            "Agent Auxiliaire de 2eme Classe";
                                        fonctions = controller.options5;
                                        choix.value = 4;
                                        loadBySelect(fonction);
                                        //
                                      } else if (newValue == "Huissier") {
                                        //
                                        fonction = "Huissier";
                                        fonctions = controller.options6;
                                        choix.value = 5;
                                        loadBySelect(fonction);
                                        //
                                      } else {
                                        //
                                        fonction = newValue;
                                        fonctions = controller.options6;
                                        choix.value = 6;
                                        loadBySelect(fonction);
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
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          //height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Fonction  "),
                              Expanded(
                                flex: 8,
                                child: Text("${controller.option1.value}  "),
                              ),
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
                                    },
                                  ),
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
                        /*
                        */
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
                        controller.saveAgent(u, photopath.value);
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
      ),
    );
  }

  loadBySelect(String titreFonction) {
    if (box.read(titreFonction) != null) {
      //
      listeFonction = box.read(titreFonction);
      //
    }
    //
  }

  showMessage(String message) {
    Get.snackbar("Action", message, duration: Duration(seconds: 7));
  }
}
