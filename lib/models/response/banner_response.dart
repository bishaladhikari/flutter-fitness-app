class BannerResponse {
  List<Banner> data;
  String error;

  BannerResponse(this.data, this.error);

  BannerResponse.withError(String errorValue)
      : data = List(),
        error = errorValue;

  BannerResponse.fromJson(Map<String, dynamic> json)
      : data =
            (json["data"] as List).map((i) => new Banner.fromJson(i)).toList(),
        error = null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
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
