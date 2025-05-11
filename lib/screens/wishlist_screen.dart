import 'dart:convert';

import 'package:bharatnxt/models/post.dart';
import 'package:bharatnxt/screens/post_detail.dart';
import 'package:bharatnxt/widgets/post_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  List<Post> wishList = [];

  Future<List<Post>> fetchWishlistPosts() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? postJsonList = prefs.getStringList('wishlist_posts');

    if (postJsonList != null) {
      return postJsonList.map((jsonStr) {
        final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
        return Post.fromJson(jsonMap);
      }).toList();
    }

    return [];
  }

  void loadWishlist() async {
    List<Post> loadedList = await fetchWishlistPosts();
    setState(() {
      wishList = loadedList;
    });
    print("Wishlist Loaded: ${wishList.length} items");
  }

  @override
  void initState() {
    super.initState();
    loadWishlist(); // Only call load method here
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: wishList.length,
      itemBuilder: (context, index) {
        final post = wishList[index];
        return PostLayout(
          userId: post.userId.toString(),
          title: post.title,
          postBody: post.body,
          onFavouriteTap: () {
            // Optional: remove from wishlist or handle favourite logic
          },
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetail(
                  id: post.id.toString(),
                  userId: post.userId.toString(),
                  title: post.title.toString(),
                  postBody: post.body.toString(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
