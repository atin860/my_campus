import 'package:flutter/material.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';

class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // Variables to hold toggle states
  bool _locationTracking = true;
  bool _profileVisibility = false;
  bool _dataSharing = true;
  bool _adsPersonalization = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: kScaffoldColor,
      appBar: MyAppBar(title: "Privacy Setting",titleAlignment: TextAlign.center,),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildHeader(context),
          const SizedBox(height: 20),
          _buildPrivacySettingsList(context),
        ],
      ),
    );
  }

  // Widget for Privacy Settings Header
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: const [
          Icon(
            Icons.privacy_tip,
            size: 80,
            color: Colors.white,
          ),
          SizedBox(height: 15),
          Text(
            'Privacy Settings',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Manage your privacy preferences',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  // Widget to display Privacy Settings as list
  Widget _buildPrivacySettingsList(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildSwitchTile(
            icon: Icons.location_on,
            title: "Location Tracking",
            subtitle: "Allow apps to track your location",
            value: _locationTracking,
            onChanged: (bool value) {
              setState(() {
                _locationTracking = value;
              });
            },
          ),
          _buildSwitchTile(
            icon: Icons.visibility,
            title: "Profile Visibility",
            subtitle: "Control who can see your profile",
            value: _profileVisibility,
            onChanged: (bool value) {
              setState(() {
                _profileVisibility = value;
              });
            },
          ),
          _buildSwitchTile(
            icon: Icons.share,
            title: "Data Sharing",
            subtitle: "Share data with third-party services",
            value: _dataSharing,
            onChanged: (bool value) {
              setState(() {
                _dataSharing = value;
              });
            },
          ),
          _buildSwitchTile(
            icon: Icons.ad_units,
            title: "Ads Personalization",
            subtitle: "Use your data to personalize ads",
            value: _adsPersonalization,
            onChanged: (bool value) {
              setState(() {
                _adsPersonalization = value;
              });
            },
          ),
        ],
      ),
    );
  }

  // Helper function to build each switch tile
  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: SwitchListTile(
        activeColor: Colors.blueAccent,
        inactiveThumbColor: Colors.grey,
        secondary: Icon(icon, size: 30, color: Colors.blueAccent),
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 15, color: Colors.black54),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
