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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Donor Dashboard", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Color(0xFF009688),
        elevation: 5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCard(
              title: "Donation Overview",
              buttonText: "View Details",
              buttonColor: [Color(0xFF009688), Color(0xFF2196F3)],
              content: "Total Donations: \$12,500\nOngoing: \$3,200",
              icon: Icons.monetization_on,
            ),
            SizedBox(height: 20),
            _sectionTitle("Available NGOs"),
            _ngoCard("Clean Water Project", "Providing clean water to rural areas.", 0.8),
            _ngoCard("Food for All", "Feeding underprivileged communities.", 0.65),
            _ngoCard("Healthcare Access", "Medical help for remote villages.", 0.5),
            SizedBox(height: 20),
            _buildTransactionTracking(),
            SizedBox(height: 20),
            _buildImpactReports(),
            SizedBox(height: 20),
            _sectionTitle("Withdraw & Refund Requests", color: Colors.redAccent),
            _refundRequestTile("Healthcare Access", "Funds not utilized properly"),
            _refundRequestTile("Food for All", "Delayed project execution"),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({required String title, required String buttonText, required List<Color> buttonColor, required String content, required IconData icon}) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 15),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: buttonColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton.icon(
                onPressed: () {},
                icon: Icon(icon, color: Colors.white),
                label: Text(buttonText, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            SizedBox(height: 10),
            Text(content, style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, {Color color = Colors.white}) {
    return Text(
      title,
      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
    );
  }

Widget _ngoCard(String title, String description, double progress) {
  return Card(
    color: Colors.grey[900],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    elevation: 5,
    margin: EdgeInsets.symmetric(vertical: 10),
    child: ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Text(description, style: TextStyle(color: Colors.white70)),
      ),
      trailing: SizedBox(
        width: 50, // Fix the width to prevent overflow
        height: 50, // Fix the height to match the width
        child: CircularPercentIndicator(
          radius: 25.0, // Adjust radius to fit within the container
          lineWidth: 6.0,
          percent: progress,
          center: Text(
            "${(progress * 100).toInt()}%", 
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),
          ),
          progressColor: Colors.greenAccent,
          backgroundColor: Colors.grey[700]!,
        ),
      ),
    ),
  );
}




  Widget _refundRequestTile(String project, String reason) {
    return Card(
      color: Colors.red[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      shadowColor: Colors.redAccent.withOpacity(0.3),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 30),
        title: Text(project, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Text(reason),
      ),
    );
  }
Widget _buildTransactionTracking() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Donation Tracking", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 15),
            _transactionItem("0x1234abc", "Completed", Colors.greenAccent),
            _transactionItem("0x5678def", "Pending", Colors.orangeAccent),
            _transactionItem("0x9876xyz", "Failed", Colors.redAccent),
          ],
        ),
      ),
    );
  }

  Widget _transactionItem(String id, String status, Color statusColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(Icons.receipt_long, color: Colors.white),
          SizedBox(width: 10),
          Text("Transaction ID: $id", style: TextStyle(color: Colors.white)),
          Spacer(),
          Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildImpactReports() {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("AI-Powered Impact Reports", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(height: 15),
            _impactReportItem("Your donation to 'Food for All' provided meals for 500 families."),
            _impactReportItem("Your support for 'Healthcare Access' helped vaccinate 200 children."),
          ],
        ),
      ),
    );
  }

  Widget _impactReportItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(Icons.auto_graph, color: Colors.blueAccent),
          SizedBox(width: 10),
          Expanded(
            child: Text(text, style: TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}  
