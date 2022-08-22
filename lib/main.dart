import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/create_qr.dart';
import 'package:scanner/scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int i = 0;
  PageController? _pageController;
  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: PageView(
        controller: _pageController,
        children: const [
          Scanner(),
          Create_qr(),
        ],
        onPageChanged: (int index) {
          setState((){
            i = index;
          });
        },
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor:Colors.black12,
        currentIndex: i,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_scanner,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code,
            ),
          ),
        ],
        onTap: (int index) {
          setState(() {
            i = index;
            _pageController!.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeIn);
          });
        },
      ),
    );
  }
}
