import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';

class VendorDashboard extends StatefulWidget {
  @override
  _VendorDashboardState createState() => _VendorDashboardState();
}

class _VendorDashboardState extends State<VendorDashboard> {
  List<String> pendingPayments = ["Order #123 - \$500", "Order #124 - \$750"];
  List<String> paymentHistory = ["Order #120 - \$300 (Completed)", "Order #121 - \$450 (Completed)"];
  File? selectedFile;

  void _uploadProof() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        String? filePath = result.files.single.path;

        if (filePath != null && filePath.isNotEmpty) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuccessScreen(fileName: filePath.split('/').last),
            ),
          );
        } else {
          _showErrorMessage("File selection failed.");
        }
      } else {
        _showErrorMessage("No file selected.");
      }
    } catch (e) {
      _showErrorMessage("Error selecting file: $e");
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Vendor Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCard(
              title: "Submit Proof of Delivery",
              description: "Upload invoices, images, GPS location.",
              buttonText: "Upload Proof",
              icon: Icons.cloud_upload,
              onPressed: _uploadProof,
            ),
            _buildCard(
              title: "Pending Payments",
              description: "Check smart contract fund releases.",
              buttonText: "View Pending",
              icon: Icons.pending_actions,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PendingPaymentsScreen()),
                );
              },
            ),
            _buildCard(
              title: "Blockchain Payment History",
              description: "See real-time updates on payments received.",
              buttonText: "View History",
              icon: Icons.account_balance_wallet,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PaymentHistoryScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String description,
    required String buttonText,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 5,
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
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(color: Colors.white70, fontSize: 14),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: onPressed,
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [Colors.tealAccent, Colors.blueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.tealAccent.withOpacity(0.6),
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

class SuccessScreen extends StatelessWidget {
  final String fileName;
  SuccessScreen({required this.fileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/success.json', // Place a success animation JSON file in assets
              width: 150,
              height: 150,
              repeat: false,
            ),
            SizedBox(height: 20),
            Text(
              "Upload Successful!",
              style: TextStyle(color: Colors.tealAccent, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "File: $fileName",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Back to Dashboard"),
            ),
          ],
        ),
      ),
    );
  }
}

class PendingPaymentsScreen extends StatelessWidget {
  final List<String> pendingPayments = [
    "Order #123 - \$500",
    "Order #124 - \$750",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Pending Payments", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: pendingPayments.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: ListTile(
                title: Text(pendingPayments[index], style: TextStyle(color: Colors.white)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PaymentHistoryScreen extends StatelessWidget {
  final List<String> paymentHistory = [
    "Order #120 - \$300 (Completed)",
    "Order #121 - \$450 (Completed)",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Payment History", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: paymentHistory.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: ListTile(
                title: Text(paymentHistory[index], style: TextStyle(color: Colors.white)),
              ),
            );
          },
        ),
      ),
    );
  }
}
