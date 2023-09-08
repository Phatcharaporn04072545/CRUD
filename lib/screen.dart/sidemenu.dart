import 'package:flutter/material.dart';
import 'package:flutter_application_20/models/config.dart';
import 'package:flutter_application_20/models/user.dart';
import 'package:flutter_application_20/screen.dart/home.dart';
import 'package:flutter_application_20/screen.dart/login.dart';
// import 'package:flutter_application_20/screen.dart/order.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    String accountName = "N/A";
    String accountEmail = "N/A";
    String accountUrl =
        "https://images.pexels.com/photos/825947/pexels-photo-825947.jpeg?auto=compress&cs=tinysrgb&w=600";

    Users user = Configure.login;
    //print(user.toJson().toString());
    if (user.id != null) {
      accountName = user.email!;
      accountEmail = user.password!;
    }
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountName),
            accountEmail: Text(accountEmail),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(accountUrl),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Shopping Cart'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Login()));
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Order'),
            // onTap: () {
            //   Navigator.push(
            //       context, MaterialPageRoute(builder: (context) => Login()));
            // },
          ),
        ],
      ),
    );
  }
}
