class CustomerReview {
  int id;
  int reviewedBy;
  int orderAttributeId;
  List<dynamic> images;
  String headline;
  String message;
  String rating;
  String deletedAt;
  String createdAt;
  String updatedAt;
  List<dynamic> imageLinks;
  List<int> imageSize;
  List<dynamic> imageThumbnails;
  String reviewedAge;

  CustomerReview(
      {this.id,
      this.reviewedBy,
      this.orderAttributeId,
      this.images,
      this.headline,
      this.message,
      this.rating,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.imageLinks,
      this.imageSize,
      this.imageThumbnails,
      this.reviewedAge});

  CustomerReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewedBy = json['reviewed_by'];
    orderAttributeId = json['order_attribute_id'];
    // images = json['images'].cast<String>();
    headline = json['headline'];
    message = json['message'];
    rating = json['rating'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageLinks = json['image_link'] as List;
    // imageSize = json['image_size'].cast<int>();
    imageThumbnails = json['image_thumbnail'] as List;
    reviewedAge = json['reviewed_age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reviewed_by'] = this.reviewedBy;
    data['order_attribute_id'] = this.orderAttributeId;
    data['images'] = this.images;
    data['headline'] = this.headline;
    data['message'] = this.message;
    data['rating'] = this.rating;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_link'] = this.imageLinks;
    data['image_size'] = this.imageSize;
    data['image_thumbnail'] = this.imageThumbnails;
    data['reviewed_age'] = this.reviewedAge;
    return data;
  }
}
