import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/history/presentation/app/history_state.dart';
import 'package:legy/features/history/service/history_service.dart';
import 'package:legy/features/history/model/report_model.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryService historyService;

  HistoryCubit({required this.historyService}) : super(HistoryInitial());

  Future<void> loadOrders() async {
    emit(HistoryLoading());
    try {
      final orders = await historyService.fetchOrders();
      emit(HistoryLoaded(orders));
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> submitReport(ReportModel report) async {
    emit(ReportSubmitting());
    try {
      await historyService.sendReport(report);
      emit(ReportSubmitted());
    } catch (e) {
      emit(ReportError(e.toString()));
    }
  }

  Future<void> submitReportWithImage({
    required ReportModel report,
    required File imageFile,
  }) async {
    try {
      // Step 1: Upload image to S3
      emit(ImageUploading());
      final imageUrl = await historyService.uploadReportImage(imageFile);
      emit(ImageUploadSuccess(imageUrl));

      // Step 2: Submit report with image URL
      emit(ReportSubmitting());
      final reportWithImage = report.copyWith(attachmentUrls: [imageUrl]);

      await historyService.sendReport(reportWithImage);
      emit(ReportSubmitted());
    } catch (e) {
      if (state is ImageUploading) {
        emit(ImageUploadError(e.toString()));
      } else {
        emit(ReportError(e.toString()));
      }
    }
  }
}
