import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

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
                      text: "Upload Proof of Work",
                      icon: Icons.upload_file,
                      onPressed: () {},
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
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _animation.value,
      duration: Duration(milliseconds: 500),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.teal),
      ),
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
