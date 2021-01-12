import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_services/screens/tabs/tab_home.dart';
import 'package:student_services/screens/tabs/tab_explore.dart';
import 'package:student_services/screens/tabs/tab_profile.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/my_text.dart';
import 'package:student_services/widgets/drawer.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key key, this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: MyText(
          text: 'Student Service',
          color: Colors.white,
          weight: FontWeight.w500,
          size: 18,
        ),
        centerTitle: false,
        backgroundColor: mainColor,
        bottom: TabBar(
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: 'Home',
            ),
            Tab(
              text: 'Explore',
            ),
            Tab(
              text: 'Profile',
            ),
          ],
          controller: _tabController,
        ),
        actions: [
          //TODO
        ],
      ),
      drawer: MyDrawer(),
      body: TabBarView(
        children: [
          HomeTab(),
          ExploreTab(),
          ProfileTab(),
        ],
        controller: _tabController,
      ),
    );
  }
}
