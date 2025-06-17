import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/reels/presentation/app/adapter/reels_state.dart';
import 'package:legy/features/reels/service/reels_service.dart';

class ReelsCubit extends Cubit<ReelsState> {
  final ReelsService reelsService;

  ReelsCubit({required this.reelsService}) : super(ReelsState());

  Future<void> loadReels() async {
    emit(state.copyWith(isLoadingReels: true));
    try {
      final reels = await reelsService.getReels();

      emit(state.copyWith(reels: reels, isLoadingReels: false));
    } catch (e) {
      emit(state.copyWith(
        reelsError: 'Failed to load stories: $e',
        isLoadingReels: false,
      ));
    }
  }
}
