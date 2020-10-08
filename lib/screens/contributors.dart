import 'package:flutter/material.dart';
import 'package:github_flutter/models/contributor_detail_model.dart';
import 'package:github_flutter/models/contributors_data_model.dart';
import 'package:github_flutter/screens/widgets/contributor_list_item.dart';
import 'package:http/http.dart' as http;
import 'package:github_flutter/models/contributors_card_model.dart';

class Contributors extends StatefulWidget {
  static final String routename = '/Contributors';

  @override
  _ContributorsState createState() => _ContributorsState();
}

class _ContributorsState extends State<Contributors>
    with AutomaticKeepAliveClientMixin {
  List<ContributorCard> cardList = [];
  @override
  void initState() {
    super.initState();
    getContributors(username: 'IEEE-VIT', repository: 'hacktoberfest-flutter')
        .then((cards) {
      setState(() {
        cardList = cards;
      });
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    // Used device height and width to make responsive layout
    final _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 5.0,
        shadowColor: Colors.black26,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contributors List',
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(50)),
              child: Text(
                cardList.length.toString(),
                style: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
      body: cardList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              // Get the List of contributors to the project from the GitHub Api
              // Append the details of the card to the cardList
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cardList.length,
              itemBuilder: (ctx, index) {
                return ContributorListItem(cardList[index]);
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
        onPressed: addToContributors,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Future<List<ContributorCard>> getContributors(
    {@required String username, @required String repository}) async {
  const String head = 'https://api.github.com/repos/';
  const String tail = '/contributors';
  String url = head + username + '/' + repository + tail;
  http.Response response = await http.get(url);
  List<Contributor> contributors = contributorFromJson(response.body);
  List<ContributorCard> contriCards = [];
  for (final contributor in contributors) {
    http.Response contributorResponse =
        await http.get('https://api.github.com/users/' + contributor.login);
    ContributorDetail contributorDetail =
        contributorDetailFromJson(contributorResponse.body);
    contriCards.add(
      ContributorCard(
        userName: contributor.login,
        name: contributorDetail.name ?? '',
        desc: contributorDetail.bio ?? '',
        location: contributorDetail.location ?? '',
        twitterUsername: contributorDetail.twitterUsername ?? '',
        displayImgUrl: contributorDetail.avatarUrl,
        website: contributorDetail.blog.isEmpty
            ? contributorDetail.htmlUrl
            : contributorDetail.blog,
      ),
    );
  }

  return contriCards;
}

addToContributors() {
  // TODO: Trigger an alert box or something similar
  // Ask the user to enter the details
  // Adds the user to contributors list
}
