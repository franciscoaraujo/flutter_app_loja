import 'package:app_loja/screens/category_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(snapshot.data['icon']),
        ),
        title: Text(snapshot.data['title']),
        trailing: Icon(Icons.keyboard_arrow_right),
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CategoryScreen(this.snapshot)));
        },
      ),
    );
  }
}
