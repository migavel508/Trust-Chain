import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ExplorePage(),
  ));
}

class ExplorePage extends StatelessWidget {
  final List<Map<String, String>> contributorData = [
    {'image': 'assets/profile1.jpg', 'name': 'Alice'},
    {'image': 'assets/profile2.jpg', 'name': 'Bob'},
    {'image': 'assets/profile3.jpg', 'name': 'Charlie'},
    {'image': 'assets/profile4.jpg', 'name': 'David'},
    {'image': 'assets/profile5.jpg', 'name': 'Eve'},
  ];

  final List<Map<String, String>> campaignData = [
    {
      'image': 'assets/child_hospital.jpg',
      'title': 'Urgent Surgery Needed for 3-Year-Old Girl',
      'funds': '₹8,00,000',
      'daysLeft': '5 days left'
    },
    {
      'image': 'assets/child_hospital.jpg',
      'title': 'Help Stray Dogs Get Medical Treatment',
      'funds': '₹2,50,000',
      'daysLeft': '10 days left'
    },
  ];

  final List<Map<String, String>> monthlyGivingData = [
    {
      'image': 'assets/education_help.jpg',
      'title': 'Education For All',
      'description': 'Educate a child and empower them for life',
      'donors': '53L Donors'
    },
    {
      'image': 'assets/education_help.jpg',
      'title': 'Feed India’s Children',
      'description': 'Free starving children in India from hunger',
      'donors': '62L Donors'
    },
    {
      'image': 'assets/education_help.jpg',
      'title': 'Children\'s Education',
      'description': 'Support kids with educational resources',
      'donors': '45L Donors'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Explore Causes"),
        backgroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print("Search clicked!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contributors Section
              Text(
                "Contributors",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: contributorData.map((contributor) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(contributor['image']!),
                          ),
                          SizedBox(height: 5),
                          Text(contributor['name']!)
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              // Latest News (Campaign Cards)
              Text(
                "Latest News",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: campaignData.map((campaign) {
                    return Container(
                      width: 280,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              spreadRadius: 2)
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.asset(
                              campaign['image']!,
                              height: 160,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  campaign['title']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(height: 5),
                                Text("Funds: ${campaign['funds']}"),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.access_time, color: Colors.red),
                                    SizedBox(width: 5),
                                    Text(campaign['daysLeft']!,
                                        style: TextStyle(color: Colors.redAccent)),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),

              // Contribute to Causes
              Text(
                'Contribute to causes you believe in',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                padding: EdgeInsets.all(10),
                children: [
                  _buildGridItem(Icons.favorite, 'Medical'),
                  _buildGridItem(Icons.pets, 'Animals'),
                  _buildGridItem(Icons.school, 'Education'),
                  _buildGridItem(Icons.people, 'Community Development'),
                  _buildGridItem(Icons.candlestick_chart, 'Memorial'),
                  _buildGridItem(Icons.lightbulb, 'Creative'),
                ],
              ),
              SizedBox(height: 20),

              // Monthly Giving Section
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[50],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Monthly Giving",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: monthlyGivingData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1.6,
                      ),
                      itemBuilder: (context, index) {
                        final item = monthlyGivingData[index];
                        return _buildMonthlyCard(item);
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

  Widget _buildGridItem(IconData icon, String title) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.blue),
          SizedBox(height: 5),
          Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMonthlyCard(Map<String, String> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5, spreadRadius: 2)
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(item['image']!, height: 80, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['title']!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                SizedBox(height: 5),
                Text(item['description']!, style: TextStyle(fontSize: 12)),
                SizedBox(height: 5),
                Text(item['donors']!, style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
