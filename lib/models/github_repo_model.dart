import 'package:flutter/material.dart';

class GithubRepoModel {
  final String avatarUrl;
  final String owner;
  final String name;
  final String description;
  final String url;

  GithubRepoModel({
    @required this.avatarUrl,
    @required this.owner,
    @required this.name,
    @required this.description,
    @required this.url,
  });

  factory GithubRepoModel.fromResponse(dynamic res) {
    return GithubRepoModel(
      avatarUrl: res['owner']['avatar_url'],
      owner: res['owner']['login'],
      name: res['full_name'],
      description: res['description'],
      url: res['html_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "owner": {
        "avatar_url": avatarUrl,
        "login": owner,
      },
      "full_name": name,
      "description": description,
      "html_url": url,
    };
  }
}
