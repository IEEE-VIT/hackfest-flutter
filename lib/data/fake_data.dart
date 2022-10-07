import 'package:flutter/cupertino.dart';
import 'package:github_flutter/models/github_repo_model.dart';

class FakeData {
  static List<GithubRepoModel> get data => List.generate(
        10,
        (i) => GithubRepoModel(
          avatarUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/640px-Image_created_with_a_mobile_phone.png',
          owner: 'SushanShakya',
          name: 'Hello World',
          description: 'None',
          url: '',
        ),
      );
}
