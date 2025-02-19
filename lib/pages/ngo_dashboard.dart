import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:trust/pages/content_write.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: NGODashboard(),
  ));
}

class NGODashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Dark background for a glossy look
      appBar: AppBar(
        title: Text(
          'NGO Dashboard',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
        elevation: 10,
        shadowColor: Colors.tealAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fund Requests with Advanced Tracking UI
              DashboardSection(
                title: "Fund Requests",
                child: Column(
                  children: [
                    GlossyButton(
                      text: "Submit Fund Request",
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),
                    FundTrackingUI(),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Project Progress Updates Section
              DashboardSection(
                title: "Project Progress Updates",
                child: Column(
                  children: [
                    GlossyButton(
                      text: "Upload Quotation",
                      icon: Icons.upload_file,
                      onPressed: () {
                        uploadDocument(context);
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Upload photos, receipts, and documents to update project progress.",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Transaction Ledger Section
              DashboardSection(
                title: "Transaction Ledger",
                child: Column(
                  children: [
                    TransactionTile(id: "#12345", purpose: "Supplies - \$500"),
                    TransactionTile(
                        id: "#67890", purpose: "Infrastructure - \$1200"),
                    GlossyButton(
                      text: "View All Transactions",
                      onPressed: () {},
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
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: 0.85,
                      backgroundColor: Colors.grey[800],
                      color: Colors.teal,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your spending is efficient. Keep up the great work!",
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              

               DashboardSection(
                title: "Create Need",
                child: Column(
                  children: [
                    TransactionTile(id: "#12345", purpose: "Supplies - \$500"),
                    TransactionTile(
                        id: "#67890", purpose: "Infrastructure - \$1200"),
                    GlossyButton(
                      text: "Raise a Need",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreateCampaignPage()),
                        );
                      },
                    ),
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

// 🚀 Glossy Button with Rain Drop Effect
class GlossyButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const GlossyButton({required this.text, this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.teal, Colors.blueAccent]),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.teal.withOpacity(0.5),
                blurRadius: 12,
                spreadRadius: 2),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: Colors.white, size: 22),
            if (icon != null) SizedBox(width: 10),
            Text(
              text,
              style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

// 📍 Fund Tracking Timeline UI
class FundTrackingUI extends StatelessWidget {
  final List<String> steps = [
    "Fund Request Date",
    "Validation",
    "Fund Release",
    "Fund Utilization",
    "Report Sending"
  ];
  final int currentStep = 2; // Example: Fund Release in Progress

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(steps.length, (index) {
        return TimelineTile(
          alignment: TimelineAlign.manual,
          lineXY: 0.2,
          isFirst: index == 0,
          isLast: index == steps.length - 1,
          beforeLineStyle: LineStyle(
            color: index < currentStep ? Colors.teal : Colors.grey,
            thickness: 3,
          ),
          indicatorStyle: IndicatorStyle(
            width: 20,
            color: index == currentStep ? Colors.teal : Colors.grey,
            indicator: index == currentStep
                ? BlinkingDot() // Blinking effect
                : Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index < currentStep ? Colors.teal : Colors.grey),
                  ),
          ),
          endChild: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              steps[index],
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: index == currentStep ? Colors.teal : Colors.white70,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    );
  }
}

// 🔴 Blinking Dot for Live Step Indicator
class BlinkingDot extends StatefulWidget {
  @override
  _BlinkingDotState createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose(); // ✅ Properly dispose the animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation, // ✅ Ensures the UI updates when animation changes
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: 20,
            height: 20,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
          ),
        );
      },
    );
  }
}

// 💰 Transaction Tile
class TransactionTile extends StatelessWidget {
  final String id, purpose;

  const TransactionTile({required this.id, required this.purpose});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.receipt_long, color: Colors.teal),
      title: Text(id,
          style: GoogleFonts.poppins(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      subtitle: Text(purpose,
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)),
    );
  }
}

// 📦 Dashboard Section
class DashboardSection extends StatelessWidget {
  final String title;
  final Widget child;

  const DashboardSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

void uploadDocument(BuildContext context) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
  );

  if (result != null) {
    File file = File(result.files.single.path!);

    // Show AI Validation UI for 0.5 seconds before proceeding
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return _buildAIDetectionLoadingCard();
      },
    );

    await Future.delayed(
        Duration(milliseconds: 3000)); // Simulate AI validation time
    Navigator.pop(context); // Close the AI validation modal

    // Now proceed with the actual upload
    String url = "http://192.168.27.18:8000/upload";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> responseData = json.decode(responseBody);

      String ipfsUrl = responseData['ipfs_url'] ?? "No URL found";
      String transactionHash = responseData['transaction_hash'] ?? "N/A";
      String ipfsHash = extractCidFromUrl(ipfsUrl);

      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) {
          return _buildUploadSuccessCard(ipfsHash, transactionHash, context);
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('File upload failed! ❌'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } else {
    print("No file selected.");
  }
}

// AI Validation Card with Skeleton Loading Effect
Widget _buildAIDetectionLoadingCard() {
  return Container(
    padding: EdgeInsets.all(16),
    height: 200,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade200, Colors.blue.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.2),
          blurRadius: 10,
          spreadRadius: 3,
          offset: Offset(0, -5),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: Colors.white,
          strokeWidth: 5,
        ),
        SizedBox(height: 20),
        Text(
          "AI Validation Starting...",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

// Function to extract CID from the IPFS URL
String extractCidFromUrl(String ipfsUrl) {
  Uri uri = Uri.parse(ipfsUrl);
  List<String> segments = uri.pathSegments;

  if (segments.isNotEmpty) {
    return segments.last; // CID is usually the last part of the URL
  }

  return "No CID found";
}

Widget _buildUploadSuccessCard(
    String ipfsHash, String transactionHash, BuildContext context) {
  return Container(
    padding: EdgeInsets.all(16),
    height: 270,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.blue.shade200], // Smooth color blend
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30), // Rounded top-left corner
        topRight: Radius.circular(30), // Rounded top-right corner
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withOpacity(0.2),
          blurRadius: 10,
          spreadRadius: 3,
          offset: Offset(0, -5),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8), // Glassmorphism effect
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle bar
            Center(
              child: Container(
                width: 50,
                height: 5,
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            // Upload Success Text
            Text(
              "Upload Successful 🎉",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            SizedBox(height: 12),

            // UPI-style Icons & Information
            _buildInfoRow(Icons.cloud_done_rounded, "IPFS CID: $ipfsHash",
                Colors.blue.shade600),
            SizedBox(height: 8),
            _buildInfoRow(Icons.verified_rounded,
                "Transaction Hash: $transactionHash", Colors.green.shade600),

            Spacer(),

            // Buttons (Close & View Details)
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Close",
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("View Details",
                        style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

// Helper function for UPI-style icons & row UI
Widget _buildInfoRow(IconData icon, String text, Color iconColor) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: iconColor.withOpacity(0.2),
        ),
        child: Icon(icon, color: iconColor, size: 22),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
