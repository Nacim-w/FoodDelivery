import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legy/features/history/presentation/app/history_state.dart';
import 'package:legy/features/history/service/history_service.dart';
import 'package:legy/features/history/model/report_model.dart'; // Import your model

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
    try {
      await historyService.sendReport(report);
    } catch (e) {
      rethrow;
    }
  }
}
