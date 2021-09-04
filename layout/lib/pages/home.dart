import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HompPage extends StatefulWidget {
  // const HompPage({ Key? key }) : super(key: key);

  @override
  _HompPageState createState() => _HompPageState();
}

class _HompPageState extends State<HompPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ความรู้เกี่ยวกับปัญญาประดิษฐ์"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              // var data = json.decode(snapshot.data.toString());
              return ListView.builder(
                itemBuilder: (BuildContext contextm, int index) {
                  return Column(
                    children: [
                      MyBox(
                          //ใส่ snapshot.data แทน data เพื่อดึงข้อมูล
                          snapshot.data[index]['title'],
                          snapshot.data[index]['subtitle'],
                          snapshot.data[index]['image_url'],
                          snapshot.data[index]['detail']),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  );
                },
                itemCount: snapshot.data.length,
              );
            },
            future: getData(),
            // future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          )),
    );
  }

  Widget MyBox(String title, String subtitle, String img_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = img_url;
    v4 = detail;
    return Container(
      padding: EdgeInsets.all(10),
      // color: Colors.blue[50],
      height: 150,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
            image: NetworkImage(img_url),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.50), BlendMode.darken)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.75),
            offset: Offset(3, 3),
            blurRadius: 3,
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 17),
          TextButton(
              onPressed: () {
                print("Next Page >>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(v1, v2, v3, v4)));
              },
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "อ่านต่อ>>>",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ))
        ],
      ),
    );
  }

  Future getData() async {
    // function getData
    // https://raw.githubusercontent.com/chinapat/InfoAPI/main/data.json
    var url = Uri.https(
        'raw.githubusercontent.com', '/chinapat/InfoAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
