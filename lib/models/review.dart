class Review {
  int id;
  String headline;
  List<String> imageThumbnail;
  String message;
  int orderAttributeId;
  String rating;
  String reviewedDate;
  String userName;
  String customerImage;

  Review(
      {this.id,
      this.headline,
      this.imageThumbnail,
      this.message,
      this.orderAttributeId,
      this.rating,
      this.reviewedDate,
      this.userName,
      this.customerImage});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    headline = json['headline'];
    imageThumbnail = json['image_thumbnail'].cast<String>();
    message = json['message'];
    orderAttributeId = json['order_attribute_id'];
    rating = json['rating'];
    reviewedDate = json['reviewed_date'];
    userName = json['user_name'];
    customerImage = json['customer_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['headline'] = this.headline;
    data['image_thumbnail'] = this.imageThumbnail;
    data['message'] = this.message;
    data['order_attribute_id'] = this.orderAttributeId;
    data['rating'] = this.rating;
    data['reviewed_date'] = this.reviewedDate;
    data['user_name'] = this.userName;
    data['customer_image'] = this.customerImage;
    return data;
  }
}
