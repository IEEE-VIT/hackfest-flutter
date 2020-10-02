//Screen to view the list of all the contributors of the project selected in home page

import 'package:flutter/material.dart';
import 'package:github_flutter/models/contributor_detail_model.dart';
import 'package:github_flutter/models/contributors_data_model.dart';
import 'package:http/http.dart' as http;
import '../models/contributors_card_model.dart';
import '../widgets/contributor_card.dart';
import 'package:slimy_card/slimy_card.dart';

class Contributors extends StatefulWidget {
  static final String routename = '/Contributors';

  @override
  _ContributorsState createState() => _ContributorsState();
}

class _ContributorsState extends State<Contributors>
    with AutomaticKeepAliveClientMixin {
  bool swap=true;
  List<ContributorCard> cardList = [];
  @override
  void initState() {
    super.initState();
    getContributors(username: 'IEEE-VIT', repository: 'hacktoberfest-flutter').then((cards) {
      setState(() {
        cardList = cards;
      });
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Center(child: Text('Contributors List'),
        ),  actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {  setState((){
                swap = !swap;
              });},
              child: Icon(
                Icons.change_history,
                size: 26.0,
              ),
            )
        ),

      ],
        backgroundColor: Colors.pinkAccent,
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
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: swap==true?ContCard(
                userName: cardList[index].userName,
                dispImg: cardList[index].displayImgUrl,
                desc: cardList[index].desc,
                webSite: cardList[index].website,
              ):
              SlimyCard(
                color: Color.fromRGBO(0, 105, 217,1),
                width: 320,
                topCardHeight: 170,
                bottomCardHeight: 100,
                borderRadius: 15,

                topCardWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(image: NetworkImage(cardList[index].displayImgUrl,)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                        cardList[index].userName,style: TextStyle(color: Colors.white)
                    ),
                    SizedBox(height: 15),

                  ],
                ),
                bottomCardWidget: Text(
                  cardList[index].desc + '\n' + '\n' +
                  cardList[index].website,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                slimeEnabled: true,
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
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
        desc: contributorDetail.bio ?? '',
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



