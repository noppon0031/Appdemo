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

class CommentList extends StatefulWidget {
  var place_id,
      address,
      business_name,
      business_name1,
      business_name2,
      business_name3,
      business_name_english,
      day,
      detail,
      email,
      facebook,
      instagram,
      line,
      latitude,
      longitude,
      latitude2,
      longitude2,
      map,
      photo1,
      photo2,
      photo3,
      photo4,
      photo5,
      photo6,
      photo7,
      photo8,
      photo9,
      photo10,
      price,
      rating,
      tel,
      time,
      type,
      type2,
      type3,
      type4,
      type5,
      type6,
      type7,
      type8,
      type9,
      type10,
      user_id,
      website,
      data,
      photodetail;

  CommentList({
    this.place_id,
    this.address,
    this.business_name,
    this.business_name1,
    this.business_name2,
    this.business_name3,
    this.business_name_english,
    this.day,
    this.detail,
    this.email,
    this.facebook,
    this.instagram,
    this.line,
    this.latitude,
    this.longitude,
    this.latitude2,
    this.longitude2,
    this.map,
    this.photo1,
    this.photo2,
    this.photo3,
    this.photo4,
    this.photo5,
    this.photo6,
    this.photo7,
    this.photo8,
    this.photo9,
    this.photo10,
    this.price,
    this.rating,
    this.tel,
    this.time,
    this.type,
    this.type2,
    this.type3,
    this.type4,
    this.type5,
    this.type6,
    this.type7,
    this.type8,
    this.type9,
    this.type10,
    this.user_id,
    this.website,
    this.data,
    this.photodetail,
  });

  @override
  _CommentList createState() => _CommentList();
}

class _CommentList extends State<CommentList> {
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
            .where('user_id', isEqualTo: widget.data["user_id"])
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
                                    Text(widget.data['day'],
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
                                      _buildRatingStars(widget.data['rating']),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(widget.data['comment'],
                                        style: TextStyle(
                                            color: Colors.blueGrey,
                                            fontSize: 16.0))
                                  ],
                                ),
                              ],
                            ))),
                    onTap: () {
                      if (widget.data["user_id"] == widget.user_id) {
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
                                        .doc(widget.data['comment_id'])
                                        .delete()
                                        .then((value) {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    });

                                    //หาค่าเฉลี่ย Rating
                                    double total = 0, count = 0;
                                    FirebaseFirestore.instance
                                        .collection('comment')
                                        .where('place_id',
                                            isEqualTo: widget.data["place_id"])
                                        .get()
                                        .then((querySnapshot) {
                                      querySnapshot.docs
                                          .forEach((result) async {
                                        total = total + result.data()['rating'];
                                        count++;

                                        var average = total / count;

                                        FirebaseFirestore.instance
                                            .collection('place')
                                            .doc(widget.data["place_id"])
                                            .update({
                                          'rating': average,
                                        });
                                      });
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
