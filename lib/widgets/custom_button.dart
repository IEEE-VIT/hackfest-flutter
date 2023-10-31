import 'package:flutter/material.dart';

//customizable button to remove code redundancy
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.height,
    required this.width,
    required this.onPressed,
    required this.isIcon,
    required this.buttonText,
    this.icon = Icons.visibility,
  });

  final double height, width;
  final void Function() onPressed;
  final bool isIcon;
  final String buttonText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        // ignore: use_named_constants
        padding: const EdgeInsets.all(0.0),
        backgroundColor: Colors.transparent,
      ),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (isIcon)
              Icon(
                icon,
                color: Colors.white,
              ),
            if (isIcon)
              const SizedBox(
                width: 10,
              ),
            Text(
              buttonText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
