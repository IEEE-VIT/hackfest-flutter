//The model of the card of the contributors.

import 'package:flutter/material.dart';
class ContributorCard {
  final String userName;
  final String desc;
  final String displayImgUrl;
  final String website;
  ContributorCard({@required this.userName,@required this.displayImgUrl,@required this.desc,@required this.website});
}