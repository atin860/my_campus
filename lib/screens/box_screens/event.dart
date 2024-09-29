import 'package:flutter/material.dart'; // Importing Flutter Material Design package
import 'package:flutter/services.dart'; // Importing for system services (e.g., setting orientation)
import 'package:get/get.dart'; // Importing GetX for state management and navigation
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart'; // Importing the YouTube player package

// Home screen with multiple YouTube cards
class EventScreen extends StatefulWidget {
  const EventScreen({super.key}); // Constructor for EventScreen

  @override
  State<EventScreen> createState() => _EventScreenState(); // Creating the state for EventScreen
}

class _EventScreenState extends State<EventScreen> {
  // Method to set the device orientation to portrait
  Future setPortrait() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  void initState() {
    setPortrait(); // Set orientation when the widget initializes
    super.initState(); // Call the superclass's initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: MyAppBar(
        
        title: "Avinya 2k23"), body: ListView( // A scrollable list of widgets
        padding: const EdgeInsets.all(20), // Padding around the ListView
        children: [
          Wrap( // A widget that displays its children in a wrap layout
            alignment: WrapAlignment.spaceBetween, // Align children
            children: [
              // Creating multiple YoutubeCard widgets with video IDs
              YoutubeCard(
                videoId: 'QFuVAlZF32o', // Video ID for the card
                onTap: () {
                  // Show VideoPlayerWidget dialog when tapped
                  Get.dialog(VideoPlayerWidget(videoId: 'QFuVAlZF32o'));
                },
                title: '2023-24', // Title for the card
              ),
              // Additional YoutubeCard instances
              YoutubeCard(
                videoId: 'kZPoA36JMug',
                onTap: () {
                  Get.dialog(VideoPlayerWidget(videoId: 'kZPoA36JMug'));
                },
                title: 'Srijan',
              ),
              YoutubeCard(
                videoId: 'ryoQ90JMO2k',
                onTap: () {
                  Get.dialog(VideoPlayerWidget(videoId: 'ryoQ90JMO2k'));
                },
                title: 'Srijan',
              ),
              YoutubeCard(
                videoId: 'kXXp1F2sCgo',
                onTap: () {
                  Get.dialog(VideoPlayerWidget(videoId: 'kXXp1F2sCgo'));
                },
                title: 'Abhishek Dixit Poetry',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget for the video player
class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key, required this.videoId}); // Constructor
  final String videoId; // Video ID to be played

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState(); // Creating the state for VideoPlayerWidget
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late YoutubePlayerController _controller; // YouTube player controller

  @override
  void initState() {
    super.initState();
    // Initialize the YouTube player controller with the video ID
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId, // Pass the video ID
      autoPlay: true, // Automatically play the video
      params: const YoutubePlayerParams( // Player parameters
        showFullscreenButton: true, // Show fullscreen button
        enableCaption: false, // Disable captions
        showControls: true // Show player controls
      ),
    );
  }

  Future setPortrait() async {
    // Method to set orientation to portrait
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    _controller.close(); // Close the controller when the widget is disposed
    super.dispose(); // Call the superclass's dispose method
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope( // Widget to handle back button action
      onWillPop: () async {
        Get.back(); // Navigate back
        setPortrait(); // Set portrait mode
        return true; // Allow back navigation
      },
      child: Scaffold(
        body: YoutubePlayerScaffold( // YouTube player scaffold
          controller: _controller, // Pass the controller
          builder: (context, player) {
            return Column( // Column to stack children
              children: [
                player, // YouTube player widget
                const SizedBox(height: 15), // Spacer
                GestureDetector(
                  onTap: () {
                    Get.back(); // Navigate back on tap
                    setPortrait(); // Set portrait mode
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10), // Padding inside container
                    decoration: BoxDecoration(
                      border: Border.all(), // Border around container
                      borderRadius: BorderRadius.circular(5), // Rounded corners
                    ),
                    child: const Text(
                      "Tap to back", // Back navigation text
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold), // Text style
                    ),
                  ),
                ),
                const SizedBox(height: 70), // Spacer
                const CircleAvatar( // Avatar for user
                  radius: 60.0,
                  backgroundImage: AssetImage('assets/img/atin.jpeg'), // User image
                ),
                const SizedBox(height: 20.0), // Spacer
                const Text(
                  'Atin Sharma', // User name
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold, // Text style
                  ),
                ),
                const SizedBox(height: 10.0), // Spacer
                const Text(
                  'Software Engineer', // User title
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Color.fromARGB(78, 5, 3, 2), // Text color
                  ),
                ),
                const SizedBox(height: 100), // Spacer
                const Text(
                  "This App is Developed By\nAtin Sharma\nContact for more information", // Developer info
                  textAlign: TextAlign.center, // Center text
                  style: TextStyle(fontSize: 10.0), // Text style
                ),
                const SizedBox(height: 10), // Spacer
                const Text(
                  "Version 0.0.1", // App version
                  style: TextStyle(color: Colors.red), // Text color
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Card Widget for showing video thumbnail and title
class YoutubeCard extends StatefulWidget {
  const YoutubeCard(
      {super.key,
      required this.videoId,
      required this.onTap,
      required this.title}); // Constructor for YoutubeCard
  final String videoId; // Video ID for the card
  final String title; // Title for the card
  final void Function() onTap; // Function to be called on tap

  @override
  State<YoutubeCard> createState() => _YoutubeCardState(); // Creating the state for YoutubeCard
}

class _YoutubeCardState extends State<YoutubeCard> {
  // Method to generate the correct YouTube thumbnail URL
  String getYoutubeThumbnail(String videoId) {
    // Return the thumbnail URL using the video ID
    return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap, // Call the onTap function when tapped
      child: Column(
        children: [
          Container(
            height: 150, // Height of the video thumbnail
            width: Get.width / 2.5, // Width based on device width
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), // Rounded corners
              image: DecorationImage(
                image: NetworkImage(
                  getYoutubeThumbnail(widget.videoId), // Get thumbnail image
                ),
                fit: BoxFit.cover, // Cover the container
              ),
            ),
          ),
          // const SizedBox(height: 5), // Uncomment for spacing if needed
          Text(
            widget.title, // Display the title of the video
            style: const TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 15), // Text style
          ),
          SizedBox(height: 15,) // Bottom spacing
        ],
      ),
    );
  }
}
