import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMap extends StatefulWidget {
  @override
  _MyGoogleMapState createState() => _MyGoogleMapState();
}

LatLng location = LatLng(30.1128314, 31.4019791);
LatLng cairoAirPortLocation = LatLng(30.1128314, 31.4019791);
Marker cairoAirportMarker = Marker(
    markerId: MarkerId("CairoAirPort"),
    position: cairoAirPortLocation,
    infoWindow: InfoWindow(title: "Cairo Air port", onTap: () {}),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));

LatLng pyramidsLocation = LatLng(29.977389, 31.132494);

GoogleMapController _googleMapController;

goToPyramids() {
  CameraPosition pyramidsCameraPosition =
      CameraPosition(target: pyramidsLocation, zoom: 16);
  _googleMapController
      .animateCamera(CameraUpdate.newCameraPosition(pyramidsCameraPosition));
}

_onMapCreated(GoogleMapController googleMapController) {
  _googleMapController = googleMapController;

  goToCurrentLocation();
}

goToCurrentLocation() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  LatLng currentLocation = LatLng(position.latitude, position.longitude);

  CameraPosition userCameraPosition =
      CameraPosition(target: currentLocation, zoom: 16);
  _googleMapController
      .animateCamera(CameraUpdate.newCameraPosition(userCameraPosition));
}

class _MyGoogleMapState extends State<MyGoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.sentiment_neutral),
        onPressed: () {
          goToPyramids();
        },
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        mapType: MapType.normal,
        markers: {cairoAirportMarker},
        initialCameraPosition: CameraPosition(target: location, zoom: 13.0),
      ),
    );
  }
}
