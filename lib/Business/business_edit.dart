import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:noppon/Entrepreneur/launcher.dart';
import 'package:noppon/Model/place.dart';
import 'package:path/path.dart' as Path;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../full_image.dart';

class BusinessEdit extends StatefulWidget {
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
      photodetail;

  BusinessEdit({
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
    this.photodetail,
  });
  @override
  _BusinessEdit createState() => _BusinessEdit();
}

class _BusinessEdit extends State<BusinessEdit> {
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  TextEditingController business_name_Controller = TextEditingController();
  TextEditingController business_name1_Controller = TextEditingController();
  TextEditingController business_name2_Controller = TextEditingController();
  TextEditingController business_name3_Controller = TextEditingController();
  TextEditingController business_name_english_Controller =
      TextEditingController();
  TextEditingController tel_Controller = TextEditingController();
  TextEditingController day_Controller = TextEditingController();
  TextEditingController time_Controller = TextEditingController();
  TextEditingController price_Controller = TextEditingController();
  TextEditingController website_Controller = TextEditingController();
  TextEditingController facebook_Controller = TextEditingController();
  TextEditingController instagram_Controller = TextEditingController();
  TextEditingController line_Controller = TextEditingController();
  TextEditingController email_Controller = TextEditingController();
  TextEditingController address_Controller = TextEditingController();
  TextEditingController detail_Controller = TextEditingController();
  TextEditingController google_map_Controller = TextEditingController();
  TextEditingController latitude_Controller = TextEditingController();
  TextEditingController longitude_Controller = TextEditingController();
  TextEditingController latitude2_Controller = TextEditingController();
  TextEditingController longitude2_Controller = TextEditingController();
  TextEditingController photodetail_Controller = TextEditingController();
  TextEditingController type_Controller = TextEditingController();
  TextEditingController type2_Controller = TextEditingController();
  TextEditingController type3_Controller = TextEditingController();
  TextEditingController type4_Controller = TextEditingController();
  TextEditingController type5_Controller = TextEditingController();
  TextEditingController type6_Controller = TextEditingController();
  TextEditingController type7_Controller = TextEditingController();
  TextEditingController type8_Controller = TextEditingController();
  TextEditingController type9_Controller = TextEditingController();
  TextEditingController type10_Controller = TextEditingController();
  TextEditingController check_Controller = TextEditingController();
  List<File> _image = [];
  List<String> url_image = [];
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('place');
    business_name_Controller.text = widget.business_name;
    business_name1_Controller.text = widget.business_name1;
    business_name2_Controller.text = widget.business_name2;
    business_name3_Controller.text = widget.business_name3;
    business_name_english_Controller.text = widget.business_name_english;
    tel_Controller.text = widget.tel;
    day_Controller.text = widget.day;
    time_Controller.text = widget.time;
    price_Controller.text = widget.price;
    website_Controller.text = widget.website;
    facebook_Controller.text = widget.facebook;
    instagram_Controller.text = widget.instagram;
    line_Controller.text = widget.line;
    email_Controller.text = widget.email;
    address_Controller.text = widget.address;
    detail_Controller.text = widget.detail;
    google_map_Controller.text = widget.map;
    latitude_Controller.text = widget.latitude;
    longitude_Controller.text = widget.longitude;
    photodetail_Controller.text = widget.photodetail;
    type_Controller.text = widget.type;
    type2_Controller.text = widget.type2;
    type3_Controller.text = widget.type3;
    type4_Controller.text = widget.type4;
    type5_Controller.text = widget.type5;
    type6_Controller.text = widget.type6;
    type7_Controller.text = widget.type7;
    type8_Controller.text = widget.type8;
    type9_Controller.text = widget.type9;
    type10_Controller.text = widget.type10;
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
    if (photo10.isNotEmpty) {
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
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo7,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo8,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo9,
                fit: BoxFit.cover,
              ),
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
                  ),
                ));
          });
    } else if (photo9.isNotEmpty) {
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
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo7,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo8,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo9,
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
                  ),
                ));
          });
    } else if (photo8.isNotEmpty) {
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
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo7,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo8,
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
                  ),
                ));
          });
    } else if (photo7.isNotEmpty) {
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
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo7,
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
                  ),
                ));
          });
    } else if (photo6.isNotEmpty) {
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
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo6,
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
                  ),
                ));
          });
    } else if (photo5.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo5,
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
                  ),
                ));
          });
    } else if (photo4.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo4,
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
                  ),
                ));
          });
    } else if (photo3.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo3,
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
                  ),
                ));
          });
    } else if (photo2.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
                fit: BoxFit.cover,
              ),
              Image.network(
                photo2,
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
                  ),
                ));
          });
    } else if (photo1.isNotEmpty) {
      return InkWell(
          child: ImageSlideshow(
            width: double.infinity,
            height: 200,
            indicatorColor: Colors.blue,
            indicatorBackgroundColor: Colors.grey,
            onPageChanged: (value) {
              check_index = value;
            },
            autoPlayInterval: 6000,
            isLoop: true,
            children: [
              Image.network(
                photo1,
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
                  ),
                ));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขสถานที่'),
      ),
      body: ListView(
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
              widget.photo10),
          Stack(alignment: Alignment.center, children: [
            GridView.builder(
                shrinkWrap: true,
                itemCount: _image.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: FileImage(_image[index]),
                            fit: BoxFit.cover)),
                  );
                }),
            (_image.length == 0
                ? Text("หากคุณต้องการเลือกรูปภาพของคุณใหม่ แตะปุ่มเลือกรูป")
                : Visibility(child: Text(""), visible: true)),
            uploading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Container(
                      //   child: Text(
                      //     'uploading...',
                      //     style: TextStyle(fontSize: 20),
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      CircularProgressIndicator(
                        value: val,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      )
                    ],
                  ))
                : Container(),
          ]),
          Container(
            height: 40,
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(8),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text(
                  'เลือกรูป',
                  style: new TextStyle(fontSize: 16.0),
                ),
                onPressed: () => !uploading ? chooseImage() : null),
          ),
          // IconButton(
          //     icon: Icon(Icons.add),
          //
          //     onPressed: () => !uploading ? chooseImage() : null),
          Container(
              margin: EdgeInsets.all(10),
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    "คำอธิบายรูปภาพ",
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: photodetail_Controller,
                    decoration: new InputDecoration(
                      hintText: 'กรุณาใส่ชื่อ',
                    ),
                  ),
                  Text(
                    "ชื่อ",
                    style: new TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name_Controller,
                    decoration: new InputDecoration(
                      hintText: 'กรุณาใส่ชื่อ',
                    ),
                  ),
                  Text(
                    "ชื่อแฝง 1 (Alias Name)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name1_Controller,
                    decoration: new InputDecoration(
                      hintText: 'กรุณาใส่ชื่อแฝง 1',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ชื่อแฝง 2 (Alias Name)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name2_Controller,
                    decoration: new InputDecoration(
                      hintText: 'กรุณาใส่ชื่อแฝง 2',
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ชื่อแฝง 3 (Alias Name)",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name3_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ชื่อแฝง 3'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "English",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: business_name_english_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ English'),
                  ),
                  SizedBox(height: 40.0),
                  Text(
                    "หมวดหมู่",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 10.0),
                  // Text(
                  //   "ร้านอาหาร,ร้านกาแฟ,ร้านเครื่องเขียน,ร้านเสริมสวย,คลินิก/ขายยา,ร้านทั่วไป,สถานที่ใน Rmutt,สถานที่ทั่วไป",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),

                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'ใส่หมวดหมู่สถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Text(
                  //   "เลือกข้างล่างหากคุณต้องการเปลี่ยน",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue = data!;
                  //       });
                  //     },
                  //     items: business_type
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type2_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'ใส่หมวดหมู่สถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue2,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue2 = data!;
                  //       });
                  //     },
                  //     items: business_type2
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type3_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'ใส่หมวดหมู่สถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue3,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue3 = data!;
                  //       });
                  //     },
                  //     items: business_type3
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type4_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'ใส่หมวดหมู่สถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue4,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue4 = data!;
                  //       });
                  //     },
                  //     items: business_type4
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type5_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'ใส่หมวดหมู่สถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue5,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue5 = data!;
                  //       });
                  //     },
                  //     items: business_type5
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),

                  SizedBox(height: 10.0),
                  Text(
                    "ประเภท",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type6_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'ใส่ประเภทสถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue6,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue6 = data!;
                  //       });
                  //     },
                  //     items: business_type6
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type7_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'ใส่ประเภทสถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue7,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue7 = data!;
                  //       });
                  //     },
                  //     items: business_type7
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type8_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'ใส่ประเภทสถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue8,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue8 = data!;
                  //       });
                  //     },
                  //     items: business_type8
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type9_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'ใส่ประเภทสถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue9,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue9 = data!;
                  //       });
                  //     },
                  //     items: business_type9
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: type10_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'ใส่ประเภทสถานที่ของคุณ'),
                    style: new TextStyle(fontSize: 13.0),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 10),
                  //   child: DropdownButton<String>(
                  //     value: dropdownValue10,
                  //     icon: Icon(Icons.arrow_drop_down),
                  //     iconSize: 24,
                  //     elevation: 16,
                  //     style: TextStyle(color: Colors.black, fontSize: 18),
                  //     underline: Container(
                  //       height: 2,
                  //     ),
                  //     onChanged: (data) {
                  //       setState(() {
                  //         dropdownValue10 = data!;
                  //       });
                  //     },
                  //     items: business_type10
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Text(value, textAlign: TextAlign.center),
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                  SizedBox(height: 40.0),
                  Text(
                    "เบอร์โทร",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: tel_Controller,
                    keyboardType: TextInputType.number,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่เบอร์โทร'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "วันที่เปิดทำการ",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: day_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่วันที่เปิด'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "เวลาเปิด-ปิด",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: time_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่เวลาเปิดปิด'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ช่วงราคา",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: price_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ช่วงราคา'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "เว็บไซต์",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: website_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่เว็บไซต์'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Facebook",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: facebook_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ Facebook'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Instagram",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: instagram_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ Instagram'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "อีเมล",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: email_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(hintText: 'กรุณาใส่อีเมล'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "Line",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: line_Controller,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(hintText: 'กรุณาใส่ Line'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ที่อยู่",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: address_Controller,
                    keyboardType: TextInputType.text,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ที่อยู่'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "ละติจูด, ลองจิจูด",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: latitude_Controller,
                    keyboardType: TextInputType.number,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ละติจูด'),
                  ),

                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: longitude_Controller,
                    keyboardType: TextInputType.number,
                    decoration:
                        new InputDecoration(hintText: 'กรุณาใส่ลองจิจูด'),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    "รายละเอียดร้าน",
                    style: new TextStyle(fontSize: 16.0),
                  ),
                  TextFormField(
                    maxLines: 1,
                    autofocus: false,
                    controller: detail_Controller,
                    keyboardType: TextInputType.text,
                  ),
                  // SizedBox(height: 10.0),
                  // Text(
                  //   "ตำแหน่งสถานที่",
                  //   style: new TextStyle(fontSize: 16.0),
                  // ),
                  // TextFormField(
                  //   maxLines: 1,
                  //   autofocus: false,
                  //   controller: google_map_Controller,
                  //   keyboardType: TextInputType.text,
                  //   decoration: new InputDecoration(
                  //       hintText: 'เช่น www.google.co.th/maps/place/asdfad'),
                  // ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.all(8),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                      child: Text(
                        'แก้ไขสถานที่',
                        style: new TextStyle(fontSize: 20.0),
                      ),
                      onPressed: () {
                        uploadFile(context);
                      }),
                ],
              )),
        ],
      ),
    );
  }

  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (_image.length == 10) {
        Toast.show("เพิ่มรูปได้ 10 รูปเท่านั้น", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        return;
      } else {
        _image.add(File(pickedFile!.path));
      }
    });
    if (pickedFile!.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  Future<void> uploadFile(BuildContext context) async {
    var business_name = business_name_Controller.text.toString();
    var business_name1 = business_name1_Controller.text.toString();
    var business_name2 = business_name2_Controller.text.toString();
    var business_name3 = business_name3_Controller.text.toString();
    var business_name_english =
        business_name_english_Controller.text.toString();
    var day = day_Controller.text.toString();
    var detail = detail_Controller.text.toString();
    var email = email_Controller.text.toString();
    var facebook = facebook_Controller.text.toString();
    var instagram = instagram_Controller.text.toString();
    var line = line_Controller.text.toString();
    var latitude = latitude_Controller.text.toString();
    var longitude = longitude_Controller.text.toString();
    var price = price_Controller.text.toString();
    var tel = tel_Controller.text.toString();
    var time = time_Controller.text.toString();
    var type = type_Controller.text.toString();
    var type2 = type2_Controller.text.toString();
    var type3 = type3_Controller.text.toString();
    var type4 = type4_Controller.text.toString();
    var type5 = type5_Controller.text.toString();
    var type6 = type6_Controller.text.toString();
    var type7 = type7_Controller.text.toString();
    var type8 = type8_Controller.text.toString();
    var type9 = type9_Controller.text.toString();
    var type10 = type10_Controller.text.toString();
    var website = website_Controller.text.toString();
    var photodetail = photodetail_Controller.text.toString();

    FirebaseFirestore.instance.collection('place').doc(widget.place_id).update({
      'business_name': business_name,
      'business_name1': business_name1,
      'business_name2': business_name2,
      'business_name3': business_name3,
      'business_name_english': business_name_english,
      'day': day,
      'detail': detail,
      'email': email,
      'facebook': facebook,
      'price': price,
      'instagram': instagram,
      'line': line,
      'latitude': double.parse('$latitude'),
      'longitude': double.parse('$longitude'),
      'tel': tel,
      'time': time,
      'type': type,
      'type2': type2,
      'type3': type3,
      'type4': type4,
      'type5': type5,
      'type6': type6,
      'type7': type7,
      'type8': type8,
      'type9': type9,
      'type10': type10,
      'website': website,
      'photodetail': photodetail,
      'check': false,
    }).then((value) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('business_name', business_name);
      await prefs.setString('business_name1', business_name1);
      await prefs.setString('business_name2', business_name2);
      await prefs.setString('business_name3', business_name3);
      await prefs.setString('business_name_english', business_name_english);
      await prefs.setString('day', day);
      await prefs.setString('detail', detail);
      await prefs.setString('email', email);
      await prefs.setString('facebook', facebook);
      await prefs.setString('price', price);
      await prefs.setString('instagram', instagram);
      await prefs.setString('line', line);
      await prefs.setString('latitude', latitude);
      await prefs.setString('longitude', longitude);
      await prefs.setString('tel', tel);
      await prefs.setString('time', time);
      await prefs.setString('website', website);
      await prefs.setString('photodetail', photodetail);
      await prefs.setString('type', type);
      await prefs.setString('type2', type2);
      await prefs.setString('type3', type3);
      await prefs.setString('type4', type4);
      await prefs.setString('type5', type5);
      await prefs.setString('type6', type6);
      await prefs.setString('type7', type7);
      await prefs.setString('type8', type8);
      await prefs.setString('type9', type9);
      await prefs.setString('type10', type10);
    });

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => Launcher(),
      ),
      (route) => false,
    );
  }
}

bool validateEmail(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

String dropdownValue = '';
List<String> business_type = [
  '',
  'ร้านอาหาร',
  'ร้านกาแฟ',
  'ร้านเครื่องเขียน',
  'ร้านเสริมสวย',
  'คลินิก/ขายยา',
  'ร้านทั่วไป',
  'สถานที่ใน Rmutt',
  'สถานที่ทั่วไป'
];
String dropdownValue2 = '';
List<String> business_type2 = [
  '',
  'ร้านอาหาร',
  'ร้านกาแฟ',
  'ร้านเครื่องเขียน',
  'ร้านเสริมสวย',
  'คลินิก/ขายยา',
  'ร้านทั่วไป',
  'สถานที่ใน Rmutt',
  'สถานที่ทั่วไป'
];
String dropdownValue3 = '';
List<String> business_type3 = [
  '',
  'ร้านอาหาร',
  'ร้านกาแฟ',
  'ร้านเครื่องเขียน',
  'ร้านเสริมสวย',
  'คลินิก/ขายยา',
  'ร้านทั่วไป',
  'สถานที่ใน Rmutt',
  'สถานที่ทั่วไป'
];
String dropdownValue4 = '';
List<String> business_type4 = [
  '',
  'ร้านอาหาร',
  'ร้านกาแฟ',
  'ร้านเครื่องเขียน',
  'ร้านเสริมสวย',
  'คลินิก/ขายยา',
  'ร้านทั่วไป',
  'สถานที่ใน Rmutt',
  'สถานที่ทั่วไป'
];
String dropdownValue5 = '';
List<String> business_type5 = [
  '',
  'ร้านอาหาร',
  'ร้านกาแฟ',
  'ร้านเครื่องเขียน',
  'ร้านเสริมสวย',
  'คลินิก/ขายยา',
  'ร้านทั่วไป',
  'สถานที่ใน Rmutt',
  'สถานที่ทั่วไป'
];
String dropdownValue6 = '';
List<String> business_type6 = [
  '',
  'ชาบู/ปิ้งย่าง',
  'ตามสั่ง',
  'จานด่วน',
  'เกาหลี',
  'ญี่ปุ่น',
  'ไทย',
  'ของหวาน',
  'ฟาสต์ฟูด',
  'อื่นๆ'
];
String dropdownValue7 = '';
List<String> business_type7 = [
  '',
  'ชาบู/ปิ้งย่าง',
  'ตามสั่ง',
  'จานด่วน',
  'เกาหลี',
  'ญี่ปุ่น',
  'ไทย',
  'ของหวาน',
  'ฟาสต์ฟูด',
  'อื่นๆ'
];
String dropdownValue8 = '';
List<String> business_type8 = [
  '',
  'ชาบู/ปิ้งย่าง',
  'ตามสั่ง',
  'จานด่วน',
  'เกาหลี',
  'ญี่ปุ่น',
  'ไทย',
  'ของหวาน',
  'ฟาสต์ฟูด',
  'อื่นๆ'
];
String dropdownValue9 = '';
List<String> business_type9 = [
  '',
  'ชาบู/ปิ้งย่าง',
  'ตามสั่ง',
  'จานด่วน',
  'เกาหลี',
  'ญี่ปุ่น',
  'ไทย',
  'ของหวาน',
  'ฟาสต์ฟูด',
  'อื่นๆ'
];
String dropdownValue10 = '';
List<String> business_type10 = [
  '',
  'ชาบู/ปิ้งย่าง',
  'ตามสั่ง',
  'จานด่วน',
  'เกาหลี',
  'ญี่ปุ่น',
  'ไทย',
  'ของหวาน',
  'ฟาสต์ฟูด',
  'อื่นๆ'
];
