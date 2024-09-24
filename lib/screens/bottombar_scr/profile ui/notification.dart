import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // Sample data for notifications
  final List<Map<String, String>> notifications = const [
    {
      "title": "New Message",
      "description": "You have a new message from John.",
      "time": "5 mins ago",
      "icon": "message"
    },
    {
      "title": "App Update",
      "description": "Version 2.0.1 is available. Update now!",
      "time": "20 mins ago",
      "icon": "update"
    },
    {
      "title": "Event Reminder",
      "description": "Your event starts at 6:00 PM today.",
      "time": "1 hour ago",
      "icon": "event"
    },
    {
      "title": "Security Alert",
      "description": "Login attempt from an unknown device.",
      "time": "2 hours ago",
      "icon": "security"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return NotificationCard(
            title: notifications[index]['title']!,
            description: notifications[index]['description']!,
            time: notifications[index]['time']!,
            icon: notifications[index]['icon']!,
          );
        },
      ),
    );
  }
}

// Custom Widget for Notification Cards
class NotificationCard extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final String icon;

  const NotificationCard({
    Key? key,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              _getIcon(icon), // Get the icon dynamically
              size: 40,
              color: Colors.blueAccent,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    time,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // A helper function to dynamically assign the icon
  IconData _getIcon(String icon) {
    switch (icon) {
      case 'message':
        return Icons.message;
      case 'update':
        return Icons.system_update;
      case 'event':
        return Icons.event;
      case 'security':
        return Icons.security;
      default:
        return Icons.notifications;
    }
  }
}
