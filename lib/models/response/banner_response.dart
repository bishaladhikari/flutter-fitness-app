class BannerResponse {
  List<Banner> banners;
  String error;

  BannerResponse(this.banners, this.error);

  BannerResponse.withError(String errorValue)
      : banners = List(),
        error = errorValue;

  BannerResponse.fromJson(Map<String, dynamic> json)
      : banners = (json["data"] as List).map((i) => new Banner.fromJson(i)).toList(),
        error = null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['data'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banner {
  int id;
  int bannerPositionId;
  String imageThumbnail;
  String caption;
  String imageLink;
  String url;

  Banner({
    this.id,
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
