import 'package:flutter/material.dart';
import 'package:mapallo/network/server_handler.dart';
import 'package:mapallo/screens/portal/widgets/post.dart';

class PortalSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PortalSearchState();
}

class _PortalSearchState extends State<PortalSearch> {
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    final response = await ServerHandler.getPosts();
    if (response['req_stat'] == 100)
      setState(() => _posts = response['posts']);
    else
      print("Error loading posts");
  }

  @override
  Widget build(BuildContext context) {
    final posts = ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (ctx, index) => Post(_posts[index]));

    return posts;
  }
}
