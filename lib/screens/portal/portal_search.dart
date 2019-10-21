import 'package:flutter/material.dart';
import 'package:mapallo/models/post.dart';
import 'package:mapallo/network/server_handler.dart';
import 'package:mapallo/screens/portal/widgets/post_view.dart';

class PortalSearch extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PortalSearchState();
}

class _PortalSearchState extends State<PortalSearch> {
  List<Post> _posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    final response = await ServerHandler.getPosts();
    if (response.reqStat == 100)
      setState(() => _posts = response.posts);
    else
      print("Error loading posts");
  }

  @override
  Widget build(BuildContext context) {
    final posts = ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (ctx, index) => PostView(_posts[index]),
    );

    return posts;
  }
}
