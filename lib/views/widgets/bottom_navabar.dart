// import 'package:flutter/material.dart';
// import 'package:netflix_app/views/screens/home_screen.dart';
// import 'package:netflix_app/views/screens/more_screen.dart';
// import 'package:netflix_app/views/screens/search_screen.dart';

// class BottomNavabar extends StatelessWidget {
//   const BottomNavabar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(length: 3, 
//     child: Scaffold(
//       bottomNavigationBar: Container(
//       color:Colors.black,
//       height:70,
//       child: const TabBar(tabs: [
//         Tab(
//           icon: Icon(Icons.home),
//           text: "Home",
//         ),
//          Tab(
//           icon: Icon(Icons.search),
//           text: "Search",
//         ),
//          Tab(
//           icon: Icon(Icons.photo_library_outlined),
//           text: "New & Hot",
//         ),
//       ],
//       indicatorColor: Colors.transparent,
//       labelColor: Colors.white,
//       unselectedLabelColor: Color.fromARGB(255, 207, 194, 194),
//       ),

//     ),
//     body:const TabBarView(children: [
//       HomeScreen(),
//       SearchScreen(series: snapshot.data,),
//       MoreScreen()
//     ])
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:netflix_app/controllers.dart/api_services.dart';
import 'package:netflix_app/views/screens/home_screen.dart';
import 'package:netflix_app/views/screens/more_screen.dart';
import 'package:netflix_app/views/screens/search_screen.dart';

class BottomNavabar extends StatelessWidget {
  const BottomNavabar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.photo_library_outlined),
                text: "New & Hot",
              ),
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Color.fromARGB(255, 207, 194, 194),
          ),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: TMDBService().fetchMovies(), 
          builder: (context, snapshot) {
          
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

       
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

       
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("No data available"));
            }

        
            List<dynamic> series = snapshot.data!;

           
            return TabBarView(
              children: [
                const HomeScreen(),  
                SearchScreen(), 
                const MoreScreen(),
              ],
            );
          },
        ),
      ),
    );
  }
}
