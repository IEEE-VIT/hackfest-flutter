import 'package:flutter/material.dart';
import 'package:hacktoberfest_flutter/widgets/custom_shape.dart';

class CustomShapeProfile extends StatefulWidget {
  const CustomShapeProfile({Key? key, required this.width, required this.userName, required this.photoUrl,}) : super(key: key);
  final double width;
  final String userName;
  final String photoUrl;
  @override
  State<CustomShapeProfile> createState() => _CustomShapeProfileState();
}

class _CustomShapeProfileState extends State<CustomShapeProfile> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            const CustomShape(),
            Positioned(
              left: 1.19 * widget.width / 4,
              top: 0,
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 80,
                child: CircleAvatar(
                  radius: 70,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).focusColor,
                        backgroundImage:  NetworkImage(widget.photoUrl),
                        radius: 140,
                      ),),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).indicatorColor,
              ),
            ),
          ],
        ),
      ],
    );
  }}
