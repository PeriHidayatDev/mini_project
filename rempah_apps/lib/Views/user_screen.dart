import 'package:flutter/material.dart';
import 'package:rempah_apps/Auth/login.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width * .9,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.deepOrange),
          child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const Text(
              "LOGOUT",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
