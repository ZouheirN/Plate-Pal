import 'package:flutter_bloc/flutter_bloc.dart';

part 'recipe_instructions_event.dart';
part 'recipe_instructions_state.dart';

class RecipeInstructionsBloc extends Bloc<RecipeInstructionsEvent, RecipeInstructionsState> {
  RecipeInstructionsBloc() : super(RecipeInstructionsInitial()) {
    on<RecipeInstructionsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
