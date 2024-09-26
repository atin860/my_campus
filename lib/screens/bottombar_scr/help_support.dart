import 'package:flutter/material.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  // Function to open URL (for help articles, FAQs, etc.)
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support',style: kLabelTextStyle,),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Help Section
            const Text(
              "Help & Support",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // FAQ Button
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.blueAccent),
              title: const Text('FAQ'),
              subtitle: const Text('Frequently Asked Questions'),
              onTap: () {
                _launchURL("https://www.example.com/faqs"); // Change URL as needed
              },
            ),
            const Divider(),
            // Contact Support Button
            ListTile(
              leading: const Icon(Icons.support_agent, color: Colors.blueAccent),
              title: const Text('Contact Support'),
              subtitle: const Text('Reach out to us for assistance'),
              onTap: () {
                _launchURL("mailto:support@example.com"); // Example contact email
              },
            ),
            const Divider(),
            // Report an Issue
            ListTile(
              leading: const Icon(Icons.report_problem, color: Colors.orangeAccent),
              title: const Text('Report an Issue'),
              subtitle: const Text('Let us know if you encountered a problem'),
              onTap: () {
                _launchURL("mailto:support@example.com?subject=Issue%20Report"); // Pre-filled email
              },
            ),
            const Divider(),
            // Send Feedback
            ListTile(
              leading: const Icon(Icons.feedback_outlined, color: Colors.green),
              title: const Text('Send Feedback'),
              subtitle: const Text('Tell us what you think'),
              onTap: () {
                _launchURL("mailto:support@example.com?subject=Feedback"); // Pre-filled email
              },
            ),
            const Divider(),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  _launchURL("https://www.example.com/help"); // Example help center URL
                },
                icon: const Icon(Icons.public),
                label: const Text("Visit Our Help Center"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
