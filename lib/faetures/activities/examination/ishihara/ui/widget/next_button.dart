import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final VoidCallback onTapNext;
  final IconData icon;
  const NavButton({Key? key, required this.onTapNext, required this.icon})
      : super(key: key);
  const NavButton.previous(
      {Key? key, required this.onTapNext, this.icon = Icons.arrow_back_ios_new})
      : super(key: key);
  const NavButton.next(
      {Key? key, required this.onTapNext, this.icon = Icons.arrow_forward_ios})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 12),
      color: Colors.lightBlueAccent,
      onPressed: onTapNext,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
