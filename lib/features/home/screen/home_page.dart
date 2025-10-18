import 'package:biet/features/auth/provider/auth_provider.dart';
import '../../utility/capitalize_string_helper.dart' as helper;
import 'package:biet/features/auth/model/student_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StudentModel>(
      future: AuthProvider().loadStudent(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(appBar: AppBar(title: Text("Hello, ")));
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text("Hello, Error")),
            body: Center(child: Text('${snapshot.error}')),
          );
        }

        if (snapshot.hasData) {
          final student = snapshot.data!;
          String totalPercentage = 'N/A';
          final attendanceList =
              student.studentData?.presentPerformance?.attendance;

          if (attendanceList != null) {
            final totalEntry = attendanceList.firstWhere(
              (e) => e.subject == "TOTAL",
            );
            totalPercentage = '${totalEntry.percentage}%';
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: false,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: CircleAvatar(
                    radius: 20,
                    // backgroundImage: AssetImage('assets/avatar.png'),
                  ),
                ),
              ],
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Hello, ${helper.tansformCapitalizeText(text: '${student.studentData?.bioData?.name}')}",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Text(
                    "Welcome back",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ColoredBox(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              'assets/images/focused.png',
                              height: 120,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  totalPercentage,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 38,
                                  ),
                                ),
                                Text(
                                  "Attendance",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18, // Feel free to adjust size
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "Hello, "),
                  TextSpan(text: "No User"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
