import 'package:flutter/material.dart';
import 'package:habits/Pages/Choose_Habit.dart';
import 'package:habits/components/Add_button.dart';
import 'package:habits/components/Monthly_Summary.dart';
import 'package:habits/components/NewHabit.dart';
import 'package:habits/components/habit_tile.dart';
import 'package:habits/data/Habit_database.dart';
import 'package:hive/hive.dart';
import 'package:habits/Themes/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isDarkMode = false;
  ThemeData currentTheme = lightTheme;
  HabitDatabase db = HabitDatabase();
  final _mybox = Hive.box("Habit_Database");

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      //do nothing
    } else if (_selectedIndex == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AppChoice()),
      );
    }
    print(index);
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      if (isDarkMode) {
        currentTheme = darkTheme;
      } else {
        currentTheme = lightTheme;
      }
    });
  }

  @override
  void initState() {
    //first time app
    if (_mybox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefault();
    } else {
      db.loadData();
    }
    db.updateDatabase();
    super.initState();
  }

  // bool habitCompleted = false;
  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
      // habitCompleted = value!;
    });

    db.updateDatabase();
  }

  final _newHabitController = TextEditingController();
  void createNewHabit() {
    // Show a new dialog box
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabit(
          controller: _newHabitController,
          hintText: "Enter Habit",
          onSave: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitController.text, false]);
    });
    _newHabitController.clear();

    Navigator.of(context).pop();

    db.updateDatabase();
  }

  void cancelNewHabit() {
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return EnterNewHabit(
              controller: _newHabitController,
              hintText: db.todaysHabitList[index][0],
              onSave: () => saveExistingHabbit(index),
              onCancel: cancelDialogBox);
        });
  }

  void saveExistingHabbit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void cancelDialogBox() {
    Navigator.of(context).pop();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }
  //  Newly added

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: currentTheme,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Color.fromARGB(255, 244, 244, 244),
        backgroundColor: currentTheme.scaffoldBackgroundColor,
        floatingActionButton: MyfloatingActionButton(onPressed: createNewHabit),
        appBar: AppBar(
          backgroundColor: currentTheme.appBarTheme.backgroundColor,
          foregroundColor: currentTheme.appBarTheme.foregroundColor,
          title: const Text('Habit TracK'),
          actions: [
            IconButton(
              icon: const Icon(Icons.lightbulb_outline),
              onPressed: toggleTheme,
            ),
          ],
        ),
        body: ListView(
          children: [
            // monthly summary heat map
            MonthlySummary(
              datasets: db.heatMapDataSet,
              startDate: _mybox.get("START_DATE"),
            ),

            // list of habits
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: db.todaysHabitList.length,
              itemBuilder: (context, index) {
                return HabitTile(
                  habitName: db.todaysHabitList[index][0],
                  habitCompleted: db.todaysHabitList[index][1],
                  onChanged: (value) => checkBoxTapped(value, index),
                  settingsTapped: (context) => openHabitSettings(index),
                  deleteTapped: (context) => deleteHabit(index),
                );
              },
            )
          ],
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          child: BottomNavigationBar(
            elevation: 20,
            backgroundColor: currentTheme.colorScheme.background,
            selectedItemColor: currentTheme.colorScheme.surface,
            unselectedItemColor: const Color.fromARGB(255, 167, 167, 167),
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.check),
                label: 'Habit Checker',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
