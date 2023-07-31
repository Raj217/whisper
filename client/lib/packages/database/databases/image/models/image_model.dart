part of database;

class ImageInfoModel {
  ObjectId id;
  String imageSourceID;
  String? publisherName;
  String? publisherURL;
  List<String> tags;
  Color color;
  ImageSource source;
  num views;
  num downloads;
  String? fileName;
  DateTime createdAt;
  DateTime updatedAt;

  ImageInfoModel({
    required this.id,
    required this.imageSourceID,
    required this.publisherName,
    required this.publisherURL,
    this.tags = const [],
    required this.color,
    required this.source,
    this.views = 0,
    this.downloads = 0,
    this.fileName,
    required this.createdAt,
    required this.updatedAt,
  });

  static ImageInfoModel fromMap(Map<String, dynamic> data) {
    return ImageInfoModel(
      id: data['_id'],
      imageSourceID: data['imageSourceID'],
      publisherName: data['publisherName'],
      publisherURL: data['publisherURL'],
      tags: List<String>.from(data['tags']),
      color: ColorExtension.fromHEX(data['color']),
      source: ImageSource.values
          .firstWhere((source) => source.name == data['source']),
      views: data['views'],
      downloads: data['downloads'],
      fileName: data['extra']?['fileName'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  String _genURL({int? width, int? height, int? quality}) {
    URLGenerator urlGenerator = URLGenerator(imageInfo: this);
    width ??= 300;
    height ??= 300;

    urlGenerator.addQuery("w", width.toString());
    urlGenerator.addQuery("h", height.toString());
    urlGenerator.addQuery("q", quality.toString());
    urlGenerator.addQuery("auto", 'format');
    urlGenerator.addQuery("fit", "crop");

    if (source == ImageSource.unsplash) {
      urlGenerator.addQuery("crop", "entropy");
    } else if (source == ImageSource.pexels) {
      urlGenerator.addQuery("cs", "tinysrgb");
    }
    return urlGenerator.url;
  }

  String thumbnailURL({int? width, int? height}) {
    return _genURL(width: width, height: height, quality: 10);
  }

  String viewURL({int? width, int? height}) {
    return _genURL(width: width, height: height, quality: 30);
  }

  String downloadURL({int? width, int? height}) {
    return _genURL(width: width, height: height, quality: 60);
  }
}

enum ImageSource {
  unsplash,
  pexels,
}
