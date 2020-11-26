class Banner {
  int id;
  int bannerPositionId;
  String imageThumbnail;
  String caption;
  String imageLink;
  String url;

  Banner(
      {this.id,
        this.bannerPositionId,
        this.imageThumbnail,
        this.caption,
        this.imageLink,
        this.url,
        });

  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerPositionId = json['banner_position_id'];
    imageThumbnail = json['image_thumbnail'];
    caption = json['caption'];
    imageLink = json['image_link'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner_position_id'] = this.bannerPositionId;
    data['image_thumbnail'] = this.imageThumbnail;
    data['caption'] = this.caption;
    data['image_link'] = this.imageLink;
    data['url'] = this.url;
    return data;
  }
}