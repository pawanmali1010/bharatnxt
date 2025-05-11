import 'package:flutter/material.dart';

class PostLayout extends StatelessWidget {
  String? userId;
  String? title;
  String? postBody;
  VoidCallback onTap;
  VoidCallback onFavouriteTap;
   PostLayout({super.key, required this.userId, required this.title, required this.postBody, required this.onTap, required this.onFavouriteTap});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("User Id :$userId", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                      IconButton(
                        onPressed: onFavouriteTap, 
                        icon: Icon(Icons.favorite_outline)
                        ),
                    ],
                  ),
                  Text("Title :$title",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
        
                  SizedBox(height: 20,),
                  Text(postBody.toString(),overflow: TextOverflow.ellipsis,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}