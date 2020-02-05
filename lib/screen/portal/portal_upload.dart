import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mapallo/network/server_handler.dart';
import 'package:mapallo/widget/location_picker.dart';
import 'package:mapallo/value/style.dart';

class PortalUpload extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PortalUploadState();
}

class _PortalUploadState extends State<PortalUpload> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;
  String _postTitle;
  String _postText;
  LatLng _postLatLng;

  bool _isUploading = false;

  void _onLocationSelect(LocationPickerController lpc, LatLng latLng) {
    print(latLng);
    lpc.clearMarkers();
    lpc.addMarker(Marker(
      position: latLng,
      icon: BitmapDescriptor.defaultMarker,
      markerId: MarkerId("lat-lng"),
    ));
    _postLatLng = latLng;
  }

  void _submit() {
    final form = _formKey.currentState;
    if (form.validate() && _image != null && _postLatLng != null) {
      form.save();
      _createPost(_postTitle.trim(), _postText.trim(), _image, _postLatLng);
    } else {
      print('Form not valid');
      _showError('Missing required info.');
    }
  }

  Future<String> _fileToBase64(File file) async {
    Future<List> list = file.readAsBytes();
    return list.then((bytes) => base64Encode(bytes));
  }

  void _createPost(String title, String text, File image, LatLng latLng) async {
    setState(() => _isUploading = true);

    final String image64 = await _fileToBase64(image);

    final response =
        await ServerHandler.createPost(title, text, image64, latLng);
    if (response.reqStat == 100) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success!'),
            content: Text('Your post was created.'),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      setState(() => _isUploading = false);
      print("Post created successfully!");
    } else {
      print("There was an error.");
      _showError("There was an error.");
    }
  }

  void _showError(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 2),
    );
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _onImagePickerClick() async {
    final File image = await ImagePicker.pickImage(source: ImageSource.gallery);

    print(await _fileToBase64(image));

    if (image != null) setState(() => _image = image);
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

    final imagePicker = InkWell(
        onTap: _onImagePickerClick,
        child: SizedBox(
            width: 80,
            height: 80,
            child:
                _image == null ? Icon(Icons.file_upload) : Image.file(_image)));

    final Form form = Form(
        key: _formKey,
        autovalidate: true,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: formChildren)));

    final topSection = Padding(
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[imagePicker, Expanded(child: form)]));

    final locationPicker =
        Flexible(child: LocationPicker(onSelectCallback: _onLocationSelect));

    final createButton = Padding(
        padding: EdgeInsets.all(20),
        child: _isUploading
            ? CircularProgressIndicator()
            : RaisedButton(
                child: Text("Post", style: TextStyle(color: Style.WHITE)),
                onPressed: _submit,
                color: Style.PRIMARY));

    return Column(
      children: <Widget>[title, topSection, locationPicker, createButton],
    );
  }
}
