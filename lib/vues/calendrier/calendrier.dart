import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../abscence/abscence_controller.dart';
import 'calendrier_controller.dart';

class Calendrier extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Calendrier();
  }
}

class _Calendrier extends State<Calendrier> with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  //
  List l = ["Agent", "Eleve"];
  List ll = [];
  //
  late TabController _controller = TabController(length: 2, vsync: this);
  //
  AbscenceController controller = Get.find();
  CalendrierController calendrierController = Get.find();

  TextEditingController mois = TextEditingController();
  RxInt jours = 0.obs;
  String noms = "";
  //
  Widget? vueD;
  Widget? vueC;

  _Calendrier() {
    //
    mois.text = "${DateTime.now().month}";
    //
    controller.saveAgent();
    controller.saveEleve();
    //
    jours.value =
        DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month);
  }

  int x = 1; //Une variable pour le test

  @override
  void initState() {
    calendrierController.listeFictif.value.clear();
    //
    vueC = Container();
    vueD = Container();

    while (x < 21) {
      calendrierController.listeFictif.add({
        "idcarte": "1234567",
        "present": true,
        "lelo": "2022-7-$x-8",
        "dateArrive": "2022-7-$x-8",
        "dateDepart": "2022-7-$x-18"
      });
      x++;
    }
    calendrierController.listeFictif.add({
      "idcarte": "1234567",
      "present": true,
      "lelo": "2022-7-21-8",
      "dateArrive": "2022-7-21-8",
      "dateDepart": null
    });
    calendrierController.listeFictif.add({
      "idcarte": "1234567",
      "present": true,
      "lelo": "2022-7-22-8",
      "dateArrive": "2022-7-22-8",
      "dateDepart": null
    });
    calendrierController.listeFictif.add({
      "idcarte": "1234567",
      "present": false,
      "lelo": "2022-7-23-8",
      "dateArrive": "2022-7-23-8",
      "dateDepart": "2022-7-23-18"
    });
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
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
                Container(
                  height: 50,
                  //color: Colors.blue,
                  alignment: Alignment.center,
                  child: Container(
                    width: 200,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: mois,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                            decoration: InputDecoration(
                              hintText: "$mois",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                              print("${controller.l1[index]}");
                              return ListTile(
                                onTap: () {
                                  jours.value = DateUtils.getDaysInMonth(
                                    DateTime.now().year,
                                    int.parse(mois.text),
                                  );
                                  //
                                  setState(() {
                                    vueD = DetailsAgent(controller.l1[index]);
                                    vueC = MoisVue(
                                      UniqueKey(),
                                      controller.l1[index],
                                    );
                                  });
                                  //
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
            flex: 3,
            child: Container(
              padding: const EdgeInsets.only(top: 40),
              child: vueD,
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: const EdgeInsets.only(right: 40),
              child: vueC,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsAgent extends StatefulWidget {
  Map<String, dynamic> infos = {};
  DetailsAgent(this.infos);
  @override
  State<StatefulWidget> createState() {
    return _DetailsAgent();
  }
}

class _DetailsAgent extends State<DetailsAgent> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: ScrollController(),
      children: [
        Text(
          "${widget.infos['nom']} ${widget.infos['postnom']} ${widget.infos['prenom']}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "${widget.infos['matricule']}",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          title: const Text("Nombre d'heure"),
          subtitle: const Text(
            "120h",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          title: const Text("Abscence justifié"),
          subtitle: const Text(
            "10j",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          title: const Text("Abscence non justifié"),
          subtitle: const Text(
            "10j",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          title: const Text("Partielle"),
          subtitle: const Text(
            "10j",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListTile(
          leading: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          title: const Text("Presence"),
          subtitle: const Text(
            "10j",
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class MoisVue extends StatefulWidget {
  Map<String, dynamic> d;
  MoisVue(Key key, this.d) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MoisVue();
  }
}

class _MoisVue extends State<MoisVue> {
  double v = 25;
  var d = 0;
  var nombreDeJours;
  //
  CalendrierController cc = Get.find();
  //
  @override
  void initState() {
    //
    super.initState();
    //
    nombreDeJours =
        DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month);
    print("longueur du mois: ${nombreDeJours}");
    //
  }

  repartiteur() {
    //
    d = DateUtils.firstDayOffset(
      DateTime.now().year,
      DateTime.now().month,
      MaterialLocalizations.of(context),
    ); //

    nombreDeJours = nombreDeJours + (d - 2);
    d = d - 2;
    print("La vaut: $d");
    print("La vaut: $nombreDeJours");
    var dd = DateTime(DateTime.now().year, DateTime.now().month);
    print(dd);
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
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
            child: Container(
              child: GridView.count(
                controller: ScrollController(),
                crossAxisCount: 7,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                childAspectRatio: 1,
                children: List.generate(nombreDeJours + 1, (index) {
                  if (index <= d) {
                    return Card(
                        elevation: 0, color: Colors.white, child: Container());
                  } else {
                    bool venu = false;
                    bool parti = false;
                    cc.listeFictif.forEach((e) {
                      if (int.parse("${e['lelo']}".split("-")[2]) ==
                          index - d) {
                        if (e['present']) {
                          venu = true;
                          //print(":: ${e['dateDepart']}");
                          if (e['dateDepart'] != null) {
                            parti = true;
                          } else {
                            print("datedepart: ${e['dateDepart']}");
                            parti = false;
                          }
                          print("condition: ${e['lelo']} $venu : $parti");
                        } else {
                          venu = false;
                          parti = false;
                        }
                      }
                    });
                    return InkWell(
                      onTap: () {
                        //
                        var d = DateUtils.firstDayOffset(
                            DateTime.now().year,
                            DateTime.now().month,
                            MaterialLocalizations.of(context));
                        print("La vaut: $d");
                        var dd =
                            DateTime(DateTime.now().year, DateTime.now().month);
                        print(dd);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: venu && parti
                                ? Colors.blue
                                : venu || parti
                                    ? Colors.orange
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "${index - d}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: v,
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
