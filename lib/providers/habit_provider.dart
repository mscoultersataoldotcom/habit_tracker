import 'package:flutter/foundation.dart';
import 'package:localstorage/localstorage.dart';
import '../models/completedHabits.dart';
import '../models/selectedHabits.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HabitProvider with ChangeNotifier {
  final LocalStorage storage;

  // List of selected habits
  List<SelectedHabits> _selectedhabits = [];

  // List of completed habits
  List<CompletedHabits> _completedhabits = [];

  // Getters
  List<SelectedHabits> get selectedhabits => _selectedhabits;
  List<CompletedHabits> get completedhabits => _completedhabits;

  HabitProvider(this.storage) {
    loadSelectedHabitsFromStorage();
    loadCompletedHabitsFromStorage();
  }

  void loadSelectedHabitsFromStorage() async {
    // await storage.ready;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in loadSelectedHabitsFromStorage function *********');
    var storedSelectedHabits = storage.getItem('flutter.selectedHabits');
    if (storedSelectedHabits != null) {
      /* print('IN THE PROVIDER AND THE SELECTEHABITS ARE NOT NULL');
      print('length of storedSelectedHabits is: ');
      print(storedSelectedHabits.length);
      print(storedSelectedHabits.runtimeType);
      
      print(storedSelectedHabits);
      print('now in a list');
      print(userMap); */
      final List<dynamic> userMap = jsonDecode(storedSelectedHabits);
      _selectedhabits = List<SelectedHabits>.from(
        //(storedSelectedHabits as List).map(
        userMap.map((item) => SelectedHabits.fromJson(item)),
      );
      /* print('length of _selectedhabits is ');
      print(_selectedhabits.length);
      for (var element in _selectedhabits) {
        print(element.habit);
        print(element.color);
      } */
    } else {
      storedSelectedHabits = prefs.getString('selectedHabits');
      if (storedSelectedHabits != null) {
        print(
          'IN THE PROVIDER AND THE SELECTEHABITS IS NOT SECOND CHECK NULL ****************',
        );
      } else // _saveEmptyEntryToStorage();
      {
        //notifyListeners();
        print(
          'IN THE PROVIDER AND THE SELECTEHABITS IS NULL  after second check ****************',
        );
      }
    }
  }

  void loadCompletedHabitsFromStorage() async {
    // await storage.ready;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('in loadCompletedHabitsFromStorage function *********');
    var storedCompletedHabits = storage.getItem('flutter.completedHabits');
    if (storedCompletedHabits != null) {
      /* print('IN THE PROVIDER AND THE COMPLETEDHABITS ARE NOT NULL');
      print('length of storedCompletedHabits is: ');
      print(storedCompletedHabits.length);
      print(storedCompletedHabits.runtimeType);
      
      print(storedCompletedHabits);
      print('now in a list');
      print(userMap); */
      final List<dynamic> userMaps = jsonDecode(storedCompletedHabits);
      _completedhabits = List<CompletedHabits>.from(
        //(storedCompletedHabits as List).map(
        userMaps.map((item) => CompletedHabits.fromJson(item)),
      );
      /* print('length of _completedHabits is ');
      print(_completedHabits.length);
      for (var element in _completedHabits) {
        print(element.habit);
        print(element.color);
      } */
    } else {
      storedCompletedHabits = prefs.getString('completedHabits');
      if (storedCompletedHabits != null) {
        print(
          'IN THE PROVIDER AND THE COMPLETEDHABITS IS NOT SECOND CHECK NULL ****************',
        );
      } else // _saveEmptyEntryToStorage();
      {
        //notifyListeners();
        print(
          'IN THE PROVIDER AND THE COMPLETEDHABITS IS NULL  after second check ****************',
        );
      }
    }
  }
  /* void loadCompletedHabitsFromStorage() async {
    // await storage.ready;
    print('in loadCompletedHabitsFromStorage function *********');
    var storedCompletedHabits = storage.getItem('flutter.completedHabits');
    if (storedCompletedHabits != null) {
      _completedhabits = List<CompletedHabits>.from(
        (storedCompletedHabits as List).map(
          (item) => CompletedHabits.fromJson(item),
        ),
      );
    } else {
      // _saveEmptyEntryToStorage();
    }
  } */

  // Add a selected habit
  void addSelectedHabit(SelectedHabits habit) {
    _selectedhabits.add(habit);
    _saveSelectedhabitsToStorage();
    notifyListeners();
  }

  // Add a completed habit
  void addCompletedHabit(CompletedHabits habit) {
    _completedhabits.add(habit);
    _saveCompletedhabitsToStorage();
    notifyListeners();
  }

  // Save to storage
  void _saveSelectedhabitsToStorage() async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('selectedHabits', jsonEncode(_selectedhabits));

    storage.setItem(
      'flutter.selectedHabits',
      jsonEncode(_selectedhabits.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  void _saveCompletedhabitsToStorage() async {
    //  SharedPreferences prefs = await SharedPreferences.getInstance();
    //  await prefs.setString('completedHabits', jsonEncode(_completedhabits));
    storage.setItem(
      'flutter.completedHabits',
      jsonEncode(_completedhabits.map((e) => e.toJson()).toList()),
      //jsonEncode(_completedhabits.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  // Delete a completed habit
  void deleteCompletedHabit(String habit) {
    _completedhabits.removeWhere(
      (completedHabits) => completedHabits.habit == habit,
    );
    _saveCompletedhabitsToStorage(); // Save the updated list to local storage
    notifyListeners();
  }

  // Delete a selected habit
  void deleteSelectedHabit(String habit) {
    _selectedhabits.removeWhere(
      (selectedHabits) => selectedHabits.habit == habit,
    );
    _saveSelectedhabitsToStorage(); // Save the updated list to local storage
    notifyListeners();
  }
}
