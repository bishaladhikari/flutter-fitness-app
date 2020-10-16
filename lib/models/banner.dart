class Banner {
  int id;
  int bannerPositionId;
  String imageThumbnail;
  String caption;
  String imageLink;

  Banner(
      {this.id,
        this.bannerPositionId,
        this.imageThumbnail,
        this.caption,
        this.imageLink});

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerPositionId = json['banner_position_id'];
    imageThumbnail = json['image_thumbnail'];
    caption = json['caption'];
    imageLink = json['image_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_position_id'] = this.bannerPositionId;
    data['image_thumbnail'] = this.imageThumbnail;
    data['caption'] = this.caption;
    data['image_link'] = this.imageLink;
    return data;
  }
}