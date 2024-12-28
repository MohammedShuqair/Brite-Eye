import 'dart:async';
import 'dart:math';

import 'package:brite_eye/core/extentions/color_theme.dart';
import 'package:flutter/material.dart';

class FollowBallScreen extends StatefulWidget {
  static const String id = '/follow_ball';

  @override
  _FollowBallScreenState createState() => _FollowBallScreenState();
}

class _FollowBallScreenState extends State<FollowBallScreen> {
  double ballX = 0.0;
  double ballY = 0.0;
  int score = 0;
  late Timer timer;
  double speed = 1.0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        ballX += (Random().nextDouble() - 0.5) * speed;
        ballY += (Random().nextDouble() - 0.5) * speed;

        // Keep the ball within screen bounds
        ballX = ballX.clamp(-1.0, 1.0);
        ballY = ballY.clamp(-1.0, 1.0);
      });
    });
  }

  void increaseScore() {
    setState(() {
      score++;
      speed += .1; // Increase speed as score increases
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: context.onPrimary,
        title:
            Text('Lazy Eye Game', style: TextStyle(color: context.onPrimary)),
        centerTitle: true,
        backgroundColor: context.primary,
      ),
      body: Stack(
        children: [
          // Score display
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              'Score: $score',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Moving ball
          AnimatedAlign(
            duration: Duration(milliseconds: 100),
            alignment: Alignment(ballX, ballY),
            child: GestureDetector(
              onTap: increaseScore,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
