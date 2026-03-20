import 'dart:convert';

class CompletedHabits {
  final String habit;
  final String color;

  CompletedHabits({required this.habit, required this.color});

  // Convert a JSON object to an CompletedHabits instance
  factory CompletedHabits.fromJson(Map<String, dynamic> json) {
    return CompletedHabits(habit: json['habit'], color: json['color']);
  }

  // Convert an CompletedHabits instance to a JSON object
  Map<String, dynamic> toJson() {
    return {'habit': habit, 'color': color};
  }
}
