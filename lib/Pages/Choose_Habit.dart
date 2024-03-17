import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habits/Pages/HomePage.dart';
import 'package:habits/Pages/WeatherPage.dart';
import 'package:habits/Themes/theme.dart';
import 'package:lottie/lottie.dart';

class AppChoice extends StatefulWidget {
  const AppChoice({Key? key});

  @override
  State<AppChoice> createState() => _AppChoiceState();
}

class _AppChoiceState extends State<AppChoice> {
  int _selectedIndex = 1;

  bool isDarkMode = false;

  ThemeData currentTheme = lightTheme;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      //do nothing
    } else if (_selectedIndex == 1) {
      // Do nothing
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: currentTheme.appBarTheme.backgroundColor,
        foregroundColor: currentTheme.appBarTheme.foregroundColor,
        title: const Text('HabTrack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.lightbulb_outline),
            onPressed: toggleTheme,
            // onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              // padding:const EdgeInsets.bottom(value)
              child: SizedBox(
                height: 250,
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _buildCard(context, 'Outdoor Exercise',
                            'assets/Exercise.json', currentTheme, 'Location2'),
                      ),
                      Expanded(
                        child: _buildCard(context, 'Indoor Exercise',
                            'assets/Home.json', currentTheme, 'Location1'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 250,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _buildCard(context, 'Water Exercises',
                          'assets/Swimming.json', currentTheme, 'Location3'),
                    ),
                    Expanded(
                      child: _buildCard(context, 'Calming Excercises',
                          'assets/meditation.json', currentTheme, 'Location4'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
    );
  }

  Widget _buildCard(BuildContext context, String name, String location,
      ThemeData theme, String locationName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WeatherPage(name: name),
          ),
        );
      },
      child: Card(
        color: theme.cardColor,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Add your Lottie asset here
                  Lottie.asset(location),
                  Spacer(), // Add a Spacer to push the text to the bottom
                ],
              ),
            ),
            // Add the name and boundary at the bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(name,
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic)),
            ),
          ],
        ),
      ),
    );
  }
}
