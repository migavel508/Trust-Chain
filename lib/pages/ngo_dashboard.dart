import 'package:flutter/material.dart';

class NGODashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Dashboard'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fund Requests Section
              DashboardSection(
                title: "Fund Requests",
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text("Submit Fund Request"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Project Progress Updates Section
              DashboardSection(
                title: "Project Progress Updates",
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.upload_file),
                      label: Text("Upload Proof of Work"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Upload photos, receipts, and documents to update project progress."),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Transaction Ledger Section
              DashboardSection(
                title: "Transaction Ledger",
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.receipt, color: Colors.teal),
                      title: Text("Transaction #12345"),
                      subtitle: Text("Purpose: Supplies - \$500"),
                    ),
                    ListTile(
                      leading: Icon(Icons.receipt, color: Colors.teal),
                      title: Text("Transaction #67890"),
                      subtitle: Text("Purpose: Infrastructure - \$1200"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text("View All Transactions"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // AI Validator Feedback Section
              DashboardSection(
                title: "AI Validator Feedback",
                child: Column(
                  children: [
                    Text(
                      "Spending Efficiency: 85%",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.85,
                      backgroundColor: Colors.grey[300],
                      color: Colors.teal,
                    ),
                    SizedBox(height: 10),
                    Text("Your spending is efficient. Keep up the great work!"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardSection extends StatelessWidget {
  final String title;
  final Widget child;

  const DashboardSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}
