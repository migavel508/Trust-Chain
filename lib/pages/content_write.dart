import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateCampaignPage(),
    );
  }
}

// ==================== Create Campaign Page ====================

class CreateCampaignPage extends StatefulWidget {
  @override
  _CreateCampaignPageState createState() => _CreateCampaignPageState();
}

class _CreateCampaignPageState extends State<CreateCampaignPage> {
  File? selectedImage;
  TextEditingController titleController = TextEditingController();
  TextEditingController fundsController = TextEditingController();
  TextEditingController daysLeftController = TextEditingController();
  TextEditingController donorsController = TextEditingController();

  Future<void> pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        selectedImage = File(result.files.single.path!);
      });
    }
  }

  Future<void> saveCampaign() async {
    if (selectedImage == null || titleController.text.isEmpty || fundsController.text.isEmpty || daysLeftController.text.isEmpty || donorsController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields and upload an image!")),
      );
      return;
    }

    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/campaigns.json';

    Map<String, dynamic> campaign = {
      "title": titleController.text,
      "fundsRequired": fundsController.text,
      "daysLeft": daysLeftController.text,
      "donorsCount": donorsController.text,
      "imagePath": selectedImage!.path
    };

    File file = File(filePath);
    List<Map<String, dynamic>> data = [];

    if (await file.exists()) {
      String existingContent = await file.readAsString();
      if (existingContent.isNotEmpty) {
        data = List<Map<String, dynamic>>.from(json.decode(existingContent));
      }
    }

    data.add(campaign);
    await file.writeAsString(json.encode(data));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Campaign Saved Successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a Campaign")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImage,
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: selectedImage == null
                    ? Center(child: Text("Tap to upload an image"))
                    : Image.file(selectedImage!, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 20),
            TextField(controller: titleController, decoration: InputDecoration(labelText: "Campaign Title", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(controller: fundsController, decoration: InputDecoration(labelText: "Funds Required", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(controller: daysLeftController, decoration: InputDecoration(labelText: "Days Left", border: OutlineInputBorder())),
            SizedBox(height: 10),
            TextField(controller: donorsController, decoration: InputDecoration(labelText: "Donors Count", border: OutlineInputBorder())),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveCampaign,
              child: Text("Submit"),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewCampaignsPage()),
              ),
              child: Text("View Campaigns"),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== View Campaigns Page ====================

class ViewCampaignsPage extends StatefulWidget {
  @override
  _ViewCampaignsPageState createState() => _ViewCampaignsPageState();
}

class _ViewCampaignsPageState extends State<ViewCampaignsPage> {
  List<Map<String, dynamic>> campaigns = [];

  @override
  void initState() {
    super.initState();
    loadCampaigns();
  }

  Future<void> loadCampaigns() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/campaigns.json';
    File file = File(filePath);

    if (await file.exists()) {
      String content = await file.readAsString();
      if (content.isNotEmpty) {
        setState(() {
          campaigns = List<Map<String, dynamic>>.from(json.decode(content));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Saved Campaigns")),
      body: campaigns.isEmpty
          ? Center(child: Text("No saved campaigns found!"))
          : ListView.builder(
              itemCount: campaigns.length,
              itemBuilder: (context, index) {
                return CampaignCardU(
                  title: campaigns[index]['title'],
                  fundsRequired: campaigns[index]['fundsRequired'],
                  daysLeft: campaigns[index]['daysLeft'],
                  donorsCount: campaigns[index]['donorsCount'],
                  imagePath: campaigns[index]['imagePath'],
                );
              },
            ),
    );
  }
}

// ==================== Campaign Card Widget ====================

class CampaignCardU extends StatelessWidget {
  final String title;
  final String fundsRequired;
  final String daysLeft;
  final String donorsCount;
  final String imagePath;

  CampaignCardU({required this.title, required this.fundsRequired, required this.daysLeft, required this.donorsCount, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.file(File(imagePath), width: double.infinity, height: 200, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("Funds Required: $fundsRequired", style: TextStyle(fontSize: 16, color: Colors.red)),
                Text("Days Left: $daysLeft", style: TextStyle(fontSize: 14)),
                Text("Donors: $donorsCount", style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
