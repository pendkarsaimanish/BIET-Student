import 'package:biet/features/auth/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SubjectDetailsPage extends StatelessWidget {
  final Attendance subjectAttendance;
  final List<InternalMarks>? internalMarks;

  const SubjectDetailsPage({
    super.key,
    required this.subjectAttendance,
    this.internalMarks,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subjectAttendance.subject ?? 'Subject Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildAttendanceCard(),
          const SizedBox(height: 24),
          _buildInternalMarksSection(),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Attendance Summary',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildDetailRow('Classes Held:', '${subjectAttendance.held ?? 0}'),
            _buildDetailRow(
              'Classes Attended:',
              '${subjectAttendance.attended ?? 0}',
            ),
            _buildDetailRow(
              'Percentage:',
              '${subjectAttendance.percentage?.toStringAsFixed(2) ?? "0.00"}%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInternalMarksSection() {
    // Don't build the widget if there are no marks or no subject name
    if (internalMarks == null ||
        internalMarks!.isEmpty ||
        subjectAttendance.subject == null) {
      print("empty");
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Internal Marks',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Create a row for each exam
            ...internalMarks!.map((exam) {
              final mark =
                  exam.marks?.getMarkForSubject(subjectAttendance.subject!) ??
                  '-';
              return _buildDetailRow('${exam.exam ?? 'Unknown Exam'}:', mark);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 18, color: Colors.black54),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
