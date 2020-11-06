class Links {
  String bonusPoints;
  int points;
  // List<dynamic> setting;

  Links({this.bonusPoints, this.points});

  Links.fromJson(Map<String, dynamic> json) {
    bonusPoints = json['bonus_points'];
    points = json['points'];
    // setting = json['setting'] as List;
  }
}
