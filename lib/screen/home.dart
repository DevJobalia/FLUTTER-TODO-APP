// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:untitled/const/colors.dart';
// import 'package:untitled/data/firestore.dart';
// import 'package:untitled/screen/add_note.dart';
// import 'package:untitled/widgets/stream_note.dart';
// import 'package:percent_indicator/percent_indicator.dart';
//
//
// class Home_Screen extends StatefulWidget {
//   const Home_Screen({Key? key}) : super(key: key);
//
//   @override
//   State<Home_Screen> createState() => _Home_ScreenState();
// }
//
// class _Home_ScreenState extends State<Home_Screen> {
//   int doneCount = 0;
//   int notDoneCount = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColors,
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).push(MaterialPageRoute(
//             builder: (context) => Add_Screen(),
//           ));
//         },
//         backgroundColor: custom_green,
//         child: Icon(Icons.add, size: 30),
//       ),
//       body: SafeArea(
//         child: NotificationListener<UserScrollNotification>(
//           onNotification: (notification) {
//             if (notification.direction == ScrollDirection.forward) {
//               setState(() {
//                 // Set show to true
//               });
//             }
//             if (notification.direction == ScrollDirection.reverse) {
//               setState(() {
//                 // Set show to false
//               });
//             }
//             return true;
//           },
//           child: Column(
//             children: [
//               StreamBuilder<int>(
//                 stream: Firestore_Datasource().getNoteStreamLength(isDone: true), // Pass your stream here
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     doneCount = snapshot.data!;
//                   }
//                   return Text(
//                     'Done Count: $doneCount',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade500,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 },
//               ),
//               StreamBuilder<int>(
//                 stream: Firestore_Datasource().getNoteStreamLength(isDone: false), // Pass your stream here
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     notDoneCount = snapshot.data!;
//                   }
//                   return Text(
//                     'Not Done Count: $notDoneCount',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade500,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   );
//                 },
//               ),
//               Expanded(
//                 child: ListView(
//                   children: [
//                     LinearPercentIndicator(
//                       animation: true,
//                       animationDuration: 10000,
//                       lineHeight: 40,
//                       percent: doneCount / (doneCount + notDoneCount),
//                       progressColor: Colors.deepPurple,
//                       backgroundColor: Colors.deepPurple.shade200,
//                     ),
//                     Stream_note(false),
//                     Text(
//                       'isDone',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade500,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Stream_note(true),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/const/colors.dart';
import 'package:untitled/data/firestore.dart';
import 'package:untitled/screen/add_note.dart';
import 'package:untitled/widgets/stream_note.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Add_Screen(),
          ));
        },
        backgroundColor: custom_green,
        child: Icon(Icons.add, size: 30),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              // Handle scroll direction forward
            }
            if (notification.direction == ScrollDirection.reverse) {
              // Handle scroll direction reverse
            }
            return true;
          },
          child: Column(
            children: [
              Container(
              width: double.infinity,
              child: Image.asset("images/Logo.png",width: 100, // Set the width to resize the image horizontally
                  height: 80, // Set the height to resize the image vertically
                  fit: BoxFit.contain),
            // This could be any widget or component you want to display on top of the purple background
          ),

              StreamBuilder<int>(
                stream: Firestore_Datasource().getNoteStreamLength(isDone: true),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final doneCount = snapshot.data!;
                  return Text(
                    'Done Count: $doneCount',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade200,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              StreamBuilder<int>(
                stream: Firestore_Datasource().getNoteStreamLength(isDone: false),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  final notDoneCount = snapshot.data!;
                  return Text(
                    'Not Done Count: $notDoneCount',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade200,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              Expanded(
                child: StreamBuilder<double>(
                  stream: Firestore_Datasource().getProgressStream(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    final progress = snapshot.data!;
                    return ListView(
                      children: [
                        LinearPercentIndicator(
                          animation: true,
                          animationDuration: 1000,
                          // width: 140.0,
                          lineHeight: 30.0,

                          // center: Text(
                          //   "${progress.toInt() * 100}%",
                          //   style: new TextStyle(fontSize: 20.0, color: Colors.white,),
                          // ),
                          // trailing: Icon(Icons.mood),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          percent: progress,
                          progressColor: Colors.deepPurple,
                          backgroundColor: Colors.deepPurple.shade100,
                        ),
                        Stream_note(false),
                        Text(
                          'Is Done',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade200,
                            fontWeight: FontWeight.bold,

                          ),
                          textAlign: TextAlign.center,
                        ),
                        Stream_note(true),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
