import 'package:flutter/material.dart';

class Category {
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange, //제공 안되면 이렇게 기본 색깔로 가져감
  });

  final String id;
  final String title;
  final Color color;
}
