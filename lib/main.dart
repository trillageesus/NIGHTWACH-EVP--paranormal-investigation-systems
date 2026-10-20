
import 'package:flutter/material.dart';

void main() {
  runApp(const EVPVideoApp());
}

class EVPVideoApp extends StatelessWidget {
  const EVPVideoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EVP Video App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const EVPHomePage(),
    );
  }
}

class EVPHomePage extends StatefulWidget {
  const EVPHomePage({super.key});

  @override
  State<EVPHomePage> createState() => _EVPHomePageState();
}

class _EVPHomePageState extends State<EVPHomePage> {
  bool isRecording = false;
  String status = 'Ready to begin';

  void startRecording() {
    setState(() {
      isRecording = true;
      status = 'Recording session started';
    });
  }

  void stopRecording() {
    setState(() {
      isRecording = false;
      status = 'Session stopped';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EVP Video App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.videocam,
                size: 90,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              const Text(
                'Paranormal Investigation',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Capture and review your investigation sessions.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              Text(
                status,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              if (!isRecording)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: startRecording,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Start Session'),
                  ),
                )
              else
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: stopRecording,
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop Session'),
                  ),
                ),
              const SizedBox(height: 16),
              const Text(
                'Recording controls are a prototype. '
                'Camera and microphone capture will be added next.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
