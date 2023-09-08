
import 'dart:convert';
// import 'package:email_validator/email_validator.dart';
import 'package:flutter_application_20/models/products.dart';
import 'package:http/http.dart' as http ;
import 'package:flutter/material.dart';
import 'package:flutter_application_20/models/config.dart';
import 'package:flutter_application_20/models/user.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => __UserFormState();
}

class __UserFormState extends State<UserForm> {
  final _formkey = GlobalKey<FormState>();
  //Users user = Users();
  late Product user = Product();

  Future<void> addNewUser(user) async {
    var url = Uri.http(Configure.server, "user");
    var resp = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    var rs = usersFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  Future<void> updateData(user) async {
    var url = Uri.http(Configure.server, "user/${user.id}");
    var resp = await http.put(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
    var rs = productFromJson("[${resp.body}]");
    if (rs.length == 1) {
      Navigator.pop(context, "refresh");
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    try {
      user = ModalRoute.of(context)!.settings.arguments as Product;
      print(user.name);
    } catch (e) {
      // user = Users();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Form"),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameInputField(),
                  listInputField(),
                  quantityInputField(),
                  dateInputField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  SubmitButton(),
                ],
              )),
        ));
  }

  Widget nameInputField() {
    return TextFormField(
      initialValue: user.name,
      decoration: InputDecoration(
        labelText: 'Fullname:',
        icon: Icon(Icons.person),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is requried';
        }
        return null;
      },
      onSaved: (newValue) => user.name = newValue,
    );
  }

  Widget quantityInputField() {
    return TextFormField(
      // initialValue: user.email,
      decoration: InputDecoration(
        labelText: 'จำนวนสินค้า',
        icon: Icon(Icons.email),
      ),
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     return 'This field is requried';
      //   }
      //   if (!EmailValidator.validate(value)) {
      //     return 'It is not email format';
      //   }
      //   return null;
      // },
      onSaved: (newValue) => user.quantity = newValue!,
    );
  }

  Widget dateInputField() {
    return TextFormField(
      initialValue: user.date,
      // obscureText: true,
      decoration:
          InputDecoration(labelText: 'Date', icon: Icon(Icons.lock)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) => user.date = newValue!,
    );
  }

  Widget listInputField() {
    // ignore: unused_local_variable
    var initGen = "None";
    try {
      if (!user.list!.isEmpty) {
        initGen = user.list!;
      }
    } catch (e) {
      initGen = "None";
    }
    return DropdownButtonFormField(
        decoration: InputDecoration(
          labelText: 'รายการสินค้า:',
          icon: Icon(Icons.man),
        ),
        value: 'None',
        items: Configure.list.map((String val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val),
          );
        }).toList(),
        onChanged: (value) {
          user.list = value;
        },
        onSaved: (newValue) => user.list);
  }

  Widget SubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          if (user.id == null) {
            addNewUser(user);
            Navigator.pop(context, "refresh");

          } else {
            updateData(user);
          }
        }
      },
      child: Text('Save'),
    );
  }
}