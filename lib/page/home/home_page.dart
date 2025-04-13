import 'package:flutter/material.dart';
import 'package:sportition_client/page/home/boards/board_page.dart';
import 'package:sportition_client/page/home/records/record_page.dart';
import 'package:sportition_client/page/home/users/user_page.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';
import 'package:sportition_client/services/user/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String? _userUID;

  @override
  void initState() {
    super.initState();
    _fetchUserUID();
  }

  Future<void> _fetchUserUID() async {
    String userUID = await UserService().getUserUID();
    setState(() {
      _userUID = userUID;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          if (_userUID != null) BoardPage(userUID: _userUID!),
          if (_userUID != null) RecordPage(userUID: _userUID!),
          if (_userUID != null) UserPage(userUID: _userUID!),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.leaderboard,
              size: _selectedIndex == 0 ? 32.0 : 25.0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center,
              size: _selectedIndex == 1 ? 32.0 : 25.0,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: _selectedIndex == 2 ? 32.0 : 25.0,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.mainRedColor,
        unselectedItemColor: const Color(0x30000000),
        onTap: _onItemTapped,
        selectedFontSize: 0,
      ),
    );
  }
}
