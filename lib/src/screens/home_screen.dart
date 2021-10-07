import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noppon/src/blocs/application_bloc.dart';
import 'package:noppon/src/models/place.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  Completer<GoogleMapController> _mapController = Completer();
  late StreamSubscription locationSubscription;
  late StreamSubscription boundsSubscription;
  final _locationController = TextEditingController();

  @override
  void initState() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);

    //Listen for selected Location
    locationSubscription = applicationBloc.selectedLocation.stream
        .asBroadcastStream()
        .listen((place) {
      if (place != null) {
        _locationController.text = place.name;
        _goToPlace(place);
      } else
        _locationController.text = "";
    });

    applicationBloc.bounds.stream.asBroadcastStream().listen((bounds) async {
      final GoogleMapController controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
    });
    super.initState();
  }

  @override
  void dispose() {
    final applicationBloc =
        Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    _locationController.dispose();
    locationSubscription.cancel();
    boundsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);
    return Scaffold(
        body: (applicationBloc.currentLocation == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextField(
                  //     controller: _locationController,
                  //     textCapitalization: TextCapitalization.words,
                  //     decoration: InputDecoration(
                  //       hintText: 'ค้นหาสถานที่ใกล้เคียง',
                  //       suffixIcon: Icon(Icons.search),
                  //     ),
                  //     onChanged: (value) => applicationBloc.searchPlaces(value),
                  //     onTap: () => applicationBloc.clearSelectedLocation(),
                  //   ),
                  // ),
                  // Stack(
                  //   children: [
                  Container(
                    height: 400,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(applicationBloc.currentLocation.latitude,
                            applicationBloc.currentLocation.longitude),
                        zoom: 16,
                      ),
                      myLocationEnabled: true,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                      markers: Set<Marker>.of(applicationBloc.markers),
                    ),
                  ),
                  // if (applicationBloc.searchResults != null &&
                  //
                  //     applicationBloc.searchResults.length != 0)

                  // Container(
                  //     height: 300.0,
                  //     width: double.infinity,
                  //     decoration: BoxDecoration(
                  //         color: Colors.black.withOpacity(.6),
                  //         backgroundBlendMode: BlendMode.darken)),
                  // if (applicationBloc.searchResults != null)
                  //   Container(
                  //     height: 300.0,
                  //     child: ListView.builder(
                  //         itemCount: applicationBloc.searchResults.length,
                  //         itemBuilder: (context, index) {
                  //           return ListTile(
                  //             title: Text(
                  //               applicationBloc
                  //                   .searchResults[index].description,
                  //               style: TextStyle(color: Colors.white),
                  //             ),
                  //             onTap: () {
                  //               applicationBloc.setSelectedLocation(
                  //                   applicationBloc
                  //                       .searchResults[index].placeId);
                  //             },
                  //           );
                  //         }),
                  //   ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('สิ่งที่คุณต้องการค้นหา',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      spacing: 8.0,
                      children: [
                        FilterChip(
                          label: Text('แคมป์'),
                          onSelected: (val) => applicationBloc.togglePlaceType(
                              'campground', val),
                          selected: applicationBloc.placeType == 'campground',
                          selectedColor: Colors.blue,
                        ),
                        FilterChip(
                            label: Text('โรงพยาบาล'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('hospital', val),
                            selected: applicationBloc.placeType == 'hospital',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('ร้านซ่อมรถ'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('car_repair', val),
                            selected: applicationBloc.placeType == 'car_repair',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('คาเฟ่'),
                            onSelected: (val) =>
                                applicationBloc.togglePlaceType('cafe', val),
                            selected: applicationBloc.placeType == 'cafe',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('ร้านอาหาร'),
                            onSelected: (val) =>
                                applicationBloc.togglePlaceType('food', val),
                            selected: applicationBloc.placeType == 'food',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('atm'),
                            onSelected: (val) =>
                                applicationBloc.togglePlaceType('atm', val),
                            selected: applicationBloc.placeType == 'atm',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('ร้านค้า/ทั่วไป'),
                            onSelected: (val) =>
                                applicationBloc.togglePlaceType('store', val),
                            selected: applicationBloc.placeType == 'store',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('ร้านขายรองเท้า'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('shoe_store', val),
                            selected: applicationBloc.placeType == 'shoe_store',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('ห้องสมุด'),
                            onSelected: (val) =>
                                applicationBloc.togglePlaceType('library', val),
                            selected: applicationBloc.placeType == 'library',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('คาร์แคร์'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('car_wash', val),
                            selected: applicationBloc.placeType == 'car_wash',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('ซูเปอร์มาร์เก็ต'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('supermarket', val),
                            selected:
                                applicationBloc.placeType == 'supermarket',
                            selectedColor: Colors.blue),
                        FilterChip(
                            label: Text('ตัดผม/เสริมสวย'),
                            onSelected: (val) => applicationBloc
                                .togglePlaceType('hair_care', val),
                            selected: applicationBloc.placeType == 'hair_care',
                            selectedColor: Colors.blue),
                      ],
                    ),
                  )
                ],
              ));
  }

  Future<void> _goToPlace(Place place) async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(
                place.geometry.location.lat, place.geometry.location.lng),
            zoom: 14.0),
      ),
    );
  }
}
