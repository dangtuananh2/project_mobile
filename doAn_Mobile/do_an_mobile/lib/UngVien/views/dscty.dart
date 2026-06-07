import 'package:flutter/material.dart';

class DSCTY extends StatelessWidget {
  const DSCTY({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Công ty đã ứng tuyển",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(15),
        children: const [

          JobCard(
            logo: "assets/images/company.jpg",
            title: "Nhân viên Kinh doanh",
            company: "Công ty ABC",
            salary: "15 - 20 triệu",
            location: "Hà Nội",
            time: "2 tuần trước",
            status: "Đã ứng tuyển",
            result: "Đã trúng tuyển",
          ),

          JobCard(
            logo: "assets/images/company2.jpg",
            title: "Frontend Developer",
            company: "Công ty XYZ",
            salary: "20 - 30 triệu",
            location: "Hồ Chí Minh",
            time: "2 tuần trước",
            status: "Đã ứng tuyển",
          ),

          JobCard(
            logo: "assets/images/company3.jpg",
            title: "Frontend Developer",
            company: "Công ty XYZ",
            salary: "20 - 30 triệu",
            location: "Hồ Chí Minh",
            time: "1 tháng trước",
            status: "Đang xử lý",
          ),
        ],
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final String logo;
  final String title;
  final String company;
  final String salary;
  final String location;
  final String time;
  final String status;
  final String? result;

  const JobCard({
    super.key,
    required this.logo,
    required this.title,
    required this.company,
    required this.salary,
    required this.location,
    required this.time,
    required this.status,
    this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// 🔥 TOP
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  logo,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(company,
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// 🔥 STATUS CHIP
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: status == "Đã ứng tuyển"
                  ? Colors.green.withOpacity(0.15)
                  : Colors.orange.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: status == "Đã ứng tuyển"
                    ? Colors.green
                    : Colors.orange,
              ),
            ),
          ),

          const SizedBox(height: 10),

          /// 🔥 INFO ROW
          Row(
            children: [
              const Icon(Icons.attach_money, size: 16, color: Colors.amber),
              Text(" $salary"),
              const SizedBox(width: 10),

              const Icon(Icons.location_on, size: 16, color: Colors.red),
              Text(" $location"),
              const SizedBox(width: 10),

              const Icon(Icons.access_time, size: 16, color: Colors.grey),
              Text(" $time"),
            ],
          ),

          /// 🔥 RESULT
          if (result != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.check, color: Colors.green),
                const SizedBox(width: 5),
                Text(
                  result!,
                  style: const TextStyle(color: Colors.green),
                ),
              ],
            )
          ]
        ],
      ),
    );
  }
}