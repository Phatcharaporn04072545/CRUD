// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    int? id;
    String? name;
    String? list;
    String? quantity;
    String? date;

    Product({
        this.id,
        this.name,
        this.list,
        this.quantity,
        this.date,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["Name"],
        list: json["List"],
        quantity: json["Quantity"],
        date: json["Date"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "Name": name,
        "List": list,
        "Quantity": quantity,
        "Date": date,
    };
}
