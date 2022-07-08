import 'package:flutter/material.dart';

class Supprimer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Supprimer();
  }
}

class _Supprimer extends State<Supprimer> {
  @override
  void initState() {
    //
    //controller = TabController(length: 2, vsync: this);
    //
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Matricule",
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
                  onPressed: () {},
                  icon: Icon(Icons.search),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(),
        )
      ],
    );
  }
}

/*
*/