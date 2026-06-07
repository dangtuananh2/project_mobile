import '../models/admin_statistic_model.dart';

class AdminService {
  List<AdminStatisticModel> getOverviewStatistics() {
    return [
      AdminStatisticModel(title: 'Người dùng', value: '12,500', description: 'Tổng số người dùng'),
      AdminStatisticModel(title: 'Nhà tuyển dụng', value: '1,850', description: 'Tổng số nhà tuyển dụng'),
      AdminStatisticModel(title: 'Tin tuyển dụng', value: '3,120', description: 'Tổng số tin tuyển dụng'),
      AdminStatisticModel(title: 'CV đã tạo', value: '9,100', description: 'Tổng số CV đã tạo'),
    ];
  }
}
