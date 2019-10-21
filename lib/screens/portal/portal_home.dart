import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapallo/models/pin.dart';
import 'package:mapallo/models/post.dart';
import 'package:mapallo/network/server_handler.dart';

class PortalHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PortalHomeState();
}

class _PortalHomeState extends State<PortalHome> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    super.initState();
    _loadPins();
  }

  void _loadPins() async {
    final response = await ServerHandler.getPins();
    if (response.reqStat == 100)
      _setMarkers(response.pins);
    else
      print("Failed to load pins");
  }

  void _setMarkers(List<Pin> pins) {
    Set newMarkers = pins.map((pin) {
      Post post = Post.fromJson(pin.pinnable);

      return Marker(
        markerId: MarkerId(post.title),
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(pin.lat, pin.lng),
        infoWindow: InfoWindow(title: post.title),
        onTap: () => print(post.title),
      );
    }).toSet();
    setState(() => _markers = newMarkers);
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  Widget build(BuildContext context) {
    final body = GoogleMap(
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      initialCameraPosition: _kGooglePlex,
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (LatLng latLng) {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return Dialog(
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('You clicked at ${latLng.toString()}!')));
            });
      },
    );

    return Scaffold(
      body: body,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }
}
