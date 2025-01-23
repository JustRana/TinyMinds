import 'package:flutter/material.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:tiny_minds/pages/animals_page.dart';
import 'package:tiny_minds/pages/colors_page.dart';
import 'package:tiny_minds/pages/game_page.dart';
import 'package:tiny_minds/pages/letters_page.dart';
import 'package:tiny_minds/pages/numbers_page.dart';
import 'package:tiny_minds/pages/settings_page.dart';
import 'package:tiny_minds/pages/shapes_page.dart';

class LearnPage extends StatefulWidget {
  @override
  _LearnPageState createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    LearnGridPage(),
    GamePage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationX(3.14159),
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Colors.blue, Colors.blue.shade200],
                      [Colors.blue.shade200, Colors.blue.shade100],
                    ],
                    durations: [35000, 19440],
                    heightPercentages: [0.10, 0.15], 
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  size: Size(double.infinity, 100),
                ),
              ),
            ],
          ),
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.games),
            label: 'Game',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class LearnGridPage extends StatelessWidget {
  final List<Color> _boxColors = [
    Color.fromARGB(255, 186, 146, 255),
    Colors.blueAccent,
    Colors.greenAccent,
    Colors.orangeAccent,
    const Color.fromARGB(255, 234, 115, 255),
  ];

  final List<String> _descriptions = [
    'Learn the ABCs.',
    'Learn Numbers.',
    'Learn about Animals.',
    'Learn about Shapes.',
    'Learn about Colors.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 248, 248),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LettersPage('ABC')));
                    break;
                  case 1:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NumbersPage('123')));
                    break;
                  case 2:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AnimalsPage('Animals')));
                    break;
                  case 3:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ShapesPage('Shapes')));
                    break;
                  case 4:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ColorsPage('Colors')));
                    break;
                }
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                height: 150, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: _boxColors[index],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/images/${_getImageName(index)}', height: 120),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
_getTitle(index),
style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _descriptions[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case 0:
        return 'ABC';
      case 1:
        return '123';
      case 2:
        return 'Animals';
      case 3:
        return 'Shapes';
      case 4:
        return 'Colors';
      default:
        return '';
    }
  }

  String _getImageName(int index) {
    switch (index) {
      case 0:
        return 'ABCEmpty.png';
      case 1:
        return '123Empty.png';
      case 2:
        return 'AnimalsEmpty.png';
      case 3:
        return 'ShapesEmpty.png';
      case 4:
        return 'ColorsEmpty.png';
      default:
        return '';
    }
  }
}
