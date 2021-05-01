import 'package:flutter/material.dart';

import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String id = "onBoarding_screen";

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final int _numPages = 3;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(fontFamily: 'SFDisplay'),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            PageView(
              physics: ClampingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0, 125),
                      child: Image(
                        image: AssetImage(
                          'assets/images/taking_notes.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Transform.translate(
                        offset: Offset(0, 75),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Text(
                              "Taking Notes",
                              style: TextStyle(
                                color: Color(0xff240046),
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Organize your day by creating notes",
                              style: TextStyle(
                                color: Color(0xff5A189A),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0, 125),
                      child: Image(
                        image: AssetImage(
                          'assets/images/add_notes.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Transform.translate(
                        offset: Offset(0, 75),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Text(
                              "Add Notes",
                              style: TextStyle(
                                color: Color(0xff240046),
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Add your notes to the notes list easily",
                              style: TextStyle(
                                color: Color(0xff5A189A),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Transform.translate(
                      offset: Offset(0, 125),
                      child: Image(
                        image: AssetImage(
                          'assets/images/notes_list.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Transform.translate(
                        offset: Offset(0, 75),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,
                            ),
                            Text(
                              "Notes list",
                              style: TextStyle(
                                color: Color(0xff240046),
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Browse your notes at any time",
                              style: TextStyle(
                                color: Color(0xff5A189A),
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            (_currentPage != _numPages - 1)
                ? Positioned(
                    top: 80,
                    right: 20,
                    left: 0,
                    bottom: 0,
                    child: Container(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          //updateSeen();
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.id);
                        },
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            color: Color(0xff7B2CBF),
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  )
                : Text(""),
            Positioned(
              bottom: 150,
              left: 125,
              right: 125,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
              ),
            ),
            (_currentPage == _numPages - 1)
                ? Positioned(
                    bottom: 45,
                    left: 75,
                    right: 75,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              Color(0xff7B2CBF),
                            ),
                          ),
                          child: Text(
                            "Start",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              letterSpacing: 1,
                            ),
                          ),
                          onPressed: () {
                            //updateSeen();
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.id);
                          },
                        ),
                      ),
                    ),
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff5A189A) : Colors.grey[500],
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  void updateSeen() async {}
}
