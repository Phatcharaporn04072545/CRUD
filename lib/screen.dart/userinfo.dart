import 'package:flutter/material.dart';
import 'package:flutter_application_20/models/products.dart';





class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    var user = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info"),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          child: ListView(
            children: [
              ListTile(
                title: Text("Name"),
                subtitle: Text("${user.name}"),
              ),
              ListTile(
                title: Text("list"),
                subtitle: Text("${user.list}"),
              ),ListTile(
                title: Text("Quantity"),
                subtitle: Text("${user.quantity}"),
              ),
              ListTile(
                title: Text("Date"),
                subtitle: Text("${user.date}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}