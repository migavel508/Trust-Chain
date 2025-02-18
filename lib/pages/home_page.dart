import 'package:flutter/material.dart';  
import 'explore_page.dart';
void main() {
  runApp(ChangeMakerApp());
}

class ChangeMakerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: ChangeMakerHome(),
    );
  }
}

class ChangeMakerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFBB8EFF), Color(0xFFD4BBFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Hey, Changemaker!",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, color: Colors.purple[300]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "1 Cr+",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "lives saved",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "1.2M",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "kind donors",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Text(
                            "15,906",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18),
                          ),
                          Text(
                            "active campaigns",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InfoCard(icon: Icons.favorite, label: "Help anytime,\nanywhere"),
                      InfoCard(icon: Icons.shield, label: "Give with\ntrust"),
                      InfoCard(icon: Icons.receipt_long, label: "Get 80G tax\nbenefits"),
                    ],
                  ),
                  

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Make a Change →",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            // Featured Stories Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Featured stories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Start small and help those who most need it",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CategoryChip(label: "Medical", isSelected: true),
                      CategoryChip(label: "Animals"),
                      CategoryChip(label: "Education"),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CampaignCard(
                    title: "Only a drug worth Rs 4 crores can save my child...",
                    fundsRequired: "₹4,00,00,000",
                    daysLeft: "6 days left",
                    donorsCount: "1.5k",
                    imagePath: "assets/child_hospital.jpg",
                  ),
                  const SizedBox(height: 16),
                  CampaignCard(
                    title: "After a rare heart transplant, she needs support",
                    fundsRequired: "₹30,00,000",
                    daysLeft: "12 days left",
                    donorsCount: "392",
                    imagePath: "assets/heart_transplant.jpg",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: 0,
  selectedItemColor: Colors.purple,
  unselectedItemColor: Colors.grey,
  showUnselectedLabels: true,
  onTap: (index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ExplorePage()),
      );
    }
  },
  items: const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
    BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Feed"),
    BottomNavigationBarItem(icon: Icon(Icons.health_and_safety), label: "HealthFirst"),
    BottomNavigationBarItem(icon: Icon(Icons.monetization_on), label: "Donations"),
  ],
),

    );
  }
}

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const InfoCard({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: Colors.purple),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
      backgroundColor: isSelected ? Colors.teal : Colors.grey[200],
    );
  }
}

class CampaignCard extends StatelessWidget {
  final String title;
  final String fundsRequired;
  final String daysLeft;
  final String donorsCount;
  final String imagePath;

  const CampaignCard({
    required this.title,
    required this.fundsRequired,
    required this.daysLeft,
    required this.donorsCount,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(imagePath, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded( // This ensures the text wraps within the available space
      child: Text(
        "Funds Required: $fundsRequired",
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 14),
      ),
    ),
    const SizedBox(width: 8), // Adding spacing to avoid cramped UI
    Text(
      daysLeft,
      style: const TextStyle(color: Colors.red, fontSize: 14),
    ),
  ],
),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.person, size: 18, color: Colors.grey),
                      Text("$donorsCount people donated"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text("CONTRIBUTE"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}