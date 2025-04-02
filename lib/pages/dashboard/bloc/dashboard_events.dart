abstract class DashboardEvents {
  const DashboardEvents();
}

class TriggerDashboard extends DashboardEvents {
  final int index;
  const TriggerDashboard(this.index) : super();
}
