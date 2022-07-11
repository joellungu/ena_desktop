import 'dart:async';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'presence_controller.dart';

class Presence extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Presence();
  }
}

class _Presence extends State<Presence> with TickerProviderStateMixin {
  //
  TabController? controller;
  List angles = ["Agents", "Eleves"];
  //alls
  PresenceController presenceController = Get.find();
  Timer? time;

  @override
  void initState() {
    //
    //presenceController.l1.clear();
    //presenceController.l2.clear();
    //
    DateTime dd = DateTime.now();
    //
    time = Timer.periodic(const Duration(seconds: 5), (t) {
      presenceController.alls(
        "$dd",
        this,
      );
      setState(() {});
    });
    //
    controller = TabController(length: 2, vsync: this);
    //
    super.initState();
  }

  @override
  void dispose() {
    time!.cancel();
    //
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          //color: Colors.blue,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TabBar(
                isScrollable: true,
                controller: controller,
                indicatorWeight: 1,
                //indicator: BoxDecoration(),
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
                tabs: List.generate(angles.length, (index) {
                  return Tab(
                    text: angles[index],
                  );
                }),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: TabBarView(
            controller: controller,
            children: [
              Agent_P(),
              Eleve_P(),
            ],
          ),
        )
      ],
    );
  }
}

class Agent_P extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Agent_P();
  }
}

class _Agent_P extends State<Agent_P> {
  //
  PresenceController presenceController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: const [
          DataColumn2(
            label: Text(
              'Nom',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text(
              'Postnom',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Prenom',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataColumn2(
              label: Text(
                'Genre',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              size: ColumnSize.S),
          DataColumn(
            label: Text(
              'Grade',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Fonction',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Matricule',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'HA',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'H.D',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
        ],
        rows: List<DataRow>.generate(presenceController.l1.length, (index) {
          //print('${presenceController.l1[index]}');
          return DataRow(
            cells: [
              DataCell(Text('${presenceController.l1[index]['nom']}')),
              DataCell(Text('${presenceController.l1[index]['postnom']}')),
              DataCell(Text('${presenceController.l1.value[index]['prenom']}')),
              DataCell(Text('${presenceController.l1[index]['genre']}')),
              DataCell(Text('${presenceController.l1[index]['grade']}')),
              DataCell(Text('${presenceController.l1[index]['fonction']}')),
              DataCell(Text('${presenceController.l1[index]['matricule']}')),
              DataCell(Text('${presenceController.l1[index]['da'] ?? ''}')),
              DataCell(Text('${presenceController.l1[index]['dd'] ?? ''}'))
            ],
          );
        }),
      ),
    );
  }
}

class Eleve_P extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Eleve_P();
  }
}

class _Eleve_P extends State<Eleve_P> {
  //
  PresenceController presenceController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 600,
        columns: const [
          DataColumn2(
            label: Text(
              'Nom',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text(
              'Postnom',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Prenom',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Email',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          DataColumn(
            label: Text(
              'Téléphone',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Genre',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'Catégorie',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'HA',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
          DataColumn(
            label: Text(
              'H.D',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            numeric: true,
          ),
        ],
        rows: List<DataRow>.generate(
          presenceController.l2.value.length,
          (index) => DataRow(
            cells: [
              DataCell(Text('${presenceController.l2.value[index]['nom']}')),
              DataCell(
                  Text('${presenceController.l2.value[index]['postnom']}')),
              DataCell(Text('${presenceController.l2.value[index]['prenom']}')),
              DataCell(Text('${presenceController.l2.value[index]['email']}')),
              DataCell(
                  Text('${presenceController.l2.value[index]['telephone']}')),
              DataCell(Text('${presenceController.l2.value[index]['genre']}')),
              DataCell(
                  Text('${presenceController.l2.value[index]['categorie']}')),
              DataCell(Text('${presenceController.l2.value[index]['da']}')),
              DataCell(Text("${presenceController.l2.value[index]['dd']}"))
            ],
          ),
        ),
      ),
    );
  }
}
