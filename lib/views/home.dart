import 'package:flutter/material.dart';
import 'package:forum_apps/controllers/post_controller.dart';
import 'package:forum_apps/views/widgets/post_data.dart';
import 'package:forum_apps/views/widgets/post_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController _postController = Get.put(PostController());
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forum Apps',
          style: GoogleFonts.poppins(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PostField(
                hintText: 'What do you want to ask?',
                controller: _textController,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  await _postController.createPost(
                    content: _textController.text.trim(),
                  );
                  _textController.clear();
                  _postController.getAllPosts();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                child: Obx(() {
                  return _postController.isLoading.value
                      ? const CircularProgressIndicator()
                      : Text('Post', style: TextStyle(color: Colors.white));
                }),
              ),
              const SizedBox(height: 15),
              Text(
                'Recent Posts',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                return _postController.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _postController.post.value.length,
                        itemBuilder: (context, index) {
                          return PostData(
                            post: _postController.post.value[index],
                          );
                        },
                      );
              }),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
