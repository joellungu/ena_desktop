import 'package:ena_desktop/vues/agents/ajouter/enregistrement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Admin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Admin();
  }
}

class _Admin extends State<Admin> with TickerProviderStateMixin {
  List l = ["Filière", "Mot de passe", "Promotion", "Fonction", "Plus"];
  //
  EnregistrementController enregistrementController = Get.find();
  //
  List listeFiliere = [];
  late TabController _controller = TabController(length: 5, vsync: this);
  TextEditingController text = TextEditingController();
  //
  TextEditingController textFonction = TextEditingController();
  //
  TextEditingController promotion = TextEditingController();
  //
  List listeFonction = [];
  //
  String titreFonction = "";
  //
  String grade = "Chef de Division";
  //
  var box = GetStorage();
  //
  var _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    if (box.read("filiere") != null) {
      listeFiliere = box.read("filiere");
    } else {
      listeFiliere.add("Autre");
    }
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (box.read("admin") != null) {
      //
      Map<String, dynamic> infosAdmin = box.read("admin");
      _emailController.text = infosAdmin['email'];
      _passwordController.text = infosAdmin['pwd'];
    }
    return Center(
      child: Container(
        width: 450,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
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
                tabs: List.generate(l.length, (index) {
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
              child: TabBarView(
                controller: _controller,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        TextField(
                          controller: text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (text.text.isNotEmpty) {
                                setState(() {
                                  listeFiliere.add(text.text);
                                  //
                                  box.write("filiere", listeFiliere);
                                });
                              }
                            },
                            child: const Text("Ajoutter")),
                        Column(
                          children: List.generate(
                            listeFiliere.length,
                            (index) {
                              if (index == 0) {
                                return ListTile(
                                  title: Text("${listeFiliere[index]}"),
                                  subtitle: Text("${listeFiliere[index]}"),
                                );
                              } else {
                                return ListTile(
                                  title: Text("${listeFiliere[index]}"),
                                  subtitle: Text("${listeFiliere[index]}"),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      setState(() {
                                        listeFiliere.removeAt(index);
                                      });
                                    },
                                  ),
                                );
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 350,
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(50),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: _emailController,

                                ///obscureText: true,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez saisir votre email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "exemple: exemple@gmail.com",
                                  labelText: 'Email',
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                obscureText: true,
                                controller: _passwordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Veuillez saisir votre mot de passe';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "exemple: xyz123@",
                                  labelText: 'Mot de passe',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    var box = GetStorage();
                                    String em = _emailController.text;
                                    String ps = _passwordController.text;
                                    //
                                    Map<String, dynamic> infosAdmin = {
                                      "email": _emailController.text,
                                      "pwd": _passwordController.text,
                                    };
                                    box.write("admin", infosAdmin);
                                    Get.snackbar("SUCCES",
                                        "Enregistrement éffectué avec succé");
                                    //
                                  }
                                },
                                child: const Text("Changer"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        TextField(
                          controller: promotion,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              box.write("promotion", promotion.text);
                              Get.snackbar("SUCCES",
                                  "Enregistrement éffectué avec succé");
                              //
                            },
                            child: const Text("Enregistrer")),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
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
                                    value: grade,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.blue,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        grade = newValue!;
                                        if (newValue == "Chef de Division") {
                                          //
                                          titreFonction = "Chef de Division";
                                          loadBySelect(titreFonction);
                                        } else if (newValue ==
                                            "Chef de Bureau") {
                                          //
                                          titreFonction = "Chef de Bureau";
                                          loadBySelect(titreFonction);
                                        } else if (newValue ==
                                            "Attaché d'Administration de 1eme classe") {
                                          //
                                          titreFonction =
                                              "Attaché d'Administration de 1eme classe";
                                          loadBySelect(titreFonction);
                                          //
                                        } else if (newValue ==
                                            "Attaché d'Administration de 2eme classe") {
                                          //
                                          titreFonction =
                                              "Attaché d'Administration de 2eme classe";
                                          loadBySelect(titreFonction);
                                          //
                                        } else if (newValue ==
                                            "Agent Auxiliaire de 2eme Classe") {
                                          //
                                          titreFonction =
                                              "Agent Auxiliaire de 2eme Classe";
                                          loadBySelect(titreFonction);
                                          //
                                        } else if (newValue == "Huissier") {
                                          //
                                          titreFonction = "Huissier";
                                          loadBySelect(titreFonction);
                                          //
                                        } else {
                                          //
                                          titreFonction = "";
                                          loadBySelect(titreFonction);
                                          //
                                        }
                                      });
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
                        TextField(
                          controller: textFonction,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (textFonction.text.isNotEmpty) {
                                setState(() {
                                  if (box.read(titreFonction) != null) {
                                    //
                                    listeFonction = box.read(titreFonction);
                                    listeFonction.add(textFonction.text);
                                    //
                                    box.write(titreFonction, listeFonction);
                                    //
                                  } else {
                                    //
                                    listeFonction.clear();
                                    //
                                    //listeFonction = box.read(titreFonction);
                                    //
                                    listeFonction.add(textFonction.text);
                                    //
                                    box.write(titreFonction, listeFonction);
                                    //
                                  }
                                });
                              } else {
                                Get.snackbar("ERREUR",
                                    "Veuillez saisir un text dans le champ");
                              }
                            },
                            child: const Text("Ajoutter")),
                        Column(
                          children: List.generate(
                            listeFonction.length,
                            (index) {
                              return ListTile(
                                title: Text("${listeFonction[index]}"),
                                subtitle: Text("${listeFonction[index]}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      listeFonction.removeAt(index);
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(),
                ],
              ),
            )
          ],
        ),
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
}
