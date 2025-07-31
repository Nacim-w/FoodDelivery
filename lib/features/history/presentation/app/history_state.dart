import 'package:equatable/equatable.dart';
import 'package:legy/features/history/model/history_order_models.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();

  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<OrderModel> orders;

  const HistoryLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class HistoryError extends HistoryState {
  final String message;

  const HistoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class HistorySessionExpired extends HistoryState {}

class ReportSubmitting extends HistoryState {}

class ImageUploading extends HistoryState {}

class ImageUploadSuccess extends HistoryState {
  final String imageUrl;

  const ImageUploadSuccess(this.imageUrl);

  @override
  List<Object?> get props => [imageUrl];
}

class ImageUploadError extends HistoryState {
  final String message;

  const ImageUploadError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReportSubmitted extends HistoryState {}

class ReportError extends HistoryState {
  final String message;

  const ReportError(this.message);

  @override
  List<Object?> get props => [message];
}
