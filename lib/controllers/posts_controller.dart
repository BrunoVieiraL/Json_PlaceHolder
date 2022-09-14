import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nv1/models/posts_model.dart';

import 'package:http/http.dart' as http;

class PostController{
  ValueNotifier<List<PostModel>> posts = ValueNotifier<List<PostModel>>([]);
  ValueNotifier<bool> inLoader = ValueNotifier<bool>(false);

  callApi() async {
    var client = http.Client();
    try {
      inLoader.value = true;
      var response = await http.get(
        Uri.parse(
          'https://jsonplaceholder.typicode.com/posts',
        ),
      );
      var decodeResponse = jsonDecode(response.body) as List;
      posts.value = decodeResponse.map((e) => PostModel.fromJson(e)).toList();
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      client.close();
      inLoader.value = false;
    }
  }
}