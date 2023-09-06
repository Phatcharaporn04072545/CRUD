import 'package:flutter/material.dart';
import 'package:flutter_application_20/models/products.dart';
import 'package:http/http.dart' as http;

class Order extends StatefulWidget {
  static const routeName = '/order';

  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late List<Product> products;
  int itemCount = 1; // กำหนดค่าเริ่มต้นของ itemCount

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url = Uri.http('10.116.0.138:3000', 'products');
    var response = await http.get(url);

    setState(() {
      products = productFromJson(response.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการสั่งซื้อ'),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Widgets สำหรับการป้อนข้อมูล
              TextFormField(
                decoration: InputDecoration(labelText: 'ชื่อผู้สั่ง'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'รายการสินค้า'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'จำนวน'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'วันที่สั่งซื้อ'),
              ),

              SizedBox(
                height: 10.0,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // ตอบสนองเมื่อคลิกปุ่มส่ง
                    },
                    child: Text('ส่ง'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // ตอบสนองเมื่อคลิกปุ่มย้อนกลับ
                    },
                    child: Text('ย้อนกลับ'),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  // ลิงก์ไปยังหน้าที่เกี่ยวข้อง (หากมี)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
