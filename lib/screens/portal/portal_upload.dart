import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapallo/network/server_handler.dart';
import 'package:mapallo/screens/widgets/location_picker.dart';
import 'package:mapallo/values/style.dart';

class PortalUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PortalUploadState();
}

class _PortalUploadState extends State<PortalUpload> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _postTitle;
  String _postText;
  LatLng _postLatLng;

  void _onLocationSelect(LocationPickerController lpc, LatLng latLng) {
    lpc.clearMarkers();
    lpc.addMarker(Marker(
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
        markerId: MarkerId("Hello World")));
    _postLatLng = latLng;
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate() && _postLatLng != null) {
      form.save();
      _createPost(_postTitle.trim(), _postText.trim(), _postLatLng);
    } else
      print('Form not valid');
  }

  void _createPost(String title, String text, LatLng latLng) async {
    final response = await ServerHandler.createPost(title, text, latLng);
    if (response['req_stat'] == 100)
      print("Post created successfully!");
    else
      print("There was an error.");
  }

  @override
  Widget build(BuildContext context) {
    final title = Align(
        alignment: Alignment.centerLeft,
        child: Text("Create a Post",
            style: TextStyle(
                color: Style.PRIMARY,
                fontSize: 24,
                fontWeight: FontWeight.bold)));

    final List<Widget> formChildren = [
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(hintText: 'Title'),
        onSaved: (val) => _postTitle = val,
      ),
      TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(hintText: 'Tell a story...'),
        onSaved: (val) => _postText = val,
      )
    ];

    final Form form = Form(
        key: _formKey,
        autovalidate: true,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: formChildren)));

    final locationPicker = SizedBox(
      child: LocationPicker(onSelectCallback: _onLocationSelect),
      height: 400,
      width: 400,
    );

    final createButton = RaisedButton(
        child: Text("Post", style: TextStyle(color: Style.WHITE)),
        onPressed: _submit,
        color: Style.PRIMARY);

    return Padding(
      padding: EdgeInsets.all(14),
      child:
          Column(children: <Widget>[title, form, locationPicker, createButton]),
    );
  }
}
