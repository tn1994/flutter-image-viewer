import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:src/models/model_user.dart';
import 'package:src/models/model_category.dart';

String baseUri = 'http://192.168.1.100:8000';

class UserProviders {
  //ref: https://github.com/vidal1101/Flutter-FastApi/blob/main/userapp/lib/src/providers/providers_user.dart

  String urlApi = '$baseUri/categories';

  // Future<List<UserModel>> getUser() async {
  Future<List<Welcome>> getUser() async {
    /*final url = Uri.https(urlApi , "user/fetchall-usuarios");
    final resp = await http.get(url);*/
    http.Response resp = await http.get(Uri.parse(urlApi));
    debugPrint("status Code");
    debugPrint(resp.body);

    // return [UserModel.fromJsontoMap(jsonDecode(resp.body))];
    return [Welcome.fromJson(jsonDecode(resp.body))];
  }
}

// To parse this JSON data, do
// final welcome = welcomeFromJson(jsonString);

List<String> welcomeFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String welcomeToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

class ImageProviders {
  //ref: https://github.com/vidal1101/Flutter-FastApi/blob/main/userapp/lib/src/providers/providers_user.dart

  // twice
  // String boardId = '331648028748761641';
  // ocha norma
  String boardId = '837599299386886525';

  Future<List> getImages() async {
    String urlApi = 'http://localhost:8080/get/board/$boardId';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    http.Response resp = await http.get(Uri.parse(urlApi), headers: headers);
    final welcome = welcomeFromJson(resp.body);

    // todo: debug code
    // List<String> resp = [
    //   "https://i.pinimg.com/originals/5a/c5/22/5ac52225deadbb6594af21bd7d243127.jpg",
    //   "https://i.pinimg.com/originals/a4/0f/74/a40f74bce9c84a7fde3848723dd8ccbd.jpg",
    //   "https://i.pinimg.com/originals/64/3f/f2/643ff2103639ac53c5c8debb5b8e77fe.jpg"
    // ];
    // final welcome = resp;
    debugPrint('welcome:');
    debugPrint(welcome.toString());

    return welcome;
  }
}
