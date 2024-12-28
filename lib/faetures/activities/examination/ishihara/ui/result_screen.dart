import 'package:brite_eye/core/extentions/text_theme.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  static const id = '/result';

  const ResultScreen({super.key, required this.title, required this.score});

  final String title;

  final String score;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                title,
                style: context.headlineMedium,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Your score is ${score}',
                style: context.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
