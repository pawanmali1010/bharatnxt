import 'dart:convert';

import 'package:bharatnxt/models/post.dart';
import 'package:bharatnxt/screens/post_detail.dart';
import 'package:bharatnxt/widgets/post_layout.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> postList = [];
  List<Post> filteredPost = [];



  final TextEditingController searchController = TextEditingController();

  Future<void> fetchPost() async {
    final url = Uri.parse("https://jsonplaceholder.typicode.com/posts");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        setState(() {
          postList = data.map((json) => Post.fromJson(json)).toList();
          filteredPost = postList; // Initialize with full list
        });
      }
    } catch (err) {
      print(err);
    }
  }

  void search() {
    String query = searchController.text.toLowerCase();

    setState(() {
      filteredPost = postList.where((post) {
        return post.title!.toLowerCase().contains(query) ||
            post.body!.toLowerCase().contains(query);
      }).toList();
    });
  }






Future<void> savePostToWishlist(Post post) async {
  final prefs = await SharedPreferences.getInstance();

  // Get existing list or empty
  List<String> existingPosts = prefs.getStringList('wishlist_posts') ?? [];

  // Encode the new post
  String newPostJson = jsonEncode(post.toJson());

  // Optional: avoid duplicates
  if (!existingPosts.contains(newPostJson)) {
    existingPosts.add(newPostJson);
    await prefs.setStringList('wishlist_posts', existingPosts);
  }
}





  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Post",
                suffix: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                  ),
                  onPressed: search,
                  child: const Text("Search"),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: filteredPost.length,
            itemBuilder: (context, index) {
              final post = filteredPost[index];
              return PostLayout(
                userId: post.userId.toString(),
                title: post.title,
                postBody: post.body,

                onFavouriteTap:(){
                  savePostToWishlist(postList[index]);
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
          ),
        ),
      ],
    );
  }
}
