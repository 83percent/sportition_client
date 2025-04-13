import 'package:flutter/material.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class UserContent extends StatefulWidget {
  const UserContent({Key? key}) : super(key: key);

  @override
  _UserContentState createState() => _UserContentState();
}

class _UserContentState extends State<UserContent> {
  List<String> _pictureUIDList = ['', '', '', '', ''];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: const Text(
              '피드',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'NotoSansKR',
              ),
            ),
          ),
          GridView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(_pictureUIDList.length, (index) {
              return Container(
                color: AppColors.borderGray010Color,
                child: Center(
                  child: Text('picture'),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
