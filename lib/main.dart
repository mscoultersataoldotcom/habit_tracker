import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'login_screen.dart';
import 'package:provider/provider.dart';
import 'providers/habit_provider.dart';
import 'add_habit_screen.dart';
import 'register_screen.dart';
import 'dart:convert';
import './models/completedHabits.dart';
import './models/selectedHabits.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocalStorage();
  runApp(HabitTrackerApp(localStorage: localStorage));
}

class HabitTrackerApp extends StatelessWidget {
  final LocalStorage localStorage;

  const HabitTrackerApp({super.key, required this.localStorage});

  @override
  Widget build(BuildContext context) {
    //return MaterialApp(home: LoginScreen(), debugShowCheckedModeBanner: false);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HabitProvider(localStorage)),
      ],
      child: MaterialApp(
        title: 'Habitt',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(), // Main entry point, HomeScreen
          '/add_Habit': (context) =>
              AddHabitScreen(), // Route for adding habits
          '/register': (context) => RegisterScreen(), // Route for registration
        },
        // Removed 'home:' since 'initialRoute' is used to define the home route
      ),
    );
  }
}
