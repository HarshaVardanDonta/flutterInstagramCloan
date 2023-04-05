import 'dart:io';

import 'package:flutter/material.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String? image;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.image,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        image: json['image']);
  }

  String toJson() {
    return '{'
        '"id": "$id",'
        '"name": "$name",'
        '"email": "$email",'
        '"image": "$image"'
        '}';
  }
}
