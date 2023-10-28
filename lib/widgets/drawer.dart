import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

// ignore: must_be_immutable
class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 10, bottom: 30),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://avatarfiles.alphacoders.com/206/thumb-206822.jpg',),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        'Red Hair Shanks',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BuildTile(
              text: 'Home',
              icon: Icons.home,
              context: context,
              route: 'HomePage',
            ),
            BuildTile(
              text: 'Profile',
              icon: Icons.person_rounded,
              context: context,
              route: '',
            ),
            BuildTile(
              text: 'Sign Out',
              icon: Icons.logout_rounded,
              context: context,
              route: '',
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, top: 15),
              child: Row(
                children: <Widget>[
                  FlutterSwitch(
                    width: 44.0,
                    height: 22.0,
                    toggleSize: 22.0,
                    value: value,
                    borderRadius: 15.0,
                    padding: 0.0,
                    activeToggleColor: const Color(0xFF4148F5),
                    inactiveToggleColor: Colors.deepPurple,
                    activeColor: const Color(0xFF206993),
                    inactiveColor: const Color(0xFFD7A9EC),
                    activeIcon: const Icon(
                      Icons.nightlight_round_outlined,
                      color: Colors.white,
                    ),
                    inactiveIcon: const Icon(
                      Icons.wb_sunny_outlined,
                      color: Color(0xFFFFFFFF),
                    ),
                    onToggle: (val) {
                      setState(() {
                        value = val;
                      });
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    child: const Text(
                      'Change Theme',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget BuildTile({
    required String text,
    required IconData icon,
    required BuildContext context,
    required String route,
  }) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
      leading: Icon(
        icon,
        size: 25,
        color: Colors.black,
      ),
      title: Text(
        text,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
      visualDensity: const VisualDensity(vertical: -4),
      contentPadding: const EdgeInsets.only(left: 35, top: 5),
      onTap: () {
        Navigator.pop(context);
        if (route == 'HomePage') {
          Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
        } else if (route != '') {
          Navigator.pushNamed(context, route);
        }
      },
      selectedTileColor: Colors.black,
    );
  }
}
