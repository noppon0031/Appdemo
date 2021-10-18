import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noppon/src/models/geometry.dart';
import 'package:noppon/src/models/location.dart';
import 'package:noppon/src/models/place.dart';
import 'package:noppon/src/models/place_search.dart';
import 'package:noppon/src/services/geolocator_service.dart';
import 'package:noppon/src/services/marker_service.dart';
import 'package:noppon/src/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final markerService = MarkerService();

  //Variables
  late Position currentLocation;
  List<PlaceSearch>? searchResults;
  StreamController<Place> selectedLocation =
      StreamController<Place>.broadcast();
  StreamController<LatLngBounds> bounds =
      StreamController<LatLngBounds>.broadcast();
  late Place selectedLocationStatic;
  String? placeType;
  List<Place>? placeResults;
  List<Marker> markers = [];

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(
      name: '',
      geometry: Geometry(
        location: Location(
            lat: currentLocation.latitude, lng: currentLocation.longitude),
      ),
      vicinity: '',
    );
    notifyListeners();
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation.add(sLocation);
    selectedLocationStatic = sLocation;

    notifyListeners();
  }

  togglePlaceType(String value, bool selected) async {
    if (selected) {
      placeType = value;
    } else {
      placeType = '';
    }

    if (placeType != null) {
      var places = await placesService.getPlaces(
          selectedLocationStatic.geometry.location.lat,
          selectedLocationStatic.geometry.location.lng,
          placeType!);
      markers = [];
      if (places.length > 0) {
        var newMarker = markerService.createMarkerFromPlace(places[0], false);
        markers.add(newMarker);
      }
      if (places.length > 1) {
        var newMarker = markerService.createMarkerFromPlace(places[1], false);
        markers.add(newMarker);
      }
      if (places.length > 2) {
        var newMarker = markerService.createMarkerFromPlace(places[2], false);
        markers.add(newMarker);
      }
      if (places.length > 3) {
        var newMarker = markerService.createMarkerFromPlace(places[3], false);
        markers.add(newMarker);
      }
      if (places.length > 4) {
        var newMarker = markerService.createMarkerFromPlace(places[4], false);
        markers.add(newMarker);
      }

      var locationMarker =
          markerService.createMarkerFromPlace(selectedLocationStatic, true);
      markers.add(locationMarker);

      var _bounds = markerService.bounds(Set<Marker>.of(markers));
      bounds.add(_bounds!);

      notifyListeners();
    }
  }

  @override
  void dispose() {
    selectedLocation.close();
    bounds.close();
    super.dispose();
  }
}
