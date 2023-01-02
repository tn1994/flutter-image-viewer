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

  Future<List<String>> getCategoryList() async {
    String urlApi = 'http://iMac.local:8080/get/categories';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    http.Response resp = await http.get(Uri.parse(urlApi), headers: headers);
    return welcomeFromJson(resp.body);
  }

  Future<List<String>> getGroupList(String categoryName) async {
    String urlApi = 'http://iMac.local:8080/get/categories/$categoryName';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    http.Response resp = await http.get(Uri.parse(urlApi), headers: headers);
    debugPrint('urlApi');
    debugPrint(urlApi);
    debugPrint('resp');
    debugPrint(resp.body);
    return welcomeFromJson(utf8.decode(resp.bodyBytes));
  }

  Future<List<String>> getQueryList(
      String categoryName, String groupName) async {
    String urlApi =
        'http://iMac.local:8080/get/categories/$categoryName/group/$groupName';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    http.Response resp = await http.get(Uri.parse(urlApi), headers: headers);
    debugPrint('urlApi');
    debugPrint(urlApi);
    debugPrint('resp');
    debugPrint(resp.body);
    return welcomeFromJson(utf8.decode(resp.bodyBytes));
  }

  Future<List<String>> getBoaedIdList(String queryName) async {
    String urlApi = 'http://iMac.local:8080/search/board/$queryName';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    http.Response resp = await http.get(Uri.parse(urlApi), headers: headers);
    return welcomeFromJson(resp.body);
  }

  Future<List> getImages(String boardId) async {
    String urlApi = 'http://iMac.local:8080/get/board/$boardId';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    http.Response resp = await http.get(Uri.parse(urlApi), headers: headers);
    return welcomeFromJson(resp.body);
  }
}
