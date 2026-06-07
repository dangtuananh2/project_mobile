import 'package:flutter/material.dart';

class JobDetailPage extends StatefulWidget {
  final String title;
  final String company;
  final String salary;
  final String location;

  const JobDetailPage({
    super.key,
    required this.title,
    required this.company,
    required this.salary,
    required this.location,
  });

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage>
    with SingleTickerProviderStateMixin {

  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {

    String logo = widget.company.contains("TANGO")
        ? "assets/images/company.jpg"
        : "assets/images/company2.jpg";

    return Scaffold(
      backgroundColor: Colors.grey[100],

      body: Stack(
        children: [

          /// HEADER
          Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF00C853),
                  Color(0xFF009688),
                ],
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [

                /// TOP BAR
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [

                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),

                    IconButton(
                      icon: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        /// LOGO
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            logo,
                            height: 60,
                          ),
                        ),

                        const SizedBox(height: 10),

                        /// CARD INFO
                        Container(
                          margin: const EdgeInsets.all(15),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [

                              Text(
                                widget.title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                widget.company,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(height: 15),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [

                                  infoItem(
                                    Icons.attach_money,
                                    "Mức lương",
                                    widget.salary,
                                  ),

                                  infoItem(
                                    Icons.location_on,
                                    "Địa điểm",
                                    widget.location,
                                  ),

                                  infoItem(
                                    Icons.star,
                                    "Kinh nghiệm",
                                    "Dưới 1 năm",
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        /// TAB
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceAround,
                          children: [
                            tabItem("Thông tin", 0),
                            tabItem("Công ty", 1),
                            tabItem("Mức độ cạnh tranh", 2),
                          ],
                        ),

                        const SizedBox(height: 10),

                        /// TAB CONTENT
                        if (tabIndex == 0) buildInfoTab(),
                        if (tabIndex == 1) buildCompanyTab(),
                        if (tabIndex == 2) buildLevelTab(),

                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      /// BUTTON
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.green,
                ),
                onPressed: () {},
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Ứng tuyển ngay",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TAB ITEM
  Widget tabItem(String title, int index) {
    return GestureDetector(
      onTap: () => setState(() => tabIndex = index),
      child: Column(
        children: [

          Text(
            title,
            style: TextStyle(
              color: tabIndex == index
                  ? Colors.green
                  : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          if (tabIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 2,
              width: 40,
              color: Colors.green,
            ),
        ],
      ),
    );
  }

  Widget buildInfoTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        wrapChips([
          "Telesales",
          "B2C",
          "Giáo dục",
          "HSK 3",
          "Tuổi 18-26",
        ]),

        buildSection("Mô tả công việc", [
          "Trả lời tin nhắn khách hàng quan tâm đến khóa học",
          "Gọi điện tư vấn khách",
          "Hướng dẫn đăng ký và chăm sóc khách",
        ]),

        buildSection("Yêu cầu ứng viên", [
          "HSK 2 trở lên",
          "Tuổi 18-26",
          "Giao tiếp tốt",
          "Có kinh nghiệm telesales là lợi thế",
        ]),
      ],
    );
  }

  Widget buildCompanyTab() {
    return buildSection("Công ty", [
      "Môi trường trẻ",
      "Training đầy đủ",
    ]);
  }

  Widget buildLevelTab() {
    return buildSection("Thông tin chung", [
      "Nhân viên",
      "5 người",
      "Fulltime",
    ]);
  }

  Widget wrapChips(List items) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: items
            .map(
              (e) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      BorderRadius.circular(20),
                ),
                child: Text(e),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildSection(String title, List items) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ...items.map((e) => Text("• $e")),
        ],
      ),
    );
  }

  Widget infoItem(
    IconData icon,
    String title,
    String value,
  ) {
    return Column(
      children: [

        Icon(icon, color: Colors.green),

        const SizedBox(height: 5),

        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),

        Text(
          value,
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}