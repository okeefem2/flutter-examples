import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  // const means after creation these cannot be changed
  const Category({this.id, this.title, this.color = Colors.purple});
}
