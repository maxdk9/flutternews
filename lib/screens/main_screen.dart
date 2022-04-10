import 'package:flutter/material.dart';
import 'package:flutternews/widgets/article_list_widget.dart';
import 'package:flutternews/widgets/favorites_list_widget.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab=0;



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
          ArticleListWidget(),
          FavoritesListWidget(),
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
