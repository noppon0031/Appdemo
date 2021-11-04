import 'dart:convert';
import 'dart:ffi';
import 'package:noppon/Business/Comment.dart';
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
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

class Business_Detail extends StatefulWidget {
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
      latitude3,
      longitude3,
      latitude4,
      longitude4,
      latitude5,
      longitude5,
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
      time_open,
      time_close,
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
      photodetail;

  Business_Detail({
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
    this.latitude3,
    this.longitude3,
    this.latitude4,
    this.longitude4,
    this.latitude5,
    this.longitude5,
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
    this.time_open,
    this.time_close,
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
    this.photodetail,
  });

  @override
  _Business_Detail createState() => _Business_Detail();
}

class _Business_Detail extends State<Business_Detail> {
  String _searchText = "";
  String Comment = "ล่าสุด";
  var user_id, user_type;
  String Array = "";
  bool isLiked = false;
  late double rating = 5;
  TextEditingController commentController = new TextEditingController();

  List<Marker> mymarker = [];
  DateTime now = new DateTime.now();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('user_id');
    user_type = prefs.getString('type');

    final snapshot = await FirebaseFirestore.instance
        .collection("like")
        .where('place_id', isEqualTo: widget.place_id)
        .where('user_id', isEqualTo: user_id)
        .get();

    setState(() {
      if (snapshot.docs.length == 0) {
        isLiked = false;
        //Toast.show("UnLike", context,duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      } else {
        isLiked = true;
        //Toast.show("Like", context,duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      }
    });
  }

  LikeMethod(String like) {
    if (like == "like") {
      FirebaseFirestore.instance
          .collection('like')
          .where('place_id', isEqualTo: widget.place_id)
          .where('user_id', isEqualTo: user_id)
          .limit(1)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) async {
          var Like_id = result.data()["like_id"];
          FirebaseFirestore.instance.collection("like").doc(Like_id).delete();
        });
      });
    } else {
      FirebaseFirestore.instance.collection('like').add({
        'place_id': widget.place_id,
        'user_id': user_id,
      }).then((value) => FirebaseFirestore.instance
          .collection('like')
          .doc(value.id)
          .update({'like_id': value.id}));
    }
  }

  int a = 1;
  Updateview() {
    int view = 0;
    FirebaseFirestore.instance
        .collection('place')
        .where('place_id', isEqualTo: widget.place_id)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) async {
        view = result.data()['view'] + 1;
        FirebaseFirestore.instance
            .collection('place')
            .doc(widget.place_id)
            .update({'view': view});
      });
    });
    print(view);
  }

  // ประกาศใช้ GoogleMapController
  late GoogleMapController mapController;
  final Set<Marker> markers = new Set();

  @override
  Widget build(BuildContext context) {
    if (a == 1) {
      Updateview();
      a++;
    }
    var formatter = DateFormat.MMMd('th');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.business_name),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          GetPhotoArray(
            widget.photo1,
            widget.photo2,
            widget.photo3,
            widget.photo4,
            widget.photo5,
            widget.photo6,
            widget.photo7,
            widget.photo8,
            widget.photo9,
            widget.photo10,
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 20, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: (350),
                  child: Text(
                    widget.business_name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Container(
                  child: Text("⭐ : " + widget.rating.toString() + "/5.0",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 22.0)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 110),
                child: IconButton(
                  iconSize: 35,
                  icon: Image.asset('assets/btn_marker.png'),
                  onPressed: () async {
                    if (await canLaunch(widget.map))
                      await launch(widget.map);
                    else
                      throw "Could not launch $widget.google_map";
                  },
                ),
              ),
              Container(
                child: IconButton(
                  iconSize: 35,
                  icon: isLiked == false
                      ? Image.asset('assets/btn_like_gray.png')
                      : Image.asset('assets/btn_like_red.png'),
                  onPressed: () {
                    setState(() {
                      if (isLiked == true) {
                        LikeMethod("like");
                        isLiked = false;
                      } else {
                        LikeMethod("unlike");
                        isLiked = true;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('คำอธิบายรูปภาพ :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Container(
                    width: 250,
                    child: Text(widget.address,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10.0,
          // ),
          // Padding(
          //   padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: <Widget>[
          //       Container(
          //         width: 81,
          //         child: Text('ที่อยู่ :',
          //             style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
          //       ),
          //       Padding(
          //         padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
          //         child: Container(
          //           width: 250,
          //           child: Text(widget.address,
          //               style: TextStyle(color: Colors.black, fontSize: 16.0)),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('English :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Text(widget.business_name_english,
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('ประเภท :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type != 'โปรดระบุหมวดหมู่')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type2 != 'โปรดระบุหมวดหมู่')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type2,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type3 != 'โปรดระบุหมวดหมู่')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type3,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type4 != 'โปรดระบุหมวดหมู่')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type4,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type5 != 'โปรดระบุหมวดหมู่')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type5,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('ประเภทย่อย :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type6 != 'โปรดระบุประเภท')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type6,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type7 != 'โปรดระบุประเภท')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type7,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type8 != 'โปรดระบุประเภท')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type8,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type9 != 'โปรดระบุประเภท')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type9,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                if (widget.type10 != 'โปรดระบุประเภท')
                  Padding(
                    padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                    child: Text(widget.type10,
                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('เบอร์โทร :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Text(widget.tel,
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('เวลา :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Text(widget.time,
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('ราคา :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Text(widget.price,
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('เว็บไซต์ :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: Container(
                    width: (200),
                    child: Text(
                      widget.website,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('Facebook :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Container(
                    width: 250,
                    child: Text(
                      widget.facebook,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('Instagram :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Text(widget.instagram,
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('อีเมล :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Text(widget.email,
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('Line :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Text(widget.line,
                      style: TextStyle(color: Colors.black, fontSize: 16.0)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 81,
                  child: Text('ที่อยู่ :',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 16.0)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(21, 0, 0, 0),
                  child: Container(
                    width: 250,
                    child: Text(
                      widget.address,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          // Container(
          //   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          //   height: 200,
          //   child: GoogleMap(
          //     onMapCreated: _onMapCreated,
          //     initialCameraPosition: CameraPosition(
          //       target: LatLng(
          //           widget.latitude as double, widget.longitude as double),
          //       zoom: 17,
          //     ),
          //     markers: _markers.values.toSet(),
          //   ),
          // ),

          Container(
            height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    widget.latitude as double, widget.longitude as double),
                zoom: 16,
              ),
              mapType: MapType.normal,
              markers: getmarkers(),
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              myLocationEnabled: true,
            ),
          ),

          Divider(color: Colors.black),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text('รายละเอียด',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
            child: Text(
              widget.detail,
              softWrap: true,
            ),
          ),
          Divider(color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text('ความคิดเห็น',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
              ),
              Container(
                margin: EdgeInsets.only(right: 10),
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('แสดงความคิดเห็น'),
                            content: Wrap(children: [
                              new RatingBar(
                                initialRating: rating,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 1.0),
                                onRatingUpdate: (rating1) {
                                  setState(() {
                                    rating = rating1;
                                    print(rating1);
                                  });
                                },
                                ratingWidget: RatingWidget(
                                  full: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  half: Icon(
                                    Icons.star_half,
                                    color: Colors.amber,
                                  ),
                                  empty: Icon(
                                    Icons.star_outline,
                                    color: Colors.amber,
                                  ),
                                ),
                              ),
                              new TextFormField(
                                maxLines: 1,
                                autofocus: false,
                                controller: commentController,
                                decoration: new InputDecoration(
                                  hintText: 'กรุณาใส่ข้อความ',
                                ),
                              ),
                            ]),
                            actions: <Widget>[
                              ElevatedButton(
                                  onPressed: () async {
                                    final snapshot = await FirebaseFirestore
                                        .instance
                                        .collection("comment")
                                        .get();
                                    if (snapshot.docs.length == 0) {
                                      FirebaseFirestore.instance
                                          .collection('comment')
                                          .add({
                                        'array': 1,
                                        'comment_id': "",
                                        'comment': commentController.text,
                                        'place_id': widget.place_id,
                                        'user_id': user_id,
                                        'day':
                                            '${formatter.format(now) + ' ${now.year + 543}'}',
                                        'rating': rating.toInt(),
                                      }).then((value) => FirebaseFirestore
                                              .instance
                                              .collection('comment')
                                              .doc(value.id)
                                              .update(
                                                  {'comment_id': value.id}));
                                    } else {
                                      FirebaseFirestore.instance
                                          .collection('comment')
                                          .orderBy('array', descending: true)
                                          .limit(1)
                                          .get()
                                          .then((querySnapshot) {
                                        querySnapshot.docs
                                            .forEach((result) async {
                                          var array =
                                              result.data()['array'] + 1;

                                          FirebaseFirestore.instance
                                              .collection('comment')
                                              .add({
                                            'array': array,
                                            'comment_id': "",
                                            'comment': commentController.text,
                                            'place_id': widget.place_id,
                                            'user_id': user_id,
                                            'day':
                                                '${formatter.format(now) + ' ${now.year + 543}'}',
                                            'rating': rating.toInt(),
                                          }).then((value) => FirebaseFirestore
                                                      .instance
                                                      .collection('comment')
                                                      .doc(value.id)
                                                      .update({
                                                    'comment_id': value.id
                                                  }));
                                          double total = 0, count = 0;
                                          //หาค่าเฉลี่ย Rating
                                          FirebaseFirestore.instance
                                              .collection('comment')
                                              .where('place_id',
                                                  isEqualTo: widget.place_id)
                                              .get()
                                              .then((querySnapshot) {
                                            querySnapshot.docs
                                                .forEach((result) async {
                                              total = total +
                                                  result.data()['rating'];
                                              count++;

                                              var average = total / count;

                                              FirebaseFirestore.instance
                                                  .collection('place')
                                                  .doc(widget.place_id)
                                                  .update({
                                                'rating': average,
                                                // 'total': total,
                                                // 'count': count,
                                              });
                                            });
                                            // FirebaseFirestore.instance
                                            //     .collection('place')
                                            //     .doc(widget.place_id)
                                            //     .update({
                                            //   'total': total,
                                            //   'count': count,
                                            // });
                                          });
                                        });
                                      });
                                    }

                                    List<int> rating_count = [];

                                    Navigator.of(context).pop();
                                  },
                                  child: Text("ตกลง")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("ยกเลิก")),
                            ],
                          );
                        },
                      );
                    },
                    child: Text("แสดงความคิดเห็น",
                        style: TextStyle(color: Colors.white, fontSize: 14.0))),
              )
            ],
          ),

          // InkWell(
          //   onTap: () {
          //     print("Container was tapped");
          //   },
          //   child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 15),
          //       child: Icon(
          //         Icons.arrow_upward_sharp,
          //       )),
          // ),
          // InkWell(
          //   onTap: () {
          //     print("Container was tapped");
          //   },
          //   child: Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 15),
          //       child: Icon(
          //         Icons.arrow_downward_sharp,
          //       )),
          // ),
          Container(
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      // getFirebasecom1();
                      setState(() {
                        Comment = "ล่าสุด";
                        print("ล่าสุด");
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Comment == "ล่าสุด"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ล่าสุด",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      // getFirebasecom2();
                      setState(() {
                        Comment = "เก่าที่สุด";
                        print("เก่าที่สุด");
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Comment == "เก่าที่สุด"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "เก่าที่สุด",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getFirebasecom1(),
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
                  itemBuilder: (ctx, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return data['place_id'] == widget.place_id
                        ? CommentList(data: data, user_id: user_id)
                        : Visibility(child: Text(""), visible: false);
                  },
                );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getFirebasecom2(),
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
                  itemBuilder: (ctx, index) {
                    DocumentSnapshot data = snapshot.data!.docs[index];
                    return data['place_id'] == widget.place_id
                        ? CommentList(data: data, user_id: user_id)
                        : Visibility(child: Text(""), visible: false);
                  },
                );
            },
          ),
          // StreamBuilder<QuerySnapshot>(
          //   stream: getFirebasecom1(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       print("No Data");
          //       return Center(child: Text(""));
          //     } else
          //       return ListView(
          //         physics: ClampingScrollPhysics(),
          //         shrinkWrap: true,
          //         children: snapshot.data!.docs.map((doc) {
          //           return doc['array'] == Comment || Comment == "ล่าสุด"
          //               ? Column(
          //                   children: <Widget>[
          //                     InkWell(
          //                       onTap: () {
          //                         Navigator.push(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) => CommentList(
          //                                     place_id: doc["place_id"],
          //                                   )),
          //                         );
          //                       },
          //                     ),
          //                   ],
          //                 )
          //               : Visibility(child: Text("data"), visible: false);
          //         }).toList(),
          //       );
          //   },
          // ),
        ],
      ),
    );
  }

  // แสดงตำแหน่งแผนที่
  Set<Marker> getmarkers() {
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(widget.business_name),
        position: LatLng(
          widget.latitude as double,
          widget.longitude as double,
        ),
        infoWindow: InfoWindow(
          title: widget.business_name,
          snippet: widget.address,
        ),
      ));
      if (widget.latitude2 as double > 0.2) {
        markers.add(Marker(
          //add first marker
          markerId: MarkerId(widget.business_name),
          position: LatLng(
            widget.latitude2 as double,
            widget.longitude2 as double,
          ),
          infoWindow: InfoWindow(
            title: widget.business_name,
            snippet: widget.address,
          ),
        ));
      }
      if (widget.latitude2 as double > 0.2) {
        markers.add(Marker(
          //add first marker
          markerId: MarkerId(widget.business_name),
          position: LatLng(
            widget.latitude2 as double,
            widget.longitude2 as double,
          ),
          infoWindow: InfoWindow(
            title: widget.business_name,
            snippet: widget.address,
          ),
        ));
      }
      if (widget.latitude3 as double > 0.2) {
        markers.add(Marker(
          //add first marker
          markerId: MarkerId(widget.business_name),
          position: LatLng(
            widget.latitude3 as double,
            widget.longitude3 as double,
          ),
          infoWindow: InfoWindow(
            title: widget.business_name,
            snippet: widget.address,
          ),
        ));
      }
      if (widget.latitude4 as double > 0.2) {
        markers.add(Marker(
          //add first marker
          markerId: MarkerId(widget.business_name),
          position: LatLng(
            widget.latitude4 as double,
            widget.longitude4 as double,
          ),
          infoWindow: InfoWindow(
            title: widget.business_name,
            snippet: widget.address,
          ),
        ));
      }
      if (widget.latitude5 as double > 0.2) {
        markers.add(Marker(
          //add first marker
          markerId: MarkerId(widget.business_name),
          position: LatLng(
            widget.latitude5 as double,
            widget.longitude5 as double,
          ),
          infoWindow: InfoWindow(
            title: widget.business_name,
            snippet: widget.address,
          ),
        ));
      }
    });
    return markers;
  }

  getFirebasecom1() {
    print(_searchText + "" + Comment);
    // return FirebaseFirestore.instance
    //     .collection('comment')
    //     .orderBy('array', descending: true)
    //     .snapshots();
    if (_searchText == "") {
      if (Comment == "ล่าสุด") {
        return FirebaseFirestore.instance
            .collection('comment')
            .orderBy('array', descending: true)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('comment')
            .where("type", isEqualTo: Comment)
            .snapshots();
      }
    }
  }

  getFirebasecom2() {
    print(_searchText + "" + Comment);
    if (_searchText == "") {
      if (Comment == "เก่าที่สุด") {
        return FirebaseFirestore.instance
            .collection('comment')
            .orderBy('array', descending: false)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('comment')
            .where("type", isEqualTo: Comment)
            .snapshots();
      }
    }
  }

  GetPhotoArray(photo1, photo2, photo3, photo4, photo5, photo6, photo7, photo8,
      photo9, photo10) {
    int check_index = 0;
    List<String> photo_array = [
      photo1,
      photo2,
      photo3,
      photo4,
      photo5,
      photo6,
      photo7,
      photo8,
      photo9,
      photo10
    ];

    return InkWell(
      child: ImageSlideshow(
        width: double.infinity,
        height: 200,
        initialPage: 0,
        indicatorColor: Colors.blue,
        indicatorBackgroundColor: Colors.grey,
        onPageChanged: (value) {
          check_index = value;
        },
        autoPlayInterval: 6000,
        isLoop: true,
        children: [
          if (photo1.isNotEmpty)
            Image.network(
              photo1,
              fit: BoxFit.cover,
            ),
          if (photo2.isNotEmpty)
            Image.network(
              photo2,
              fit: BoxFit.cover,
            ),
          if (photo3.isNotEmpty)
            Image.network(
              photo3,
              fit: BoxFit.cover,
            ),
          if (photo4.isNotEmpty)
            Image.network(
              photo4,
              fit: BoxFit.cover,
            ),
          if (photo5.isNotEmpty)
            Image.network(
              photo5,
              fit: BoxFit.cover,
            ),
          if (photo6.isNotEmpty)
            Image.network(
              photo6,
              fit: BoxFit.cover,
            ),
          if (photo7.isNotEmpty)
            Image.network(
              photo7,
              fit: BoxFit.cover,
            ),
          if (photo8.isNotEmpty)
            Image.network(
              photo8,
              fit: BoxFit.cover,
            ),
          if (photo9.isNotEmpty)
            Image.network(
              photo9,
              fit: BoxFit.cover,
            ),
          if (photo10.isNotEmpty)
            Image.network(
              photo10,
              fit: BoxFit.cover,
            ),
        ],
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FullImage(
                      photo: photo_array[check_index],
                    )));
      },
    );
  }

  // Marker map1Marker = Marker(
  //   markerId: MarkerId('map1'),
  //   position: LatLng(14.040058358657939, 100.73664315034246),
  //   infoWindow: InfoWindow(
  //     title: 'widget.business_name',
  //   ),
  // );
  // Marker map2Marker = Marker(
  //   markerId: MarkerId('map2'),
  //   position: LatLng(14.038452585273768, 100.72885671454596),
  //   infoWindow: InfoWindow(
  //     title: 'widget.business_name',
  //   ),
  // );
  // Marker map3Marker = Marker(
  //   markerId: MarkerId('map3'),
  //   position: LatLng(14.040609132106153, 100.74096874576453),
  //   infoWindow: InfoWindow(
  //     title: 'widget.business_name',
  //   ),
  // );
}

// class CommentList extends StatelessWidget {
//   var data, user_id;
//   CommentList({this.data, this.user_id});

//   Text _buildRatingStars(int rating) {
//     String stars = '';
//     for (int i = 0; i < rating; i++) {
//       stars += '⭐ ';
//     }
//     stars.trim();
//     return Text(stars);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<QuerySnapshot>(
//         future: FirebaseFirestore.instance
//             .collection('user')
//             .where('user_id', isEqualTo: data["user_id"])
//             .get(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Container(
//               height: 200.0,
//               alignment: Alignment.center,
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//               ),
//             );
//           } else {
//             return Column(
//               children: snapshot.data!.docs.map((DocumentSnapshot document) {
//                 return InkWell(
//                     child: Card(
//                         child: Padding(
//                             padding: EdgeInsets.all(10),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text("โดย " + document['username'],
//                                         style: TextStyle(
//                                             color: Colors.blueGrey,
//                                             fontSize: 16.0,
//                                             fontWeight: FontWeight.bold)),
//                                     Text(data['day'],
//                                         style: TextStyle(
//                                             color: Colors.blueGrey,
//                                             fontSize: 16.0)),
//                                   ],
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       _buildRatingStars(data['rating']),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Text(data['comment'],
//                                         style: TextStyle(
//                                             color: Colors.blueGrey,
//                                             fontSize: 16.0))
//                                   ],
//                                 ),
//                               ],
//                             ))),
//                     onTap: () {
//                       if (data["user_id"] == user_id) {
//                         showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return AlertDialog(
//                               title: Row(children: [
//                                 Image.asset(
//                                   'assets/logo.png',
//                                   width: 30,
//                                   height: 30,
//                                   fit: BoxFit.contain,
//                                 ),
//                                 Text('  แจ้งเตือน')
//                               ]),
//                               content:
//                                   Text("คุณต้องลบความคิดเห็นนี้ ใช่หรือไม่?"),
//                               actions: <Widget>[
//                                 // ignore: deprecated_member_use
//                                 FlatButton(
//                                   child: Text(
//                                     "ไม่ใช่",
//                                     style: new TextStyle(color: Colors.blue),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context, rootNavigator: true)
//                                         .pop('dialog');
//                                   },
//                                 ),
//                                 // ignore: deprecated_member_use
//                                 FlatButton(
//                                   child: Text(
//                                     "ใช่",
//                                     style: new TextStyle(color: Colors.blue),
//                                   ),
//                                   onPressed: () async {
//                                     FirebaseFirestore.instance
//                                         .collection('comment')
//                                         .doc(data['comment_id'])
//                                         .delete()
//                                         .then((value) {
//                                       Navigator.of(context, rootNavigator: true)
//                                           .pop('dialog');
//                                     });
//                                     Toast.show("ลบความคิดเห็นสำเร็จ", context,
//                                         duration: Toast.LENGTH_LONG,
//                                         gravity: Toast.BOTTOM);
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       }
//                     });
//               }).toList(),
//             );
//           }
//         });
//   }
// }
