import 'package:flutter/material.dart';
import 'package:page_view_indicator/page_view_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_services/screens/signin.dart';
import 'package:student_services/models/welcom_page_model.dart';
import 'package:student_services/utility/constans.dart';
import 'package:student_services/widgets/custom_text.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<PageModel> pages;

  ValueNotifier<int> _pageViewNotifier = ValueNotifier(0);

  void _addPages() {
    pages = List<PageModel>();
    pages.add(PageModel(
        'Welcome!',
        Icons.ac_unit,
        'Making friends is easy as waving your hand back and forth in easy step',
        'assets/images/onboarding1.png'));
    pages.add(PageModel(
        'Alarm',
        Icons.access_alarm,
        'Making friends is easy as waving your hand back and forth in easy step',
        'assets/images/onboarding2.png'));
    pages.add(PageModel(
        'Print',
        Icons.print,
        'Making friends is easy as waving your hand back and forth in easy step',
        'assets/images/onboarding3.png'));
    pages.add(PageModel(
        'Map',
        Icons.map,
        'Making friends is easy as waving your hand back and forth in easy step',
        'assets/images/onboarding4.png'));
  }

  @override
  Widget build(BuildContext context) {
    var fullHeight = MediaQuery.of(context).size.height;
    _addPages();

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(pages[index].image),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      // Text(
                      //   pages[index].title,
                      //   style: TextStyle(
                      //     color: mainColor,
                      //     fontSize: 28,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      //   textAlign: TextAlign.center,
                      // ),
                      MyText(
                        text: pages[index].title,
                        color: mainColor,
                        size: 28,
                        weight: FontWeight.bold,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 48,
                          right: 48,
                          top: 18,
                        ),
                        child: MyText(
                          text: pages[index].description,
                          color: mainColor,
                        ),

                        // Text(
                        //   pages[index].description,
                        //   style: TextStyle(
                        //     fontSize: 16,
                        //     color: mainColor,
                        //   ),
                        //   textAlign: TextAlign.center,
                        // ),
                      ),
                    ],
                  ),
                ],
              );
            },
            itemCount: pages.length,
            onPageChanged: (index) {
              _pageViewNotifier.value = index;
            },
          ),
          Center(
            child: Transform.translate(
                offset: Offset(0, fullHeight * 0.33),
                child: _displayPageIndicator(pages.length)),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 24,
                left: 16,
                right: 16,
              ),
              child: SizedBox(
                height: 50,
                width: double.infinity,
                child: RaisedButton(
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          updateSeen();
                          return SignIn();
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _displayPageIndicator(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pageViewNotifier,
      length: length,
      indicatorPadding: EdgeInsets.all(4),
      normalBuilder: (animationController, index) => Circle(
        size: 6.0,
        color: Color(0xFFD6EEE2),
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 10.0,
          color: mainColor,
        ),
      ),
    );
  }

  void updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}
