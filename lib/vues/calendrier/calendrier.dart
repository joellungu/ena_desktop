import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../abscence/abscence_controller.dart';
import 'calendrier_controller.dart';
import 'details_agent.dart';
import 'vue_du_mois.dart';

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
  //
  CalendrierController calendrierController = Get.find();

  TextEditingController mois = TextEditingController();
  TextEditingController annee = TextEditingController();

  RxInt jours = 0.obs;
  String noms = "";
  //
  Widget? vueD;
  Widget? vueC;

  _Calendrier() {
    //
    mois.text = "${DateTime.now().month}";
    //
    annee.text = "${DateTime.now().year}";
    //
    controller.saveAgent();
    controller.saveEleve();
    //
    jours.value =
        DateUtils.getDaysInMonth(DateTime.now().year, DateTime.now().month);
  }

  RxInt idAgent = (-1).obs;

  @override
  void initState() {
    //
    vueC = Container();
    vueD = Container();
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
                          flex: 3,
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
                        Expanded(
                          flex: 7,
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: annee,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                            decoration: InputDecoration(
                              hintText: "$annee",
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
                                  idAgent.value = controller.l1[index]['id'];
                                  //print(idAgent.value);
                                  //
                                  calendrierController.mois_a(
                                    "${controller.l1[index]['id']}",
                                    mois.text.length == 1
                                        ? "0${mois.text}"
                                        : mois.text,
                                    annee.text,
                                  );
                                  //
                                  calendrierController.mois_p(
                                    //idcarte
                                    "${controller.l1[index]['idcarte']}",
                                    mois.text.length == 1
                                        ? "0${mois.text}"
                                        : mois.text,
                                    annee.text,
                                  );
                                  calendrierController.mois_all_m(
                                    "${controller.l1[index]['id']}",
                                    mois.text.length == 1
                                        ? "0${mois.text}"
                                        : mois.text,
                                    annee.text,
                                  );
                                  //print(DateTime.now());
                                  //
                                  setState(() {
                                    vueD = DetailsAgent(
                                      UniqueKey(),
                                      controller.l1[index],
                                    );
                                    vueC = MoisVue(
                                      UniqueKey(),
                                      controller.l1[index],
                                      int.parse(mois.text),
                                      int.parse(annee.text),
                                    );
                                  });
                                  //
                                },
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: idAgent.value ==
                                                controller.l1[index]['id']
                                            ? Colors.blue
                                            : Colors.black),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          "http://localhost:8080/piecejointe/photo/${controller.l1[index]['id']}",
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                title: Text(
                                  "${controller.l1[index]['nom']}  ${controller.l1[index]['postnom']}",
                                  style: TextStyle(
                                    color: idAgent.value ==
                                            controller.l1[index]['id']
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
                                subtitle: Text(
                                  "${controller.l1[index]['matricule']}",
                                  style: TextStyle(
                                    color: idAgent.value ==
                                            controller.l1[index]['id']
                                        ? Colors.blue
                                        : Colors.black,
                                  ),
                                ),
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
