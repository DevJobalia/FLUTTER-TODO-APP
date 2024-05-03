import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/widgets/task-widgets.dart';

import '../data/firestore.dart';

class Stream_note extends StatelessWidget {
  bool isDone;
  Stream_note(this.isDone, {super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream:  Firestore_Datasource().stream(isDone),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          final noteslist = Firestore_Datasource().getNotes(snapshot);
          return ListView.builder(shrinkWrap: true, itemBuilder: (context, index) {
            final note = noteslist[index];
            return Dismissible(key: UniqueKey(), onDismissed: (direction){
              Firestore_Datasource().delet_note(note.id);
            }, child: Task_Widget(note));
          },
            // return Task_Widget();

            itemCount: noteslist.length,
          );
        });
  }
}