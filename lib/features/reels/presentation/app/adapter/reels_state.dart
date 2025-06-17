import 'package:equatable/equatable.dart';
import 'package:legy/features/home/model/story_model.dart';

class ReelsState extends Equatable {
  final List<StoryItemModel>? reels;
  final bool isLoadingReels;
  final String? reelsError;

  const ReelsState({
    this.reels,
    this.isLoadingReels = false,
    this.reelsError,
  });

  ReelsState copyWith({
    List<StoryItemModel>? reels,
    bool? isLoadingReels,
    String? reelsError,
  }) {
    return ReelsState(
      reels: reels ?? this.reels,
      isLoadingReels: isLoadingReels ?? this.isLoadingReels,
      reelsError: reelsError ?? this.reelsError,
    );
  }

  @override
  List<Object?> get props => [
        reels,
        isLoadingReels,
        reelsError,
      ];
}
