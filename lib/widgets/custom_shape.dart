import 'package:flutter/material.dart';
class CustomShape extends StatelessWidget {
  const CustomShape({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ClipPath(
      clipper: MyClipper(),
      child: Container(
        width: double.infinity,
        height: 160,
        color: Theme.of(context).indicatorColor,
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height-100);
    path.lineTo(size.width/2, size.height-60);
    path.lineTo(size.width, size.height-100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }

}
