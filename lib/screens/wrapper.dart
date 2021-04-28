import 'package:coffiebro/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:coffiebro/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:coffiebro/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);


    //return home or auth
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}