class Address {
  int id;
  int customerId;
  String name;
  String phone;
  String email;
  String zipCode;
  String house;
  String address;
  String city;
  String prefecture;
  String addressType;
  String createdAt;
  String updatedAt;
  Null deletedAt;
  bool isDefault;
  Customer customer;

  Address(
      {this.id,
      this.customerId,
      this.name,
      this.phone,
      this.email,
      this.zipCode,
      this.house,
      this.address,
      this.city,
      this.prefecture,
      this.addressType,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isDefault,
      this.customer});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    zipCode = json['zip_code'];
    house = json['house'];
    address = json['address'];
    city = json['city'];
    prefecture = json['prefecture'];
    addressType = json['address_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isDefault = json['is_default'];
//    customer = json['customer'] != null
//        ? new Customer.fromJson(json['customer'])
//        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['zip_code'] = this.zipCode;
    data['house'] = this.house;
    data['address'] = this.address;
    data['city'] = this.city;
    data['prefecture'] = this.prefecture;
    data['address_type'] = this.addressType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['is_default'] = this.isDefault;
    if (this.customer != null) {
      data['customer'] = this.customer.toJson();
    }
    return data;
  }
}

class Customer {
  int id;
  int userId;
  int addressId;
  String referredBy;
  String referToken;
  Null image;
  Null description;
  bool status;
  bool loginStatus;
  bool verified;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String ip;
  String actor;
  String subject;
  String imageLink;
  String totalPoints;
  int totalReferrals;
  String totalReferralPoints;
  int totalOrderPoints;

  Customer(
      {this.id,
      this.userId,
      this.addressId,
      this.referredBy,
      this.referToken,
      this.image,
      this.description,
      this.status,
      this.loginStatus,
      this.verified,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.ip,
      this.actor,
      this.subject,
      this.imageLink,
      this.totalPoints,
      this.totalReferrals,
      this.totalReferralPoints,
      this.totalOrderPoints});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    addressId = json['address_id'];
    referredBy = json['referred_by'];
    referToken = json['refer_token'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    loginStatus = json['login_status'];
    verified = json['verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    ip = json['ip'];
    actor = json['actor'];
    subject = json['subject'];
    imageLink = json['image_link'];
//    totalPoints = json['total_points'];
    totalReferrals = json['total_referrals'];
//    totalReferralPoints = json['total_referral_points'];
    totalOrderPoints = json['total_order_points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['address_id'] = this.addressId;
    data['referred_by'] = this.referredBy;
    data['refer_token'] = this.referToken;
    data['image'] = this.image;
    data['description'] = this.description;
    data['status'] = this.status;
    data['login_status'] = this.loginStatus;
    data['verified'] = this.verified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
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

