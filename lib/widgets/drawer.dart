import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';



// ignore: must_be_immutable
class DrawerWidget extends StatefulWidget {
  DrawerWidget({
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
            body:
               ListView(children: [
                ListTile(
                  onTap: () {

                  },
                  leading: const CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage('https://avatarfiles.alphacoders.com/206/thumb-206822.jpg'),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Text(
                      'Red Hair Shanks',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(top: 50, left: 10),
                ),
                const SizedBox(
                  height: 30,
                ),
                BuildTile(
                    text: 'Home',
                    icon: Icons.home_outlined,
                    context: context,
                    route: 'HomePage'),
                BuildTile(
                    text: 'Profile',
                    icon: Icons.person_outline_rounded,
                    context: context,
                    route: ''),
                BuildTile(
                    text: 'Sign Out',
                    icon: Icons.logout,
                    context: context,
                    route: 'SettingsPage'),
                 Padding(
                   padding: const EdgeInsets.only(left: 35,top: 10),
                   child: Row(
                     children: <Widget>[
                       FlutterSwitch(
                         width: 44.0,
                         height: 22.0,
                         toggleSize: 22.0,
                         value: value,
                         borderRadius: 15.0,
                         padding: 0.0,
                         activeToggleColor: Color(0xFF4148F5),
                         inactiveToggleColor:Colors.deepPurple,
                         activeColor: Color(0xFF206993),
                         inactiveColor: Color(0xFFD7A9EC),
                         activeIcon: Icon(
                           Icons.nightlight_round_outlined,
                           color: Colors.white,
                         ),
                         inactiveIcon: Icon(
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
                         child: const Text('Change Theme'),
                       ),
                     ],
                   ),
                 ),
              ]),
            ));
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
        color: Colors.black,
      ),
      title: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: const EdgeInsets.only(left: 38),
      onTap: () {
        Navigator.pop(context);
        if(route=='HomePage'){
          Navigator.pushNamedAndRemoveUntil(context, route, (route)=> false);
        }else if(route!='')
          Navigator.pushNamed(context, route);
      },
      selectedTileColor: Colors.black,
    );
  }
}
