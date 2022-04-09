import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab=1;



  void onSelectedTab(int index){
    if(_selectedTab==index){
      return;
    }
    setState(() {
      _selectedTab=index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NEWS'),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          Text('News'),
          Text('Favorites'),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(
              Icons.fiber_new_sharp
          ),
              label: 'News'),
          BottomNavigationBarItem(icon: Icon(
              Icons.favorite
          ),
              label: 'Favorites'
          ),

        ],
        onTap: onSelectedTab,
      ),
    );
}}
