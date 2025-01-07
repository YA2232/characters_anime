import 'package:bloc_app/besnislogic/cubit/characters_cubit.dart';
import 'package:bloc_app/constants/my_colors.dart';
import 'package:bloc_app/data/models/characters.dart';
import 'package:bloc_app/presentaion/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacter;
  bool _isSearched = false;
  final _searchedTextController = TextEditingController();

  Widget bildSearchField() {
    return TextField(
      controller: _searchedTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: MyColors.myGrey, fontSize: 18),
      ),
      style: const TextStyle(color: MyColors.myGrey, fontSize: 18),
      onChanged: (searchedCharacter) {
        addSearchedforItemsToSearchedList(searchedCharacter);
      },
    );
  }

  void addSearchedforItemsToSearchedList(String searchedCharacter) {
    searchedForCharacter = allCharacters
        .where((character) =>
            character.name!.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> _bildAppBarActions() {
    if (_isSearched) {
      return [
        IconButton(
          onPressed: () {
            _cleanSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearching,
            icon: const Icon(
              Icons.search,
              color: MyColors.myGrey,
            ))
      ];
    }
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearched = true;
    });
  }

  void _stopSearching() {
    _cleanSearch();
    setState(() {
      _isSearched = false;
    });
  }

  void _cleanSearch() {
    setState(() {
      _searchedTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacter();
  }

  Widget bildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = state.characters;
        return bildLoadedListWidgets();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget bildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            bildCaractersList(),
          ],
        ),
      ),
    );
  }

  Widget bildCaractersList() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 1,
            mainAxisSpacing: 1),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        itemCount: _searchedTextController.text.isEmpty
            ? allCharacters.length
            : searchedForCharacter.length,
        itemBuilder: (context, i) {
          return CharacterItem(
            character: _searchedTextController.text.isEmpty
                ? allCharacters[i]
                : searchedForCharacter[i],
          );
        });
  }

  Widget bildAppBarTitle() {
    return const Text(
      'Chracters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: _isSearched ? bildSearchField() : bildAppBarTitle(),
        actions: _bildAppBarActions(),
      ),
      body: bildBlocWidget(),
    );
  }
}




class Student {
  String _name = '';

  void setName(String name) {
    _name = name;
  }

  String getName() {
    return _name;
  }
}

void main() {
  Student student = Student();

  student.setName('يوسف');

  print('الاسم: ${student.getName()}');
}

