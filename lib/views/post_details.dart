import 'package:flutter/material.dart';
import 'package:forum_apps/controllers/post_controller.dart';
import 'package:forum_apps/models/post_model.dart';
import 'package:forum_apps/views/widgets/input_widget.dart';
import 'package:forum_apps/views/widgets/post_data.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});

  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentController = TextEditingController();
  final PostController _postController = Get.put(PostController());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _postController.getComments(widget.post.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.post.user!.name!,
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PostData(post: widget.post),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 450,
                child: Obx(() {
                  return _postController.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _postController.comments.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                _postController
                                    .comments
                                    .value[index]
                                    .user!
                                    .name!,
                              ),
                              subtitle: Text(
                                _postController.comments.value[index].body!,
                              ),
                            );
                          },
                        );
                }),
              ),
              InputWidget(
                hintText: 'Write a comment',
                controller: _commentController,
                obscureText: false,
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () async {
                  await _postController.createComment(
                    widget.post.id,
                    _commentController.text.trim(),
                  );
                  _commentController.clear();
                  _postController.getComments(widget.post.id);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                child: Text(
                  'Comment',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
