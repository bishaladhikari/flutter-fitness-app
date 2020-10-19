class CustomerReview {
  int id;
  int reviewedBy;
  int orderAttributeId;
  List<Null> images;
  String headline;
  String message;
  String rating;
  Null deletedAt;
  String createdAt;
  String updatedAt;
  List<Null> imageLink;
  List<Null> imageSize;
  List<Null> imageThumbnail;
  String reviewedAge;

  CustomerReview({this.id,
    this.reviewedBy,
    this.orderAttributeId,
    this.images,
    this.headline,
    this.message,
    this.rating,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.imageLink,
    this.imageSize,
    this.imageThumbnail,
    this.reviewedAge});

  CustomerReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewedBy = json['reviewed_by'];
    orderAttributeId = json['order_attribute_id'];
    // if (json['images'] != null) {
    //   images = new List<Null>();
    //   json['images'].forEach((v) {
    //     images.add(new Null.fromJson(v));
    //   });
    // }
    headline = json['headline'];
    message = json['message'];
    rating = json['rating'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // if (json['image_link'] != null) {
    //   imageLink = new List<Null>();
    //   json['image_link'].forEach((v) {
    //     imageLink.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['image_size'] != null) {
    //   imageSize = new List<Null>();
    //   json['image_size'].forEach((v) {
    //     imageSize.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['image_thumbnail'] != null) {
    //   imageThumbnail = new List<Null>();
    //   json['image_thumbnail'].forEach((v) {
    //     imageThumbnail.add(new Null.fromJson(v));
    //   });
    // }
    reviewedAge = json['reviewed_age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reviewed_by'] = this.reviewedBy;
    data['order_attribute_id'] = this.orderAttributeId;
    // if (this.images != null) {
    //   data['images'] = this.images.map((v) => v.toJson()).toList();
    // }
    data['headline'] = this.headline;
    data['message'] = this.message;
    data['rating'] = this.rating;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    // if (this.imageLink != null) {
    //   data['image_link'] = this.imageLink.map((v) => v.toJson()).toList();
    // }
    // if (this.imageSize != null) {
    //   data['image_size'] = this.imageSize.map((v) => v.toJson()).toList();
    // }
    // if (this.imageThumbnail != null) {
    //   data['image_thumbnail'] =
    //       this.imageThumbnail.map((v) => v.toJson()).toList();
    // }
    data['reviewed_age'] = this.reviewedAge;
    return data;
  }
}