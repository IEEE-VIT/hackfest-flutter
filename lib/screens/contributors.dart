import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/models/contributor_detail_model.dart';
import 'package:hacktoberfest_flutter/models/contributors_data_model.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hacktoberfest_flutter/models/contributors_card_model.dart';

class Contributors extends StatefulWidget {
  static const String routename = '/Contributors';

  const Contributors({Key? key});

  @override
  State<Contributors> createState() => _ContributorsState();
}

class _ContributorsState extends State<Contributors>
    with AutomaticKeepAliveClientMixin {
  List<ContributorCard> cardList = [];
  @override
  void initState() {
    super.initState();
    fetchInitialContributors(); // Fetch and update cardList
  }

  Future<void> fetchInitialContributors() async {
    List<ContributorCard> cards = await getContributors(
        username: 'IEEE-VIT', repository: 'hacktoberfest-flutter');
    setState(() {
      cardList = cards;
    });
  }

  void addContributor(ContributorCard newContributor) {
    setState(() {
      cardList.add(newContributor);
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Contributors List',
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                cardList.length.toString(),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
      body: cardList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: cardList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  NetworkImage(cardList[index].displayImgUrl),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: GestureDetector(
                                onTap: () {
                                  _launchURL(cardList[index].website);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [hactoberViolet, hacktoberPink],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxWidth: deviceWidth / 5,
                                      minHeight: 30.0,
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "View Profile",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardList[index].name.isNotEmpty
                                ? Text(
                                    cardList[index].name,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  )
                                : const SizedBox(),
                            Text(
                              cardList[index].userName,
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkTheme
                                    ? Colors.white.withOpacity(0.7)
                                    : Colors.grey[700],
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: deviceWidth / 1.7,
                              child: Text(
                                cardList[index].desc == ''
                                    ? 'Contributor'
                                    : cardList[index].desc,
                                style: TextStyle(
                                  color: Provider.of<ThemeProvider>(context)
                                          .isDarkTheme
                                      ? Colors.white.withOpacity(0.7)
                                      : Colors.grey[700],
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            cardList[index].location.isNotEmpty
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        size: 14,
                                        color:
                                            Provider.of<ThemeProvider>(context)
                                                    .isDarkTheme
                                                ? Colors.white
                                                : Colors.black,
                                      ),
                                      Text(
                                        cardList[index].location,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Provider.of<ThemeProvider>(
                                                      context)
                                                  .isDarkTheme
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            cardList[index].location.isNotEmpty
                                ? const SizedBox(
                                    height: 5,
                                  )
                                : const SizedBox(),
                            cardList[index].twitterUsername.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _launchURL(
                                          'https://twitter.com/${cardList[index].twitterUsername}');
                                    },
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 14,
                                          width: 14,
                                          child: Image.network(
                                            'https://img.icons8.com/fluent-systems-filled/344/twitter.png',
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Icon(
                                          Icons.alternate_email,
                                          size: 14,
                                          color: Colors.blueAccent,
                                        ),
                                        Text(
                                          cardList[index].twitterUsername,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          // Trigger the 'Add Contributor' dialog
          _showAddContributorDialog(context, addContributor);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddContributorDialog(
      BuildContext context, Function(ContributorCard) addContributorCallback) {
    TextEditingController usernameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Contributor'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'GitHub Username'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Get the username entered by the user
                String githubUsername = usernameController.text;

                // Call the function to add the contributor
                addToContributors(context, addContributorCallback);

                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Future<List<ContributorCard>> getContributors(
    {required String username, required String repository}) async {
  const String head = 'https://api.github.com/repos/';
  const String tail = '/contributors';
  String url = '$head$username/$repository$tail';
  http.Response response = await http.get(
      Uri.https('api.github.com', '/repos/$username/$repository/contributors'));

  List<Contributor> contributors = contributorFromJson(response.body);
  List<ContributorCard> contriCards = [];
  for (final contributor in contributors) {
    http.Response contributorResponse = await http
        .get(Uri.parse('https://api.github.com/users/${contributor.login}'));

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

void addToContributors(BuildContext context,
    Function(ContributorCard) addContributorCallback) async {
  // Fetch contributor data from GitHub based on the provided username
  String githubUsername =
      'githubUsername'; // Replace with the actual GitHub username

  // Fetch contributor data from GitHub using the GitHub API
  final githubResponse =
      await http.get(Uri.https('api.github.com', '/users/$githubUsername'));
  if (githubResponse.statusCode == 200) {
    // Parse the GitHub response to extract contributor details
    final contributorData = contributorDetailFromJson(githubResponse.body);

    ContributorCard newContributor = ContributorCard(
      userName: contributorData.login,
      name: contributorData.name ?? '',
      desc: contributorData.bio ?? '',
      location: contributorData.location ?? '',
      twitterUsername: contributorData.twitterUsername ?? '',
      displayImgUrl: contributorData.avatarUrl,
      website: contributorData.blog.isEmpty
          ? contributorData.htmlUrl
          : contributorData.blog,
    );

    // Access cardList and update it within the _ContributorsState instance
    addContributorCallback(newContributor);

    try {
      Navigator.of(context).pop(); // Close the dialog
    } catch (e) {
      // Handle the error gracefully (e.g., log it)
      print('Error when popping Navigator: $e');
    }
  } else {
    // Handle the case where GitHub data could not be retrieved
    print('Failed to fetch GitHub data for the contributor.');
  }
}

_launchURL(String gurl) async {
  String url = gurl;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
