import 'package:flutter/material.dart';

class KinhNghiem extends StatelessWidget {
  const KinhNghiem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          "Kinh nghiệm làm việc",
          style: TextStyle(color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🔥 BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "+ Thêm kinh nghiệm",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 TIMELINE
            Expanded(
              child: ListView(
                children: const [

                  TimelineItem(
                    isFirst: true,
                    title: "Frontend Developer",
                    company: "Công ty XYZ",
                    time: "01/2023 - Hiện tại",
                    descriptions: [
                      "Phát triển giao diện web bằng HTML, CSS, JS",
                      "Làm việc với ReactJS",
                      "Tối ưu UI/UX",
                    ],
                  ),

                  TimelineItem(
                    isLast: true,
                    title: "Intern Web Developer",
                    company: "Công ty ABC",
                    time: "06/2022 - 12/2022",
                    descriptions: [
                      "Học và thực hành HTML/CSS",
                      "Hỗ trợ team dev",
                      "Fix bug giao diện",
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineItem extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final String title;
  final String company;
  final String time;
  final List<String> descriptions;

  const TimelineItem({
    super.key,
    this.isFirst = false,
    this.isLast = false,
    required this.title,
    required this.company,
    required this.time,
    required this.descriptions,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// 🔥 TIMELINE LINE + DOT
        Column(
          children: [
            if (!isFirst)
              Container(width: 2, height: 20, color: Colors.green),

            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),

            if (!isLast)
              Container(width: 2, height: 120, color: Colors.green),
          ],
        ),

        const SizedBox(width: 12),

        /// 🔥 CARD
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Text(
                  company,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 4),

                Text(
                  time,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 10),

                ...descriptions.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Text("• $e"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}