import 'package:biet/features/auth/model/student_model.dart';
import 'package:biet/features/auth/provider/auth_provider.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class PerformancePage extends StatefulWidget {
  const PerformancePage({super.key});

  @override
  State<PerformancePage> createState() => _PerformancePageState();
}

class _PerformancePageState extends State<PerformancePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final performance = authProvider.user?.studentData?.presentPerformance;

    final total = performance?.attendance?.firstWhere(
      (e) => e.subject == "TOTAL",
    );

    final subjectAttendance = performance?.attendance
        ?.where((e) => e.subject != "TOTAL")
        .toList();

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: ListView(
          children: [
            _totalSummaryCard(total),

            SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "Subject",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),

            ...?subjectAttendance?.map((sub) {
              return _subjectSummaryCard(sub);
            }),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _totalSummaryCard(Attendance? total) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CircularPercentIndicator(
              radius: 70,
              lineWidth: 20,
              percent: (total?.percentage ?? 0.0) / 100,
              center: Text(
                "${total?.percentage}%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              progressColor: Colors.green[400],
              backgroundColor: Colors.grey[300]!,
              circularStrokeCap: CircularStrokeCap.round,
            ),

            // Percentage Helper Text
            Column(
              children: [
                Text(
                  "Total ${total?.held}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Attended ${total?.attended}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _subjectSummaryCard(Attendance sub) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        '${sub.subject}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    LinearPercentIndicator(
                      percent: (sub.percentage ?? 0.0) / 100,
                      lineHeight: 16,
                      progressColor: Colors.green[400],
                      backgroundColor: Colors.grey[350],
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text("${sub.attended} of ${sub.held} attended"),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 16),
              Text(
                "${sub.percentage}%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
