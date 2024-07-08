import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RatingState {}

class RatingcubitInit extends RatingState {}

class RatingcubitInProgress extends RatingState {}

class RatingcubitInSuccess extends RatingState {
  final double rating;
  RatingcubitInSuccess({
    required this.rating,
  });
}

class RatingcubitInError extends RatingState {
  final String? error;
  RatingcubitInError({
    this.error,
  });
}

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingcubitInit());

  double rating({required double rate})  {
    emit(RatingcubitInit());
    try {
      emit(RatingcubitInSuccess(rating: rate));
    } catch (e) {
      emit(RatingcubitInError(error: e.toString()));
    }
    return rate;
  }
}
