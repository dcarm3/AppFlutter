class Task {
  String title;
  String description;
  DateTime? alarmTime;

  Task({required this.title, required this.description, this.alarmTime});

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'alarmTime': alarmTime?.toIso8601String(),
      };

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      alarmTime: DateTime.parse(json['alarmTime']),
    );
  }
}
