import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Admin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Admin();
  }
}

class _Admin extends State<Admin> with TickerProviderStateMixin {
  List l = ["Filière", "plus"];
  List listeFiliere = [];
  late TabController _controller = TabController(length: 2, vsync: this);
  TextEditingController text = TextEditingController();
  //
  var box = GetStorage();
  //

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
    return Center(
      child: Container(
        width: 400,
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
                                    onPressed: () {},
                                  ),
                                );
                              }
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
}
