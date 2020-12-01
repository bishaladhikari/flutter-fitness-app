class User {
  int id;
  String firstName;
  String lastName;
  String fullName;
  Customer customer;

  User({this.id, this.firstName, this.lastName, this.fullName, this.customer});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : Customer();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
    data['customer'] = this.customer;
    return data;
  }
}

class Customer {
  bool status;
  bool verified;
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
      {this.status,
      this.verified,
      this.referCode,
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
    status = json['status'];
    verified = json['verified'];
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
    data['status'] = this.status;
    data['verified'] = this.verified;
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
