import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostData extends StatelessWidget {
  const PostData({super.key});

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
              'Cucung Sukardi',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'cucungSukardi12@gmail.com',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
            ),

            const SizedBox(height: 12),

            // content text — membatasi baris agar tidak overflow, tapi bisa dihapus jika ingin full text
            Text(
              'lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        const Icon(Icons.thumb_up, size: 20),
                        const SizedBox(width: 6),
                        Text('12', style: GoogleFonts.poppins(fontSize: 13)),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Row(
                      children: [
                        const Icon(Icons.message, size: 20),
                        const SizedBox(width: 6),
                        Text('4', style: GoogleFonts.poppins(fontSize: 13)),
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
