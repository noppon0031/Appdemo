import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:noppon/Business/add_image.dart';
import 'dart:ui';
import 'dart:async';
import 'package:noppon/Business/business_detail.dart';
import 'package:noppon/Model/place.dart';
import 'package:noppon/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:noppon/Business/business_edit.dart';

class Business_Me extends StatefulWidget {
  @override
  _Business_Me createState() => _Business_Me();
}

class _Business_Me extends State<Business_Me> {
  var user_id,
      place_id,
      business_name,
      photo,
      price,
      address,
      rating,
      day,
      time;

  List<Place> place_data = [];
  var email, password, username, tel, type;

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      //place_id = "";
      user_id = prefs.getString('user_id');
      email = prefs.getString('email');
      password = prefs.getString('password');
      photo = prefs.getString('photo');
      username = prefs.getString('username');
      tel = prefs.getString('tel');
      type = prefs.getString('type');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('สถานที่ของฉัน'),
        backgroundColor: Colors.red,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('place')
            .where("user_id", isEqualTo: user_id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else
            return ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                List<DocumentSnapshot> produdcts = snapshot.data!.docs;
                DocumentSnapshot doc = snapshot.data!.docs[index];
                //var data = getPlace(doc["place_id"], index);

                return PlaceList(doc: doc);
              },
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddImage())),
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class PlaceList extends StatelessWidget {
  var doc;
  PlaceList({this.doc});

  Widget build(BuildContext context) {
    print(doc["place_id"]);
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('place')
            .where('place_id', isEqualTo: doc["place_id"])
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 200.0,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          } else {
            return Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                return Stack(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Business_Detail(
                                    place_id: document["place_id"],
                                    address: document["address"],
                                    business_name: document["business_name"],
                                    business_name1: document["business_name1"],
                                    business_name2: document["business_name2"],
                                    business_name3: document["business_name3"],
                                    business_name_english:
                                        document["business_name_english"],
                                    day: document["day"],
                                    detail: document["detail"],
                                    email: document["email"],
                                    facebook: document["facebook"],
                                    instagram: document["instagram"],
                                    line: document["line"],
                                    latitude: document["latitude"],
                                    longitude: document["longitude"],
                                    map: document["map"],
                                    photo1: document["photo1"],
                                    photo2: document["photo2"],
                                    photo3: document["photo3"],
                                    photo4: document["photo4"],
                                    photo5: document["photo5"],
                                    photo6: document["photo6"],
                                    photo7: document["photo7"],
                                    photo8: document["photo8"],
                                    photo9: document["photo9"],
                                    photo10: document["photo10"],
                                    price: document["price"],
                                    rating: document["rating"],
                                    tel: document["tel"],
                                    time: document["time"],
                                    type: document["type"],
                                    user_id: document["user_id"],
                                    website: document["website"],
                                  )),
                        );
                      },
                      onLongPress: () {
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                title: Row(children: [
                                  Image.asset(
                                    'assets/logo.png',
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.contain,
                                  ),
                                  Text('  กรุณาเลือกคำสั่ง')
                                ]),
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () {
                                      doc['open'] == 'true'
                                          ? FirebaseFirestore.instance
                                              .collection('place')
                                              .doc(doc["place_id"])
                                              .update({'open': 'false'}).then(
                                                  (value) {
                                              Navigator.of(context,
                                                      rootNavigator: true)
                                                  .pop('dialog');

                                              Toast.show("ปิดสำเร็จ", context,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.BOTTOM);
                                            })
                                          : FirebaseFirestore.instance
                                              .collection('place')
                                              .doc(doc["place_id"])
                                              .update({'open': 'true'}).then(
                                                  (value) => Navigator.of(
                                                          context,
                                                          rootNavigator: true)
                                                      .pop('dialog'));
                                      Toast.show("เปิดสำเร็จ", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM);
                                    },
                                    child: const Text('เปิด/ปิดร้าน'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BusinessEdit(
                                                  place_id: doc["place_id"],
                                                  address: doc["address"],
                                                  business_name:
                                                      doc["business_name"],
                                                  business_name1:
                                                      doc["business_name1"],
                                                  business_name2:
                                                      doc["business_name2"],
                                                  business_name3:
                                                      doc["business_name3"],
                                                  business_name_english: doc[
                                                      "business_name_english"],
                                                  day: doc["day"],
                                                  detail: doc["detail"],
                                                  email: doc["email"],
                                                  facebook: doc["facebook"],
                                                  instagram: doc["instagram"],
                                                  line: doc["line"],
                                                  latitude: doc["latitude"]
                                                      .toString(),
                                                  longitude: doc["longitude"]
                                                      .toString(),
                                                  map: doc["map"],
                                                  photo1: doc["photo1"],
                                                  photo2: doc["photo2"],
                                                  photo3: doc["photo3"],
                                                  photo4: doc["photo4"],
                                                  photo5: doc["photo5"],
                                                  photo6: doc["photo6"],
                                                  photo7: doc["photo7"],
                                                  photo8: doc["photo8"],
                                                  photo9: doc["photo9"],
                                                  photo10: doc["photo10"],
                                                  price: doc["price"],
                                                  // rating: doc["rating"],
                                                  tel: doc["tel"],
                                                  time: doc["time"],
                                                  type: doc["type"],
                                                  user_id: doc["user_id"],
                                                  website: doc["website"],
                                                )),
                                      );
                                    },
                                    child: const Text('แก้ไขสถานที่'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('place')
                                          .doc(doc["place_id"])
                                          .delete()
                                          .then((value) {
                                        FirebaseFirestore.instance
                                            .collection('comment')
                                            .doc(doc["place_id"])
                                            .delete();

                                        FirebaseFirestore.instance
                                            .collection('like')
                                            .doc(doc["place_id"])
                                            .delete();
                                      });

                                      List<String> photo_array = [
                                        doc["photo1"],
                                        doc["photo2"],
                                        doc["photo3"],
                                        doc["photo4"],
                                        doc["photo5"],
                                        doc["photo6"],
                                        doc["photo7"],
                                        doc["photo8"],
                                        doc["photo9"],
                                        doc["photo10"]
                                      ];

                                      for (int i = 0;
                                          i < photo_array.length;
                                          i++) {
                                        if (photo_array[i].isNotEmpty) {
                                          FirebaseStorage.instance
                                              .refFromURL(photo_array[i])
                                              .delete();
                                        }
                                      }

                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                      Toast.show("ลบสำเร็จ", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM);
                                    },
                                    child: const Text('ลบสถานที่'),
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  document['photo1'],
                                  width: double.infinity,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                        document["business_name"],
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Column(
                                        children: <Widget>[
                                          // Text(
                                          //   'per pax',
                                          //   style: TextStyle(
                                          //     color: Colors.grey,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  child: Text(
                                    document["address"],
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Row(
                                  children: [
                                    Text(
                                        "⭐ : " +
                                            document["rating"]
                                                .toStringAsFixed(1) +
                                            "/5.0",
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0)),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        document["day"],
                                        style: new TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                    Container(
                                      padding: EdgeInsets.all(6.0),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).accentColor,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        document["time"],
                                        style: new TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                    SizedBox(width: 5.0),
                                    document["open"] == "true"
                                        ? Container(
                                            padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "เปิด",
                                              style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          )
                                        : Container(
                                            padding: EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "ปิด",
                                              style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          }
        });
  }
}