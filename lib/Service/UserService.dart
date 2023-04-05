import 'dart:convert';
import 'dart:io';

import 'package:app001/models/User.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<User> getUser({
    required String id,
  }) async {
    var response = await http
        .get(Uri.parse('http://192.168.29.241:8080/user/find/$id'))
        .timeout(
      Duration(seconds: 5),
      onTimeout: () {
        throw Exception('Failed to load user');
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load user');
    }
  }

  static registerUser({
    required String name,
    required String email,
  }) {
    var body = {
      'name': name,
      'email': email,
    };
    var response = http.post(
        Uri.parse(
          'http://192.168.29.241:8080/user/add',
        ),
        body: body);
    print('add user res is ${response.toString()}');
  }

  static Future<bool> updateUser({
    required int id,
    required File image,
    required String name,
    required String email,
  }) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://192.168.29.241:8080/user/updateUser/$id'));
    request.fields.addEntries({
      MapEntry('name', name),
      MapEntry('email', email),
    });
    request.files.add(
      http.MultipartFile(
        'image',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
      ),
    );
    var response = await request.send();
    print('update user res is ${response.statusCode}');

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<User>> getAllUsers() async {
    var response =
        await http.get(Uri.parse('http://192.168.29.241:8080/user/all'));

    if (response.statusCode == 200) {
      List<User> users = [];
      var data = json.decode(response.body);
      for (var user in data) {
        users.add(User.fromJson(user));
      }
      print(users);
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
