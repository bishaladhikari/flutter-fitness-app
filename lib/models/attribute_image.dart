class AttributeImage {
  String image;
  String imageThumbnail;

  AttributeImage({this.image, this.imageThumbnail});

  AttributeImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    imageThumbnail = json['image_thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['image_thumbnail'] = this.imageThumbnail;
    return data;
  }
}