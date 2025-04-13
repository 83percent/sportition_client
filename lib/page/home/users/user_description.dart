import 'package:flutter/material.dart';

class UserDescription extends StatefulWidget {
  final String? description;
  const UserDescription({Key? key, String? this.description}) : super(key: key);

  @override
  _UserDescriptionState createState() => _UserDescriptionState();
}

class _UserDescriptionState extends State<UserDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 15),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Text(
            widget.description ?? '',
            style: const TextStyle(
              fontSize: 13,
              fontFamily: 'Notosans',
            ),
          ),
        ),
      ],
    );
  }
}
