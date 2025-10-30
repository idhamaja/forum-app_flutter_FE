import 'package:flutter/material.dart';
import 'package:forum_apps/controllers/post_controller.dart';
import 'package:forum_apps/models/post_model.dart';
import 'package:forum_apps/views/post_details.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatefulWidget {
  const PostData({super.key, required this.post});

  final PostModel post;

  @override
  State<PostData> createState() => _PostDataState();
}

class _PostDataState extends State<PostData> {
  final PostController _postController = Get.put(PostController());
  Color likedPost = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        // mainAxisSize.min supaya card menyesuaikan tinggi konten
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title + subtitle
            Text(
              widget.post.user!.name!,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.post.user!.email!,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
            ),

            const SizedBox(height: 12),

            // content text — membatasi baris agar tidak overflow, tapi bisa dihapus jika ingin full text
            Text(
              widget.post.content!,
              style: GoogleFonts.poppins(fontSize: 15, height: 1.4),
              softWrap: true,
              // gunakan maxLines jika ingin membatasi tinggi; hapus baris ini kalau mau semua text tampil
              // maxLines: 4,
              // overflow: TextOverflow.ellipsis,
            ),

            const SizedBox(height: 12),

            // action row — gunakan IconButton yang lebih kecil atau InkWell supaya tidak menambah tinggi berlebih
            Row(
              children: [
                // smaller icon button
                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () async {
                    var res = await _postController.likeAndDislike(
                      widget.post.id,
                    );
                    _postController.getAllPosts();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.thumb_up,
                          size: 20,
                          color: widget.post.liked!
                              ? Colors.greenAccent
                              : Colors.black,
                        ),
                        const SizedBox(width: 6),
                        Text('12', style: GoogleFonts.poppins(fontSize: 13)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    Get.to(() => PostDetails(post: widget.post));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        const Icon(Icons.message, size: 20),
                        const SizedBox(width: 6),
                        Text('40', style: GoogleFonts.poppins(fontSize: 13)),
                      ],
                    ),
                  ),
                ),

                // push remaining space to right (optional)
                const Spacer(),

                // waktu atau tombol lain di kanan
                Text(
                  '2h',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
