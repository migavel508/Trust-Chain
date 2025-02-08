import 'package:flutter/material.dart';
import 'package:trust/pages/admin_dashboard.dart';
import 'package:trust/pages/donor_dashboard.dart';
import 'package:trust/pages/home_page.dart';
import 'package:trust/pages/ngo_dashboard.dart';
import 'package:trust/pages/vendor_dashboard.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String selectedRole = "Donor"; // Default role
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleGoogleSignIn() {
    print("Google Sign-In Clicked for $selectedRole");

    Widget nextPage;
    switch (selectedRole) {
      case "Donor":
        nextPage = ChangeMakerHome();
        break;
      case "NGO":
        nextPage = NGODashboard();
        break;
      case "Vendor":
        nextPage = VendorDashboard();
        break;
      case "Admin":
        nextPage = AdminDashboard();
        break;
      default:
        nextPage = DonorDashboard();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }

  void _handleWeb3Auth() {
    // TODO: Implement Web3 Wallet authentication
    print("Web3 Wallet Clicked");
  }

  void _login() {
    // TODO: Implement email/password authentication
    print("Logging in as $selectedRole with email: ${emailController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: true, // Adjust screen when keyboard is open
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            // Make the content scrollable
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome to TrustChain",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Select your role to continue",
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),

                // Role Selection Dropdown
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  items: ["Donor", "NGO", "Vendor", "Admin"].map((role) {
                    return DropdownMenuItem(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Email Input
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 10),

                // Password Input
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Login",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                SizedBox(height: 20),

                // Divider
                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                SizedBox(height: 20),

                // Google Sign-In
                ElevatedButton.icon(
                  onPressed: _handleGoogleSignIn,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  icon: Image.asset("assets/google_logo.png", height: 24),
                  label: Text("Sign in with Google",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                SizedBox(height: 10),

                // Web3 Wallet Sign-In
                ElevatedButton.icon(
                  onPressed: _handleWeb3Auth,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(color: Colors.grey),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  icon: Icon(Icons.account_balance_wallet, color: Colors.blue),
                  label: Text("Sign in with Web3 Wallet",
                      style: TextStyle(fontSize: 16, color: Colors.black)),
                ),

                SizedBox(height: 20),

                // Sign Up Prompt
                Center(
                  child: TextButton(
                    onPressed: () {
                      // TODO: Navigate to Sign Up Screen
                    },
                    child: Text("Don't have an account? Sign up"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
