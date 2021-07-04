import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_dot_indicator/flutter_dot_indicator.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // starting index of page
  int selectedIndex = 0;
  //no. of dots
  List listDot = ['1', '2', '3', '4'];

  //switch dots duration
  static const _kDuration = const Duration(milliseconds: 300);

  //transition btw dots
  static const _kCurve = Curves.bounceIn;

  //a page controller for image page view
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: 450,
                child: PageView.builder( //pageVIew builder
                  controller: _pageController,
                  physics: BouncingScrollPhysics(),
                  allowImplicitScrolling: true,
                  onPageChanged: (int page) { //while page swiping index change
                    setState(() {
                      selectedIndex = page;
                    });
                  },
                  itemCount: img.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder: AssetImage('assets/exercise1.jpg'),
                          image: AssetImage(img[index]['image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
              //below code for dot indicator
              Container(
                padding: const EdgeInsets.all(10.0),
                child: new Center(
                  child: new DotsIndicator(
                    color: Colors.black,
                    materialType: MaterialType.button,
                    controller: _pageController,
                    itemCount: listDot.length,
                    onPageSelected: (int page) {
                      _pageController.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//i have made a list of that four images
List<dynamic> img = [
  {'image': 'assets/exercise1.jpg'},
  {'image': 'assets/exercise2.jpg'},
  {'image': 'assets/exercise3.jpg'},
  {'image': 'assets/exercise4.jpg'},
];
