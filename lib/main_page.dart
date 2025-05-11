import 'package:bharatnxt/screens/home_screen.dart';
import 'package:bharatnxt/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  var currentIndex = 0;


  final List<Widget>  _pages = [

    HomeScreen(),
    WishList()

  ];



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("BharatNxt"),
         automaticallyImplyLeading: false,
      ),
      body: _pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.amber,

        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: "Wishlist"),
        ]
        ),
    );
  }
}