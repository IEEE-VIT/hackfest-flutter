import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/widgets/custom_shape_profile.dart';
import 'package:hacktoberfest_flutter/widgets/drawer.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({Key? key}) : super(key: key);
  static String routename = 'ProfileDetails';
  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  late double width, height;
  String userName = 'Red Hair Shanks';
  String photoUrl = 'https://avatarfiles.alphacoders.com/206/thumb-206822.jpg';

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).indicatorColor,
        elevation: 0,
      ),
      endDrawer: const DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomShapeProfile(
            width: width,
            userName: userName,
            //TODO: Give profile photourl in below field
            photoUrl: photoUrl,
          ),
          const CustomContainer(heading: 'Description:', subHeading:'Chief of the Red Hair Pirates \nOne of the Four Emperors that rule over the New World.' ,),
          const CustomContainer2(heading: 'Followers:', subHeading: '10'),
          const CustomContainer2(heading: 'Following:', subHeading: '13'),
          const CustomContainer2(heading: 'Total Repositories:', subHeading: '23'),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key, required this.heading, required this.subHeading,
  });
  final String heading;
  final String subHeading;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                heading,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).indicatorColor,
                    fontWeight: FontWeight.w800,),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  subHeading,
                  style: TextStyle(fontSize: 16.0,
                    color: Theme.of(context).indicatorColor,
                    fontWeight: FontWeight.w400,),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class CustomContainer2 extends StatelessWidget {
  const CustomContainer2({
    super.key, required this.heading, required this.subHeading,
  });
  final String heading;
  final String subHeading;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).focusColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).indicatorColor,
                  fontWeight: FontWeight.w800,),
              ),
              const SizedBox(width: 10,),
              Text(
                subHeading,
                style: TextStyle(fontSize: 16.0,
                  color: Theme.of(context).indicatorColor,
                  fontWeight: FontWeight.w400,),
              ),
            ],
          ),

        ],
      ),
    );
  }
}
