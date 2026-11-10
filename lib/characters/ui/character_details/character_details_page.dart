import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/characters/ui/character_details/character_details_cubit.dart';
import 'package:rick_and_morty/characters/ui/character_details/character_details_state.dart';
import 'package:rick_and_morty/characters/ui/character_details/views/character_details_content.dart';
import 'package:rick_and_morty/components/state_message_view.dart';

class CharacterDetailsPage extends StatelessWidget {
  const CharacterDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterDetailsCubit, CharacterDetailsState>(
      builder: (context, state) => switch (state) {
        CharacterDetailsLoaded(:final character) => CharacterDetailsContent(
          character: character,
        ),
        CharacterDetailsLoading() => Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator.adaptive()),
        ),
        CharacterDetailsFailure(:final error) => Scaffold(
          appBar: AppBar(),
          body: StateMessageView.error(
            error,
            onRetry: context.read<CharacterDetailsCubit>().retry,
          ),
        ),
      },
    );
  }
}
