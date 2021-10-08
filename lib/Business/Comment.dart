import 'dart:convert';
import 'dart:ffi';
import 'package:noppon/Business/search.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:noppon/Model/user.dart';
import 'package:noppon/full_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class CommentList extends StatelessWidget {
  var data, user_id, place_id;
  CommentList({this.data, this.user_id, this.place_id});

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('user')
            .where('user_id', isEqualTo: data["user_id"])
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
                return InkWell(
                    child: Card(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("โดย " + document['username'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    Text(data['day'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0)),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      _buildRatingStars(data['rating']),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(data['comment'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0))
                                  ],
                                ),
                              ],
                            ))),
                    onTap: () {
                      if (data["user_id"] == user_id) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Row(children: [
                                Image.asset(
                                  'assets/logo.png',
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                                Text('  แจ้งเตือน')
                              ]),
                              content:
                                  Text("คุณต้องลบความคิดเห็นนี้ ใช่หรือไม่?"),
                              actions: <Widget>[
                                // ignore: deprecated_member_use
                                FlatButton(
                                  child: Text(
                                    "ไม่ใช่",
                                    style: new TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop('dialog');
                                  },
                                ),
                                // ignore: deprecated_member_use
                                FlatButton(
                                  child: Text(
                                    "ใช่",
                                    style: new TextStyle(color: Colors.blue),
                                  ),
                                  onPressed: () async {
                                    FirebaseFirestore.instance
                                        .collection('comment')
                                        .doc(data['comment_id'])
                                        .delete()
                                        .then((value) {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    });
                                    Toast.show("ลบความคิดเห็นสำเร็จ", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    });
              }).toList(),
            );
          }
        });
  }
}
