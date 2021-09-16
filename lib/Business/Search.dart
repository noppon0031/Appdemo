import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:noppon/Business/business_detail.dart';
import 'package:noppon/Business/search.dart';
import 'package:noppon/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:noppon/Business/business_list_user.dart';

class SearchFilters extends StatefulWidget {
  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  late bool _IsSearching;
  String _searchText = "";
  String Business_Type = "";

  var user_id,
      email,
      password,
      photo,
      username,
      tel,
      type,
      type2,
      type3,
      type4,
      type5,
      type6,
      type7,
      type8,
      type9,
      type10;

  Widget appBarTitle = Text(
    "ร้านอาหาร",
    style: new TextStyle(color: Colors.white),
  );

  Icon actionIcon = new Icon(
    Icons.search,
    color: Colors.white,
  );

  _Business_List_User() {
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _IsSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _IsSearching = true;
          _searchText = _searchQuery.text;
          print(_searchText);
          //getFirebase();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _IsSearching = false;
    Business_Type = "ทั้งหมด";
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  void _asyncMethod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = prefs.getString('user_id');
      email = prefs.getString('email');
      password = prefs.getString('password');
      photo = prefs.getString('photo');
      username = prefs.getString('username');
      tel = prefs.getString('tel');
      type = prefs.getString('type');
      type2 = prefs.getString('type2');
      type3 = prefs.getString('type3');
      type4 = prefs.getString('type4');
      type5 = prefs.getString('type5');
      type6 = prefs.getString('type6');
      type7 = prefs.getString('type7');
      type8 = prefs.getString('type8');
      type9 = prefs.getString('type9');
      type10 = prefs.getString('type10');
    });
  }

  getFirebase6() {
    print(_searchText + " " + Business_Type);

    if (_searchText == "") {
      if (Business_Type == "ทั้งหมด") {
        return FirebaseFirestore.instance
            .collection('place')
            .where("check", isEqualTo: true)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('place')
            .where("type6", isEqualTo: Business_Type)
            .where("check", isEqualTo: true)
            .snapshots();
      }
      // } else {
      //   return FirebaseFirestore.instance
      //       .collection('place')
      //       .orderBy('business_name')
      //       .startAt([_searchText]).endAt([_searchText + '\uf8ff']).snapshots();

      // .where('type', isEqualTo: Business_Type)
    }
  }

  getFirebase7() {
    print(_searchText + " " + Business_Type);

    if (_searchText == "") {
      if (Business_Type == "ทั้งหมด") {
        return FirebaseFirestore.instance
            .collection('place')
            .where("check", isEqualTo: true)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('place')
            .where("type7", isEqualTo: Business_Type)
            .where("check", isEqualTo: true)
            .snapshots();
      }
      // } else {
      //   return FirebaseFirestore.instance
      //       .collection('place')
      //       .orderBy('business_name')
      //       .startAt([_searchText]).endAt([_searchText + '\uf8ff']).snapshots();

      // .where('type', isEqualTo: Business_Type)
    }
  }

  getFirebase8() {
    print(_searchText + " " + Business_Type);

    if (_searchText == "") {
      if (Business_Type == "ทั้งหมด") {
        return FirebaseFirestore.instance
            .collection('place')
            .where("check", isEqualTo: true)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('place')
            .where("type8", isEqualTo: Business_Type)
            .where("check", isEqualTo: true)
            .snapshots();
      }
      // } else {
      //   return FirebaseFirestore.instance
      //       .collection('place')
      //       .orderBy('business_name')
      //       .startAt([_searchText]).endAt([_searchText + '\uf8ff']).snapshots();

      // .where('type', isEqualTo: Business_Type)
    }
  }

  getFirebase9() {
    print(_searchText + " " + Business_Type);

    if (_searchText == "") {
      if (Business_Type == "ทั้งหมด") {
        return FirebaseFirestore.instance
            .collection('place')
            .where("check", isEqualTo: true)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('place')
            .where("type9", isEqualTo: Business_Type)
            .where("check", isEqualTo: true)
            .snapshots();
      }
      // } else {
      //   return FirebaseFirestore.instance
      //       .collection('place')
      //       .orderBy('business_name')
      //       .startAt([_searchText]).endAt([_searchText + '\uf8ff']).snapshots();

      // .where('type', isEqualTo: Business_Type)
    }
  }

  getFirebase10() {
    print(_searchText + " " + Business_Type);

    if (_searchText == "") {
      if (Business_Type == "ทั้งหมด") {
        return FirebaseFirestore.instance
            .collection('place')
            .where("check", isEqualTo: true)
            .snapshots();
      } else {
        return FirebaseFirestore.instance
            .collection('place')
            .where("type10", isEqualTo: Business_Type)
            .where("check", isEqualTo: true)
            .snapshots();
      }
      // } else {
      //   return FirebaseFirestore.instance
      //       .collection('place')
      //       .orderBy('business_name')
      //       .startAt([_searchText]).endAt([_searchText + '\uf8ff']).snapshots();

      // .where('type', isEqualTo: Business_Type)
    }
  }

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
    return Scaffold(
      appBar: AppBar(
          title: appBarTitle,
          backgroundColor: Colors.red,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    this.actionIcon = new Icon(
                      Icons.close,
                      color: Colors.white,
                    );
                    this.appBarTitle = new TextField(
                      controller: _searchQuery,
                      style: new TextStyle(
                        color: Colors.white,
                      ),
                      decoration: new InputDecoration(
                          prefixIcon:
                              new Icon(Icons.search, color: Colors.white),
                          hintText: "กรุณาใส่คำค้นหา...",
                          hintStyle: new TextStyle(color: Colors.white)),
                    );
                    _handleSearchStart();
                  } else {
                    _handleSearchEnd();
                  }
                });
              },
            ),
            // InkWell(
            //   onTap: () {},
            //   child: Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 15),
            //       child: Icon(
            //         Icons.tune,
            //       )),
            // )
          ]),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "ทั้งหมด";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ทั้งหมด"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ทั้งหมด",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "คาเฟ่";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "คาเฟ่"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "คาเฟ่",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "หมูกระทะ";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "หมูกระทะ"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "หมูกระทะ",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "ตามสั่ง";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ตามสั่ง"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ตามสั่ง",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "จานด่วน";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "จานด่วน"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "จานด่วน",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "เกาหลี";
                        print(Business_Type);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "เกาหลี"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "เกาหลี",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "ญี่ปุ่น";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ญี่ปุ่น"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ญี่ปุ่น",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "ไทย";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "ไทย"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "ไทย",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        Business_Type = "อื่นๆ";
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: Business_Type == "อื่นๆ"
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "อื่นๆ",
                        style: new TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //           builder: (context) => SearchFilters()),
                  //     );
                  //   },
                  //   child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 15),
                  //       child: Icon(
                  //         Icons.tune,
                  //       )),
                  // ) เก็บไว้ก่อนเผื่อใช้
                ],
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getFirebase6(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("No Data");
                return Center(child: Text("ทั้งหมด"));
              } else
                return ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return doc['type6'] == Business_Type
                        ? Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Business_Detail(
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
                                              business_name_english:
                                                  doc["business_name_english"],
                                              day: doc["day"],
                                              detail: doc["detail"],
                                              email: doc["email"],
                                              facebook: doc["facebook"],
                                              instagram: doc["instagram"],
                                              line: doc["line"],
                                              latitude: doc["latitude"],
                                              longitude: doc["longitude"],
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
                                              rating: doc["rating"]
                                                  .toStringAsFixed(1),
                                              tel: doc["tel"],
                                              time: doc["time"],
                                              type: doc["type"],
                                              type2: doc["type2"],
                                              type3: doc["type3"],
                                              type4: doc["type4"],
                                              type5: doc["type5"],
                                              type6: doc["type6"],
                                              type7: doc["type7"],
                                              type8: doc["type8"],
                                              type9: doc["type9"],
                                              type10: doc["type10"],
                                              user_id: doc["user_id"],
                                              website: doc["website"],
                                            )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                            doc["photo1"],
                                            width: double.infinity,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: (330),
                                                margin: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  doc["business_name"],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "⭐ : " +
                                                      doc["rating"]
                                                          .toStringAsFixed(1) +
                                                      "/5.0",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 16.0)),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["day"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["time"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  doc["open"] == "true"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "เปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "ปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 30,
                                                  )
                                                ],
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
                          )
                        : Visibility(child: Text("data"), visible: false);
                  }).toList(),
                );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getFirebase7(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("No Data");
                return Center(child: Text("test"));
              } else
                return ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return doc['type7'] == Business_Type
                        ? Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Business_Detail(
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
                                              business_name_english:
                                                  doc["business_name_english"],
                                              day: doc["day"],
                                              detail: doc["detail"],
                                              email: doc["email"],
                                              facebook: doc["facebook"],
                                              instagram: doc["instagram"],
                                              line: doc["line"],
                                              latitude: doc["latitude"],
                                              longitude: doc["longitude"],
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
                                              rating: doc["rating"]
                                                  .toStringAsFixed(1),
                                              tel: doc["tel"],
                                              time: doc["time"],
                                              type: doc["type"],
                                              type2: doc["type2"],
                                              type3: doc["type3"],
                                              type4: doc["type4"],
                                              type5: doc["type5"],
                                              type6: doc["type6"],
                                              type7: doc["type6"],
                                              type8: doc["type6"],
                                              type9: doc["type6"],
                                              type10: doc["type6"],
                                              user_id: doc["user_id"],
                                              website: doc["website"],
                                            )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                            doc["photo1"],
                                            width: double.infinity,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: (330),
                                                margin: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  doc["business_name"],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "⭐ : " +
                                                      doc["rating"]
                                                          .toStringAsFixed(1) +
                                                      "/5.0",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 16.0)),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["day"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["time"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  doc["open"] == "true"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "เปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "ปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 30,
                                                  )
                                                ],
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
                          )
                        : Visibility(child: Text("data"), visible: false);
                  }).toList(),
                );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getFirebase8(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("No Data");
                return Center(child: Text("test"));
              } else
                return ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return doc['type8'] == Business_Type
                        ? Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Business_Detail(
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
                                              business_name_english:
                                                  doc["business_name_english"],
                                              day: doc["day"],
                                              detail: doc["detail"],
                                              email: doc["email"],
                                              facebook: doc["facebook"],
                                              instagram: doc["instagram"],
                                              line: doc["line"],
                                              latitude: doc["latitude"],
                                              longitude: doc["longitude"],
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
                                              rating: doc["rating"]
                                                  .toStringAsFixed(1),
                                              tel: doc["tel"],
                                              time: doc["time"],
                                              type: doc["type"],
                                              type2: doc["type2"],
                                              type3: doc["type3"],
                                              type4: doc["type4"],
                                              type5: doc["type5"],
                                              type6: doc["type6"],
                                              type7: doc["type7"],
                                              type8: doc["type8"],
                                              type9: doc["type9"],
                                              type10: doc["type10"],
                                              user_id: doc["user_id"],
                                              website: doc["website"],
                                            )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                            doc["photo1"],
                                            width: double.infinity,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: (330),
                                                margin: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  doc["business_name"],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "⭐ : " +
                                                      doc["rating"]
                                                          .toStringAsFixed(1) +
                                                      "/5.0",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 16.0)),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["day"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["time"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  doc["open"] == "true"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "เปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "ปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 30,
                                                  )
                                                ],
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
                          )
                        : Visibility(child: Text("data"), visible: false);
                  }).toList(),
                );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getFirebase9(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("No Data");
                return Center(child: Text("test"));
              } else
                return ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return doc['type9'] == Business_Type
                        ? Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Business_Detail(
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
                                              business_name_english:
                                                  doc["business_name_english"],
                                              day: doc["day"],
                                              detail: doc["detail"],
                                              email: doc["email"],
                                              facebook: doc["facebook"],
                                              instagram: doc["instagram"],
                                              line: doc["line"],
                                              latitude: doc["latitude"],
                                              longitude: doc["longitude"],
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
                                              rating: doc["rating"]
                                                  .toStringAsFixed(1),
                                              tel: doc["tel"],
                                              time: doc["time"],
                                              type: doc["type"],
                                              type2: doc["type2"],
                                              type3: doc["type3"],
                                              type4: doc["type4"],
                                              type5: doc["type5"],
                                              type6: doc["type6"],
                                              type7: doc["type7"],
                                              type8: doc["type8"],
                                              type9: doc["type9"],
                                              type10: doc["type10"],
                                              user_id: doc["user_id"],
                                              website: doc["website"],
                                            )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                            doc["photo1"],
                                            width: double.infinity,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: (330),
                                                margin: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  doc["business_name"],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "⭐ : " +
                                                      doc["rating"]
                                                          .toStringAsFixed(1) +
                                                      "/5.0",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 16.0)),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["day"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["time"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  doc["open"] == "true"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "เปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "ปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 30,
                                                  )
                                                ],
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
                          )
                        : Visibility(child: Text("data"), visible: false);
                  }).toList(),
                );
            },
          ),
          StreamBuilder<QuerySnapshot>(
            stream: getFirebase10(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                print("No Data");
                return Center(child: Text("test"));
              } else
                return ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: snapshot.data!.docs.map((doc) {
                    return doc['type10'] == Business_Type
                        ? Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Business_Detail(
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
                                              business_name_english:
                                                  doc["business_name_english"],
                                              day: doc["day"],
                                              detail: doc["detail"],
                                              email: doc["email"],
                                              facebook: doc["facebook"],
                                              instagram: doc["instagram"],
                                              line: doc["line"],
                                              latitude: doc["latitude"],
                                              longitude: doc["longitude"],
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
                                              rating: doc["rating"]
                                                  .toStringAsFixed(1),
                                              tel: doc["tel"],
                                              time: doc["time"],
                                              type: doc["type"],
                                              type2: doc["type2"],
                                              type3: doc["type3"],
                                              type4: doc["type4"],
                                              type5: doc["type5"],
                                              type6: doc["type6"],
                                              type7: doc["type7"],
                                              type8: doc["type8"],
                                              type9: doc["type9"],
                                              type10: doc["type10"],
                                              user_id: doc["user_id"],
                                              website: doc["website"],
                                            )),
                                  );
                                },
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                  ),
                                  child: Card(
                                    child: Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Image.network(
                                            doc["photo1"],
                                            width: double.infinity,
                                            height: 180,
                                            fit: BoxFit.cover,
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: (330),
                                                margin: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  doc["business_name"],
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  "⭐ : " +
                                                      doc["rating"]
                                                          .toStringAsFixed(1) +
                                                      "/5.0",
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 16.0)),
                                              Row(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["day"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.all(6.0),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context)
                                                          .accentColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      doc["time"],
                                                      style: new TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: (10),
                                                  ),
                                                  doc["open"] == "true"
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "เปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        )
                                                      : Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  6.0),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "ปิด",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                  SizedBox(
                                                    width: 30,
                                                  )
                                                ],
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
                          )
                        : Visibility(child: Text("data"), visible: false);
                  }).toList(),
                );
            },
          ),
        ],
      ),
    );
  }

  void _handleSearchStart() {
    setState(() {
      _IsSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      Business_Type = "ทั้งหมด";

      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        "สถานที่ทั้งหมด",
        style: new TextStyle(color: Colors.white),
      );
      _IsSearching = false;
      _searchText = "";
      print(_searchText);
      _searchQuery.clear();
    });
  }

  void LogoutMethod(BuildContext context) {
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
          content: Text("คุณต้องการออกจากระบบ ใช่หรือไม่?"),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                "ไม่ใช่",
                style: new TextStyle(color: Colors.blue),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop('dialog');
              },
            ),
            // ignore: deprecated_member_use
            FlatButton(
              child: Text(
                "ใช่",
                style: new TextStyle(color: Colors.blue),
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
