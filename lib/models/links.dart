class Links {
  String first;
  String last;
  String prev;
  String next;

  Links({this.first, this.last, this.prev, this.next});

  Links.fromJson(Map<String, dynamic> json) {
    first = json['first'];
    last = json['last'];
    prev = json['prev'] != null ? json['prev'] : null;
    next = json['next'] != null ? json['next'] : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['first'] = this.first;
  //   data['last'] = this.last;
  //   data['prev'] = this.prev;
  //   data['next'] = this.next;
  //   return data;
  // }
}