import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GoodbyePage extends StatefulWidget {
  @override
  _GoodbyePageState createState() => _GoodbyePageState();
}

class _GoodbyePageState extends State<GoodbyePage> {
  int _counter = 3; // Timer countdown (seconds)
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer when the page loads
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
          SystemNavigator.pop();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animated Icon with size change
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 100.0),
                duration: Duration(seconds: 2),
                builder: (context, size, child) {
                  return Icon(
                    Icons.waving_hand,
                    size: size,
                    color: Colors.orange,
                  );
                },
              ),
              SizedBox(height: 20),

              // Animated Text with fading effect
              AnimatedOpacity(
                opacity: 1.0,
                duration: Duration(seconds: 2),
                child: Text(
                  'Goodbye!',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Another Animated Text with fade-in effect
              TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                duration: Duration(seconds: 2),
                builder: (context, opacity, child) {
                  return Opacity(
                    opacity: opacity,
                    child: Text(
                      'We\'re sad to see you go, but we wish you all the best ahead.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}