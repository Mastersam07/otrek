import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:otrek/utils/core.dart';
import 'package:geolocator/geolocator.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Map(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  GoogleMapController mapController;
  static const _initialPosition = LatLng(6.5244, 3.3792);
  LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _initialPosition,
            zoom: 15.0,
          ),
          onMapCreated: onCreated,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          compassEnabled: true,
          markers: _markers,
          onCameraMove: _onCameraMove,
        ),
        Positioned(
          top: 50.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3
                ),
              ],
            ),
            child: TextField(
              cursorColor: Colors.black,
              // controller: locationController,
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    top: 5,
                  ),
                  width: 10,
                  height: 10,
                  child: Icon(Icons.location_on, color: Colors.black),
                ),
                hintText: "Start Trekking",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        ),
        Positioned(
          top: 105.0,
          right: 15.0,
          left: 15.0,
          child: Container(
            height: 50.0,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 5.0),
                    blurRadius: 10,
                    spreadRadius: 3,
                  )
                ]
            ),
            child: TextField(
              cursorColor: Colors.black,
              // controller: destinationController,
              textInputAction: TextInputAction.go,
              onSubmitted: (value) {
                // sendRequest(value);
              },
              decoration: InputDecoration(
                icon: Container(
                  margin: EdgeInsets.only(left: 20, top: 5),
                  width: 10,
                  height: 10,
                  child: Icon(Icons.directions_walk, color: Colors.black,),
                ),
                hintText: "Destination?",
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
              ),
            ),
          ),
        )
      ],
    );
  }

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastPosition = position.target;
    });
  }

  void _onAddMarkerPressed() {
    setState(() {
      _markers.add(
        Marker(
            markerId: MarkerId(_lastPosition.toString()),
            position: _lastPosition,
            infoWindow: InfoWindow(
              title: "Lagos",
              snippet: "Ikeja",
            ),
            icon: BitmapDescriptor.defaultMarker),
      );
    });
  }
}
