// search result item data model

class SearchResultItem {
  final String title;
  final String url;
  final String description;
  final int likes;
  final int comments;
  final String author;

  SearchResultItem({
    required this.title,
    required this.url,
    required this.description,
    required this.likes,
    required this.comments,
    required this.author,
  });
}

// image search item model

class GalleryItem {
  final String imageUrl;
  final String author;
  final int likes;
  final int comments;
  final String category;

  GalleryItem({
    required this.imageUrl,
    required this.author,
    required this.likes,
    required this.comments,
    required this.category,
  });
}

// Documents / Files data model

class DocumentData {
  final String fileName;
  final String fileType;
  final double fileSize; // in kB
  final DateTime uploadDate; // Stored as 'yyyy-MM-dd'

  DocumentData({
    required this.fileName,
    required this.fileType,
    required this.fileSize,
    required this.uploadDate,
  });
}

// video search result model

class VideoSearchResultItem {
  final String title;
  final String url;
  final String videoUrl;
  final String description;
  final int likes;
  final int comments;
  final String author;

  VideoSearchResultItem({
    required this.title,
    required this.url,
    required this.videoUrl,
    required this.description,
    required this.likes,
    required this.comments,
    required this.author,
  });
}
