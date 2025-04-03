import 'package:flutter/material.dart';

Widget helpCenterForm(BuildContext context) {
  return Scaffold(
      body: Column(
    children: [
      Text("Comment pouvons-nous vous aider ?"),
      TextField(
        decoration: InputDecoration(
          hintText: 'Search...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
      ),
    ],
  ));
}
