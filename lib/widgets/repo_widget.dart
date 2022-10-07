import 'package:flutter/material.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:github_flutter/models/github_repo_model.dart';
import 'package:github_flutter/shared/colors.dart';

class RepoWidget extends StatelessWidget {
  final GithubRepoModel data;
  const RepoWidget({
    Key key,
    @required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return SlimyCard(
      color: hactoberViolet,
      topCardHeight: 150,
      bottomCardHeight: 250,
      borderRadius: 15,
      topCardWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                image: data.avatarUrl != null
                    ? DecorationImage(
                        image: NetworkImage(data.avatarUrl),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Owner',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),
                  Text(
                    data.owner,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomCardWidget: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Repo: ${data.name ?? ''}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                data.description ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              FlatButton.icon(
                color: Colors.deepPurple[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final url = data.url;
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                icon: Icon(
                  Icons.visibility,
                  color: Colors.white,
                ),
                label: Text(
                  'Click To Visit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
