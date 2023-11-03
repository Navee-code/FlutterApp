import 'package:flutter/material.dart';
import 'ContentState.dart';

void main() => runApp(const MaterialApp(
      home: LoginScreen(),
    ));

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.all(20),
                width: 300,
                child: TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(gapPadding: 5),
                    hintText: 'User name',
                  ),
                )),
            SizedBox(
                width: 300,
                child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password',
                  ),
                )),
            Container(
              width: 300,
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              child: const Text('Forgot Password?'),
            ),
            Container(
              width: 120,
              height: 35,
              margin: const EdgeInsets.all(20),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.pink),
                  ),
                  onPressed: () {
                    //  showEmptyTitleDialog(context);
                    if (passwordController.text.isNotEmpty && usernameController.text.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ContentState(
                                  title: usernameController.text)));
                    }
                  },
                  child: const Text("Login")),
            )
          ],
        ),
      ),
    );
  }
}



