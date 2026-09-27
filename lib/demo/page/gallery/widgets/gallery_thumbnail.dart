import 'package:flutter/material.dart';
import 'package:flutkit_ademin/demo/page/gallery/gallery_models.dart';
import 'package:flutkit_ademin/theme/themes.dart';

class GalleryThumbnail extends StatelessWidget {
  const GalleryThumbnail({
    super.key,
    required this.item,
    required this.themeData,
  });

  final GalleryItem item;
  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.asset(
              item.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text('by '),
            Text(
              item.author,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeData.colorScheme.onSurface,
              ),
            ),
            Spacer(),
            Icon(Icons.thumb_up_alt_outlined, size: 16, color: kTextColor),
            SizedBox(width: 4),
            Text(
              '${item.likes ~/ 100 / 10}K',
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
            SizedBox(width: 12),
            Icon(Icons.comment_outlined, size: 16, color: kTextColor),
            SizedBox(width: 4),
            Text(
              '${item.comments ~/ 100 / 10}K',
              style: TextStyle(color: themeData.colorScheme.onSurface),
            ),
          ],
        ),
      ],
    );
  }
}
