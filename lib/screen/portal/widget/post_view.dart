import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mapallo/model/post.dart';
import 'package:mapallo/value/style_value.dart';

class PostView extends StatelessWidget {
  final Post _post;

  PostView([this._post]);

  @override
  Widget build(BuildContext context) {
    print(_post);

    final title = Text(_post.title,
        style: TextStyle(color: StyleValue.PRIMARY, fontWeight: FontWeight.bold));
    final text = Text(_post.text, style: TextStyle(color: StyleValue.BLACK));
    final author = Text('By @${_post.user.username}',
        style: TextStyle(color: StyleValue.GREY, fontSize: 12));

    final body = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[title, text, author]);

    return Padding(padding: EdgeInsets.all(8), child: body);
  }
}
