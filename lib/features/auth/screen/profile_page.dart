import 'package:biet/features/auth/provider/auth_provider.dart';
import 'package:biet/features/auth/screen/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user?.studentData?.bioData;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Call the logout method from the provider
              context.read<AuthProvider>().logout();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      // backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${user?.name}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Text("${user?.branch} | ${user?.rollNo}"),
                    Text("Roll no. ${user?.rollNo}"),
                    Text("Admission No. ${user?.admissionNo}"),
                    Text("Branch: ${user?.branch}"),
                  ],
                ),
              ],
            ),

            Divider(),
            SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  DisplayUsetInfo(k: "Mobile ", v: "${user?.mobileNo}"),
                  DisplayUsetInfo(k: "Email ", v: "${user?.email}"),
                  DisplayUsetInfo(k: "Caste ", v: "${user?.caste}"),

                  DisplayUsetInfo(k: "Course ", v: "${user?.course}"),
                  DisplayUsetInfo(k: "Seat type ", v: "${user?.seatType}"),
                  DisplayUsetInfo(
                    k: "Entrance type ",
                    v: "${user?.entranceType}",
                  ),
                  DisplayUsetInfo(
                    k: "Eamcet rank ",
                    v: "${user?.eamcetEcetRank}",
                  ),
                  DisplayUsetInfo(k: "DOB ", v: "${user?.dob}"),
                  DisplayUsetInfo(k: "Caste ", v: "${user?.caste}"),
                  DisplayUsetInfo(k: "Aadhar no.", v: "${user?.adharNo}"),
                  DisplayUsetInfo(k: "Roll no. ", v: "${user?.rollNo}"),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisplayUsetInfo extends StatelessWidget {
  final String k;
  final String v;

  const DisplayUsetInfo({super.key, required this.k, required this.v});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(k, style: const TextStyle(fontSize: 16)),
        Text(
          v,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
