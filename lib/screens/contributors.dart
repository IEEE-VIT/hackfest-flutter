import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/models/contributor_detail_model.dart';
import 'package:hacktoberfest_flutter/models/contributors_card_model.dart';
import 'package:hacktoberfest_flutter/models/contributors_data_model.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:hacktoberfest_flutter/shared/colors.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Contributors extends StatefulWidget {
  const Contributors({super.key, required this.repoName});
  static const String routename = '/Contributors';
  final String repoName;
  @override
  State<Contributors> createState() => _ContributorsState();
}

class _ContributorsState extends State<Contributors>
    with AutomaticKeepAliveClientMixin {
  List<ContributorCard> cardList = [];
  @override
  void initState() {
    super.initState();
    getContributors(repository: widget.repoName).then((cards) {
      setState(() {
        cardList = cards;
      });
    });
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    // Used device height and width to make responsive layout
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 5.0,
        //shadowColor: Colors.black26,
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Theme.of(context).secondaryHeaderColor,
        ),
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
                                      colors: [
                                        hacktoberViolet,
                                        hacktoberPink,
                                      ],
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
                                      'View Profile',
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
                            if (cardList[index].name.isNotEmpty)
                              Text(
                                cardList[index].name,
                                style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              )
                            else
                              const SizedBox(),
                            Text(
                              cardList[index].userName,
                              style: TextStyle(
                                color: Provider.of<ThemeProvider>(context)
                                        .isDarkTheme2
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
                                          .isDarkTheme2
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
                            if (cardList[index].location.isNotEmpty)
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 14,
                                    color: Provider.of<ThemeProvider>(
                                      context,
                                    ).isDarkTheme2
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  Text(
                                    cardList[index].location,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Provider.of<ThemeProvider>(
                                        context,
                                      ).isDarkTheme2
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            else
                              const SizedBox(),
                            if (cardList[index].location.isNotEmpty)
                              const SizedBox(
                                height: 5,
                              )
                            else
                              const SizedBox(),
                            if (cardList[index].twitterUsername.isNotEmpty)
                              GestureDetector(
                                onTap: () {
                                  _launchURL(
                                    'https://twitter.com/${cardList[index].twitterUsername}',
                                  );
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
                            else
                              const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: const FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: addToContributors,
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

Future<List<ContributorCard>> getContributors({
  required String repository,
}) async {
  const String head = 'https://api.github.com/repos/';
  const String tail = '/contributors';
  final String url = '$head$repository$tail';
  final http.Response response = await http.get(Uri.parse(url));
  final List<Contributor> contributors = contributorFromJson(response.body);
  final List<ContributorCard> contriCards = [];
  for (final contributor in contributors) {
    final http.Response contributorResponse = await http
        .get(Uri.parse('https://api.github.com/users/${contributor.login}'));
    final ContributorDetail contributorDetail =
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

void addToContributors() {
  // Trigger an alert box or something similar
  // Ask the user to enter the details
  // Adds the user to contributors list
}

Future<void> _launchURL(String gurl) async {
  if (gurl.substring(0, 4) != 'http' || gurl.substring(0, 4) != 'https') {
    gurl = 'https://$gurl';
  }
  final String url = gurl;
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
