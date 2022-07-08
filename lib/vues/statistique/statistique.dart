import 'package:flutter/material.dart';

class Statistique extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
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
                                hintText: "Nom de l'agent",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
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
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(),
          ),
        ],
      ),
    );
  }
}
