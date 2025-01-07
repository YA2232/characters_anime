import 'package:bloc_app/besnislogic/cubit/characters_cubit.dart';
import 'package:bloc_app/constants/strings.dart';
import 'package:bloc_app/data/api/api_services.dart';
import 'package:bloc_app/data/models/characters.dart';
import 'package:bloc_app/data/reposetry/characters_respository.dart';
import 'package:bloc_app/presentaion/screens/character_details.dart';
import 'package:bloc_app/presentaion/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter() {
    charactersRepository = CharactersRepository(apiServices: ApiServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) => charactersCubit,
                  child: const HomeScreen(),
                ));
      case characterdetails:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetails(
                  character: character,
                ));
      default:
        return null;
    }
  }
}
