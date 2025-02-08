import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DashboardCard(
              icon: Icons.verified_user,
              title: 'Approve & Verify NGOs',
              description: 'Validate organizations using AI-powered fraud detection.',
              buttonText: 'Review NGOs',
              onTap: () {},
            ),
            DashboardCard(
              icon: Icons.analytics,
              title: 'Monitor Transactions',
              description: 'Detect suspicious patterns.',
              buttonText: 'View Transactions',
              onTap: () {},
            ),
            DashboardCard(
              icon: Icons.receipt_long,
              title: 'Audit Trails & Reports',
              description: 'Ensure fund distribution follows pre-defined rules.',
              buttonText: 'Generate Reports',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;

  const DashboardCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.tealAccent, size: 30),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(color: Colors.white70),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.tealAccent, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: onTap,
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AdminDashboard(),
  ));
}
