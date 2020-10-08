import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/contributors_card_model.dart';
import '../../shared/colors.dart';

class ContributorListItem extends StatelessWidget {
  final ContributorCard _contributorCard;

  ContributorListItem(this._contributorCard);

  @override
  Widget build(BuildContext context) {
    final _deviceWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage:
                        NetworkImage(_contributorCard.displayImgUrl),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        _launchURL(_contributorCard.website);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [hactoberViolet, hacktoberPink],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: _deviceWidth / 5, minHeight: 30.0),
                          alignment: Alignment.center,
                          child: const Text(
                            "View Profile",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _contributorCard.name.isNotEmpty
                      ? Text(
                          _contributorCard.name,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 14),
                        )
                      : SizedBox(),
                  Text(
                    _contributorCard.userName,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: _deviceWidth / 1.7,
                    child: Text(
                      _contributorCard.desc == ''
                          ? 'Contributor'
                          : _contributorCard.desc,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  _contributorCard.location.isNotEmpty
                      ? Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                            ),
                            Text(
                              _contributorCard.location,
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        )
                      : SizedBox(),
                  _contributorCard.location.isNotEmpty
                      ? SizedBox(
                          height: 5,
                        )
                      : SizedBox(),
                  _contributorCard.twitterUsername.isNotEmpty
                      ? GestureDetector(
                          onTap: () {
                            _launchURL('https://twitter.com/' +
                                _contributorCard.twitterUsername);
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
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.alternate_email,
                                size: 14,
                                color: Colors.blueAccent,
                              ),
                              Text(
                                _contributorCard.twitterUsername,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.blueAccent),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String gurl) async {
    String url = gurl;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
