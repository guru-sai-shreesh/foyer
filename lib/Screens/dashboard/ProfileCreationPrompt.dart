import 'package:flutter/material.dart';

class ProfileCreationPrompt extends StatelessWidget {
  final VoidCallback onCreateProfile;

  ProfileCreationPrompt({required this.onCreateProfile});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create Device Profile'),
      content:
          Text('Do you want to create a new device profile for this location?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onCreateProfile,
          child: Text('Create'),
        ),
      ],
    );
  }
}
