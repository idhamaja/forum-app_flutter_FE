import 'package:flutter/material.dart';
import 'package:forum_apps/views/widgets/post_data.dart';
import 'package:forum_apps/views/widgets/post_field.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _postController = TextEditingController();
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
                controller: _postController,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(color: Colors.white),
                ),
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
              PostData(),
              const SizedBox(height: 10),
              PostData(),
              const SizedBox(height: 10),
              PostData(),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
