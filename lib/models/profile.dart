class Profile {
  int id;
  int preferredLocale;
  String firstName;
  String lastName;
  String username;
  String email;
  String emailVerifiedAt;
  String mobile;
  String createdAt;
  String updatedAt;
  int customerOrdersCount;
  int wishlistCount;
  String fullName;
  String storeName;
  String ip;
  int attributeCount;
  // Customer customer;

  Profile(
      {this.id,
      this.preferredLocale,
      this.firstName,
      this.lastName,
      this.username,
      this.email,
      this.emailVerifiedAt,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.customerOrdersCount,
      this.wishlistCount,
      this.fullName,
      this.storeName,
      this.ip,
      this.attributeCount,
      // this.customer
  });

  Profile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    preferredLocale = json['preferred_locale'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerOrdersCount = json['customer_orders_count'];
    wishlistCount = json['wishlist_count'];
    fullName = json['full_name'];
    storeName = json['store_name'];
    ip = json['ip'];
    attributeCount = json['attribute_count'];
    // customer = json['customer'] != null
    //     ? new Customer.fromJson(json['customer'])
    //     : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['preferred_locale'] = this.preferredLocale;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_orders_count'] = this.customerOrdersCount;
    data['wishlist_count'] = this.wishlistCount;
    data['full_name'] = this.fullName;
    data['store_name'] = this.storeName;
    data['ip'] = this.ip;
    data['attribute_count'] = this.attributeCount;
    // if (this.customer != null) {
    //   data['customer'] = this.customer.toJson();
    // }
    return data;
  }
}

class Customer {
  String referCode;
  int userId;
  String ip;
  String actor;
  String subject;
  String imageLink;
  String totalPoints;
  int totalReferrals;
  int totalReferralPoints;
  int totalOrderPoints;

  Customer(
      {this.referCode,
      this.userId,
      this.ip,
      this.actor,
      this.subject,
      this.imageLink,
      this.totalPoints,
      this.totalReferrals,
      this.totalReferralPoints,
      this.totalOrderPoints});

  Customer.fromJson(Map<String, dynamic> json) {
    referCode = json['refer_code'];
    userId = json['user_id'];
    ip = json['ip'];
    actor = json['actor'];
    subject = json['subject'];
    imageLink = json['image_link'];
    totalPoints = json['total_points'];
    totalReferrals = json['total_referrals'];
    totalReferralPoints = json['total_referral_points'];
    totalOrderPoints = json['total_order_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refer_code'] = this.referCode;
    data['user_id'] = this.userId;
    data['ip'] = this.ip;
    data['actor'] = this.actor;
    data['subject'] = this.subject;
    data['image_link'] = this.imageLink;
    data['total_points'] = this.totalPoints;
    data['total_referrals'] = this.totalReferrals;
    data['total_referral_points'] = this.totalReferralPoints;
    data['total_order_points'] = this.totalOrderPoints;
    return data;
  }
}
