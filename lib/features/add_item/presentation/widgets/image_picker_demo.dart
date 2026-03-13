import 'package:flutter/material.dart';

class ImagePickerDemo extends StatelessWidget {
  const ImagePickerDemo({Key? key}) : super(key: key);

  // Function to trigger the BottomSheet
  void showImageSourceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:
          Colors.transparent, // Transparent to show custom container
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wraps to content height
                children: [
                  // --- Small drag handle ---
                  Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- Title ---
                  const Text(
                    "Select Image Source",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // --- Camera & Gallery Options ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOptionButton(
                        context: context,
                        icon: Icons.camera_alt_rounded,
                        label: "Camera",
                        color: Colors.blue,
                        onTap: () {
                          // Handle Camera selection
                          Navigator.pop(context, 'camera');
                          print("Camera selected");
                        },
                      ),
                      _buildOptionButton(
                        context: context,
                        icon: Icons.photo_library_rounded,
                        label: "Gallery",
                        color: Colors.purple,
                        onTap: () {
                          // Handle Gallery selection
                          Navigator.pop(context, 'gallery');
                          print("Gallery selected");
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper widget for the circular buttons
  Widget _buildOptionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1), // Soft tinted background
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bottom Sheet UI")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => showImageSourceBottomSheet(context),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Upload Photo"),
        ),
      ),
    );
  }
}
