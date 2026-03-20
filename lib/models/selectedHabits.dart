import 'dart:convert';

class SelectedHabits {
  final String habit;
  final String color;

  SelectedHabits({required this.habit, required this.color});

  // Convert a JSON object to an SelectedHabits instance
  factory SelectedHabits.fromJson(Map<String, dynamic> json) {
    return SelectedHabits(habit: json['habit'], color: json['color']);
  }

  // Convert an SelectedHabits instance to a JSON object
  Map<String, dynamic> toJson() {
    return {'habit': habit, 'color': color};
  }
}
