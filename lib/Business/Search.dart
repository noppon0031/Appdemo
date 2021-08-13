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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter your search'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: ListView(children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 10,
                    children: List<Widget>.generate(10, (index) {
                      final isSelected = index % 2 == 0;

                      return FilterChip(
                        label: Text('Category $index'),
                        labelStyle: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyText1!.color,
                          fontWeight: FontWeight.bold,
                        ),
                        selected: isSelected,
                        selectedColor: Colors.redAccent,
                        checkmarkColor: Colors.white,
                        onSelected: (bool selected) {},
                      );
                    }),
                  )
                ],
              ))
        ]),
      ),
    );
  }
}
