import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPicker extends StatefulWidget {
  final bool isMaster;
  final Function(LocationPickerController, LatLng) onSelectCallback;

  LocationPicker({this.isMaster = false, this.onSelectCallback});

  @override
  State<StatefulWidget> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = Set<Marker>();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 10,
  );

  void _clearMarkers() => setState(() => _markers.clear());

  void _addMarker(Marker marker) => setState(() => _markers.add(marker));

  void _onLocationSelect(BuildContext ctx, LatLng latLng) {
    if (widget.isMaster)
      Navigator.of(ctx).pop(latLng);
    else if (widget.onSelectCallback != null)
      widget.onSelectCallback(
        LocationPickerController(_clearMarkers, _addMarker),
        latLng,
      );
  }

  @override
  Widget build(BuildContext context) {
    final body = GoogleMap(
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      markers: _markers,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      onTap: (latLng) => _onLocationSelect(context, latLng),
    );

    return body;
  }
}

class LocationPickerController {
  final Function() _clearMarkers;
  final Function(Marker) _addMarker;

  void clearMarkers() => _clearMarkers();

  void addMarker(Marker marker) => _addMarker(marker);

  LocationPickerController([this._clearMarkers, this._addMarker]);
}
