import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'calendrier_controller.dart';

class DetailsAgent extends StatefulWidget {
  Map<String, dynamic> infos = {};
  DetailsAgent(Key key, this.infos) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _DetailsAgent();
  }
}

class _DetailsAgent extends State<DetailsAgent> {
  //
  CalendrierController cc = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView(
          controller: ScrollController(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    image: DecorationImage(
                        image: NetworkImage(
                          "http://localhost:8080/piecejointe/photo/${widget.infos['id']}",
                        ),
                        fit: BoxFit.fill),
                  ),
                ),
              ],
            ),
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
              subtitle: Text(
                "${cc.nombreHeure} H",
                style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(cc.listDeAbscenceMonth.length, (index) {
                var d1 =
                    DateTime.parse(cc.listDeAbscenceMonth[index]['dateDebut']);
                var d2 =
                    DateTime.parse(cc.listDeAbscenceMonth[index]['dateFin']);
                //
                Duration du = d2.difference(d1);
                print("durée en heure: ${du.inHours}");
                return ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            //
                            title: const Text("Abscence justifié"),
                            content: Text(
                                "${cc.listDeAbscenceMonth[index]['motifs']}"),
                          );
                        });
                  },
                  leading: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  title: const Text("Abscence justifié"),
                  subtitle: Text(
                    "${du.inDays} J",
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
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
              title: const Text(
                "Abscence non justifié",
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
              subtitle: Text(
                "${cc.nombreJourPartiel} J",
                style: const TextStyle(
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
              subtitle: Text(
                "${cc.nombreHeure} J",
                style: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ));
  }
}
