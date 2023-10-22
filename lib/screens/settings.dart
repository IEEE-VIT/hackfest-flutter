import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  static String routename = 'SettingsPage';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Map<String, int> themes = {'System Default': 1, 'Light': 2, 'Dark': 3};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 5.0,
        iconTheme: IconThemeData(
          color: Theme.of(context).secondaryHeaderColor,
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).secondaryHeaderColor,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: const Text(
                'Theme',
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return StatefulBuilder(
                      builder: (stfContext, stfSetState) {
                        return AlertDialog(
                          title: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                'Set Theme',
                              ),
                            ),
                          ),
                          content: SizedBox(
                            height: 160,
                            width: 150,
                            child: ListView(
                              children: themes.keys
                                  .map(
                                    (e) => RadioListTile(
                                      title: Text(e),
                                      value: themes[e],
                                      groupValue: themes[device.theme],
                                      activeColor: Colors.cyan,
                                      onChanged: (value) {
                                        stfSetState(() {
                                          device.theme = e;
                                        });
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Provider.of<ThemeProvider>(
                                  context,
                                  listen: false,
                                ).changeTheme(device.theme);
                                saveSetting('theme', device.theme);
                              },
                              child: const Text(
                                'Save',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> saveSetting(String key, dynamic value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (value is int) {
    prefs.setInt(key, value);
  } else if (value is double) {
    prefs.setDouble(key, value);
  } else if (value is bool) {
    prefs.setBool(key, value);
  } else if (value is String) {
    prefs.setString(key, value);
  } else {
    // Handle other data types as needed.
  }
}

//Device model including theme property
class Device {
  Device({required this.theme});
  String? theme;
}

Device device = Device(theme: 'System Default');
