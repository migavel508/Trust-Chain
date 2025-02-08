import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:lottie/lottie.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

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


class PendingPaymentsScreen1 extends StatelessWidget {
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














class PendingPaymentsScreenv extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: PendingPaymentsScreen(),
    );
  }
}

class PendingPaymentsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending Payments"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Total Donations",
                    style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 58, 78, 6)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "₹1,20,000",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Withdraw & Refund Requests",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 123, 81, 196),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFBA68C8),
                        child: const Icon(Icons.account_circle, color: Colors.white),
                      ),
                      title: Text("Request #${index + 1}"),
                      subtitle: const Text("Pending Approval"),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 255, 106, 65),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("View"),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}












class PaymentHistoryScreen extends StatelessWidget {
  final List<Map<String, String>> paymentHistory = [
    {
      "Transaction ID": "TX2002",
      "Donor": "Fresh Supplies Pvt Ltd",
      "Amount": "\$3M",
      "Status": "Payment Released",
      "Proof of Delivery": "View Proof",
      "Profile Image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTo_R_vlnUz9UhylMPCccagw4dMqhbs4UMPAA&s",
      "pdf": "assets/qutation1.pdf"
    },
    {
      "Transaction ID": "TX2001",
      "Donor": "Global Exports Inc.",
      "Amount": "\$1.5M",
      "Status": "Payment Released",
      "Proof of Delivery": "View Proof",
      "Profile Image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSw1dZIvKfWd-BXu09e91cIUHgSjhhGWdviWR3g2RAPpv7sdECzaxfI5tPN5pJgf9oRsuk&usqp=CAU",
      "pdf" : "assets/qutation2.pdf"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Payment History", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: paymentHistory.length,
          itemBuilder: (context, index) {
            final transaction = paymentHistory[index];
            return Card(
              color: Colors.grey[900],
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    // Profile Image on the Left
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(transaction["Profile Image"]!),
                    ),
                    SizedBox(width: 16),
                    
                    // Transaction Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildDetailRow("Transaction ID:", transaction["Transaction ID"]!),
                          _buildDetailRow("Donor:", transaction["Donor"]!),
                          _buildDetailRow("Amount:", transaction["Amount"]!),
                          _buildDetailRow("Status:", transaction["Status"]!),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                           
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfViewerScreen(assetPath: transaction["pdf"]!),
                                    ),
                                  );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.tealAccent.withOpacity(0.2),
                              ),
                            
                              child: Text(
                                transaction["Proof of Delivery"]!,
                                style: TextStyle(
                                  color: Colors.tealAccent,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "$label ",
              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value, style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
class PdfViewerScreen extends StatefulWidget {
  final String assetPath;
  PdfViewerScreen({required this.assetPath});

  @override
  _PdfViewerScreenState createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    try {
      final byteData = await rootBundle.load(widget.assetPath);
      final tempDir = await getTemporaryDirectory();
      final tempFile = File('${tempDir.path}/temp.pdf');

      await tempFile.writeAsBytes(byteData.buffer.asUint8List());

      setState(() {
        localPath = tempFile.path;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading PDF: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Proof of Delivery", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: localPath == null
          ? Center(child: CircularProgressIndicator())
          : PDFView(filePath: localPath!),
    );
  }
}