import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled/const/colors.dart';
import 'package:untitled/screen/add_note.dart';
import 'package:untitled/widgets/task-widgets.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

bool show = true;

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColors,
      floatingActionButton: Visibility(
        // VISIBLE BASED OF SCROLL POISTION
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Add_Note(),
            ));
          },
          backgroundColor: custom_green,
          child: Icon(Icons.add, size: 30),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Task_Widget();
            },
            itemCount: 10,
          ),
          //     child: Column(
          //       children: [
          //         Stream_note(false),
          //         Text(
          //           'isDone',
          //           style: TextStyle(
          //               fontSize: 16,
          //               color: Colors.grey.shade500,
          //               fontWeight: FontWeight.bold),
          //         ),
          //         Stream_note(true),
          //       ],
          //     ),
          //   ),
        ),
      ),
    );
  }
}
