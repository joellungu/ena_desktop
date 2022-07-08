import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'enregistrement_controller.dart';

enum BestTutorSite { ini, con }

class EnregistrementEtudiant extends StatelessWidget {
  //
  var box = GetStorage();
  //
  List listeFiliere = [];
  //
  EnregistrementEtudiant() {
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
  final _adresse = TextEditingController();
  final _prenom = TextEditingController();
  RxString categorie = "Unitiale".obs;
  //
  BestTutorSite _site = BestTutorSite.ini;
  RxString filiere = "Autre".obs;
  //
  RxString sexeC = 'F'.obs;
  RxString nEtude = "Licence".obs;
  RxString fonction = "Licence".obs;
  RxString division = "Licence".obs;
  RxString bureau = "Licence".obs;
  RxString grade = "Licence".obs;
  //
  RxString photopath = "".obs;

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
                            "nom": _nom.text,
                            "postnom": _postnom.text,
                            "prenom": _prenom.text,
                            "email": _email.text,
                            "adresse": _adresse.text,
                            "telephone": "${_telephone.text}",
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
                          enregistrementController.saveEleve(
                              u, photopath.value);
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
