import 'package:flutter/material.dart';
import 'package:mapallo/model/post.dart';
import 'package:mapallo/network/server_handler.dart';
import 'package:mapallo/screen/portal/widget/post_view.dart';
import 'package:mapallo/value/style_value.dart';

class PortalSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PortalSearchState();
}

class _PortalSearchState extends State<PortalSearch> {
  final List<Map<String, dynamic>> _filters = [
    {'icon': Icons.live_tv, 'text': "IGTV"},
    {'icon': Icons.shopping_basket, 'text': "Shop"},
    {'text': "Animals"},
    {'text': "Decor"},
    {'text': "Style"},
    {'text': "Travel"},
    {'text': "Science & Tech"},
    {'text': "Gaming"}
  ];

  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    final response = await ServerHandler.getPosts();
    if (response.reqStat == 100 && mounted)
      setState(() => _posts = response.posts);
    else
      print("Error loading posts");
  }

  void _onFilterSelected(String filter) {
    print('Filtering by $filter');
  }

  @override
  Widget build(BuildContext context) {
    final filters = SizedBox(
        height: 40,
        child: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _filters.map((Map<String, dynamic> filter) {
              final IconData icon = filter['icon'];
              final String text = filter['text'];

              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: RaisedButton(
                    color: StyleValue.WHITE,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(60),
                        side: BorderSide(color: Colors.grey.withAlpha(0x88))),
                    elevation: 0,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          icon == null ? Container() : Icon(icon, size: 20),
                          icon == null ? Container() : SizedBox(width: 4),
                          Text(text, style: TextStyle(color: StyleValue.BLACK))
                        ]),
                    onPressed: () => _onFilterSelected(text),
                  ));
            }).toList(),
          ),
        ));

    final posts = _posts.length == 0
        ? Center(child: CircularProgressIndicator())
        : Flexible(
            child: ListView.builder(
            itemCount: _posts.length,
            itemBuilder: (ctx, index) => PostView(_posts[index]),
          ));

    final body = Column(children: <Widget>[
      SizedBox(height: 30),
      filters,
      posts,
    ]);

    return body;
  }
}
