import '../models/admin_statistic_model.dart';
import '../services/admin_service.dart';

class AdminController {
  final AdminService _adminService = AdminService();

  List<AdminStatisticModel> getOverviewStatistics() {
    return _adminService.getOverviewStatistics();
  }
}
