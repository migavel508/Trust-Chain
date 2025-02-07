import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DonorDashboard extends StatefulWidget {
  @override
  _DonorDashboardState createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text("Donor Dashboard", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Donation Overview
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              elevation: 5,
              color: Colors.green[700],
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "Donation Overview",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _overviewTile("Total Donations", "\$12,500"),
                        _overviewTile("Ongoing", "\$3,200"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Available NGOs
            Text("Available NGOs", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _ngoCard("Clean Water Project", "Providing clean water to rural areas.", "80%"),
            _ngoCard("Food for All", "Feeding underprivileged communities.", "65%"),
            _ngoCard("Healthcare Access", "Medical help for remote villages.", "50%"),
            SizedBox(height: 20),

            // Donation Tracking
            Text("Donation Tracking", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _trackingTile("Transaction ID: 0x1234abc", "Completed", Colors.green),
            _trackingTile("Transaction ID: 0x5678def", "Pending", Colors.orange),
            _trackingTile("Transaction ID: 0x9876xyz", "Failed", Colors.red),
            SizedBox(height: 20),

            // AI-Powered Impact Reports
            Text("AI-Powered Impact Reports", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            _impactReportTile("Your donation to 'Food for All' provided meals for 500 families."),
            _impactReportTile("Your support for 'Healthcare Access' helped vaccinate 200 children."),
            SizedBox(height: 20),

            // Withdraw & Refund Requests
            Text("Withdraw & Refund Requests", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            SizedBox(height: 10),
            _refundRequestTile("Healthcare Access", "Funds not utilized properly"),
            _refundRequestTile("Food for All", "Delayed project execution"),
          ],
        ),
      ),
    );
  }

  Widget _overviewTile(String title, String amount) {
    return Column(
      children: [
        Text(amount, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        SizedBox(height: 5),
        Text(title, style: TextStyle(fontSize: 14, color: Colors.white)),
      ],
    );
  }

  Widget _ngoCard(String title, String description, String progress) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          subtitle: Text(description),
          trailing: Container(
            width: 50,
            height: 50,
            child: CircularPercentIndicator(
              radius: 25.0,
              lineWidth: 5.0,
              percent: double.parse(progress.replaceAll("%", "")) / 100,
              center: Text(progress, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              progressColor: Colors.green,
            ),
          ),
        ),
      ),
    );
  }

  Widget _trackingTile(String transaction, String status, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: ListTile(
        title: Text(transaction),
        trailing: Text(status, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }

  Widget _impactReportTile(String report) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: Colors.blue[50],
      child: ListTile(
        leading: Icon(Icons.insights, color: Colors.blue),
        title: Text(report),
      ),
    );
  }

  Widget _refundRequestTile(String project, String reason) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: Colors.red[50],
      child: ListTile(
        leading: Icon(Icons.warning, color: Colors.red),
        title: Text(project, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(reason),
      ),
    );
  }
}
