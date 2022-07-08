import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logincontroller.dart';

class Login extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  LoginController loginController = Get.find();
  //
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 350,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Container(
                  height: 300,
                  width: 300,
                  child: Image.asset(
                      "assets/WhatsApp Image 2022-06-12 at 19.45.12.jpeg"),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
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
                            /*
                        Timer(const Duration(seconds: 4), () {
                          Get.snackbar("Correct", "Un simple message!");
                        });
                        */
                            //Get.off(Accueil());
                            //
                            loginController.setLoager(true);
                          }
                        },
                        child: Text("Login"),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
