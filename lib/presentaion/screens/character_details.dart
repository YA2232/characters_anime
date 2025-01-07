import 'package:bloc_app/constants/my_colors.dart';
import 'package:bloc_app/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;
  CharacterDetails({required this.character, super.key});

  Widget bildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      centerTitle: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.name!,
          style: const TextStyle(color: MyColors.myWhite),
        ),
        background: Hero(
            tag: character,
            child: Image.network(
              character.image!,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDevider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          bildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.only(top: 14, left: 14, right: 14, bottom: 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  characterInfo('Status : ', character.status!),
                  buildDevider(260),
                  characterInfo('Species : ', character.species!),
                  buildDevider(250),
                  characterInfo('Gender : ', character.gender!),
                  buildDevider(260),
                  characterInfo('Created : ', character.created!),
                  buildDevider(250),
                ],
              ),
            ),
            SizedBox(
              height: 600,
            )
          ]))
        ],
      ),
    );
  }
}
