import 'package:flutter/material.dart';
import 'package:github_flutter/animations/animatingListTiles.dart';
import '../shared/colors.dart';

final controllerFullName = TextEditingController();
final controllerGitHubName = TextEditingController();
final controllerAbout = TextEditingController();
final controllerCity = TextEditingController();
final controllerCountry = TextEditingController();
final controllerTwitterName = TextEditingController();

class ContributorInformation extends StatelessWidget {
  static final String routename = '/ContributorInfo';

  TextField myTextField(
      String label, IconData icon, TextEditingController controller) {
    return TextField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: WidgetAnimator(Icon(icon)),
          labelText: label,
          filled: true,
          fillColor: Colors.purple.withOpacity(0.07),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Contributor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 25),
              myTextField('Full Name', Icons.person, controllerFullName),
              SizedBox(height: 14),
              myTextField('GitHub Username', Icons.code, controllerFullName),
              SizedBox(height: 14),
              myTextField('About', Icons.info, controllerFullName),
              SizedBox(height: 14),
              myTextField('City', Icons.location_city, controllerFullName),
              SizedBox(height: 14),
              myTextField('Country', Icons.location_on, controllerFullName),
              SizedBox(height: 14),
              myTextField('Twitter Username', Icons.laptop, controllerFullName),
              SizedBox(height: 14),
              RaisedButton(
                shape: StadiumBorder(),
                onPressed: () {},
                child: Text(
                  'Add Contributor',
                  style: TextStyle(color: Colors.white),
                ),
                color: hacktoberPurple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
