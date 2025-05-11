import 'package:flutter/material.dart';

class PostDetail extends StatefulWidget {
  final String id;
  final String userId;
  final String title;
  final String postBody;

  const PostDetail({
    super.key,
    required this.id,
    required this.userId,
    required this.title,
    required this.postBody,
  });

  @override
  State<PostDetail> createState() => _PostDetailState();
}

class _PostDetailState extends State<PostDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Details"),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabelAndValue("Post ID", widget.id),
                const SizedBox(height: 10),
                _buildLabelAndValue("User ID", widget.userId),
                const SizedBox(height: 10),
                _buildLabelAndValue("Title", widget.title),
                const SizedBox(height: 10),
                _buildLabelAndValue("Body", widget.postBody),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabelAndValue(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
