
import 'package:flutter/material.dart';

void main() {
  runApp(const NightwatchApp());
}

class NightwatchApp extends StatelessWidget {
  const NightwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NIGHTWATCH EVP',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF080D09),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF80FF72),
          secondary: Color(0xFFB5FF9B),
        ),
      ),
      home: const NightwatchHome(),
    );
  }
}

class NightwatchHome extends StatelessWidget {
  const NightwatchHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF111B12),
        title: const Text(
          'NIGHTWATCH EVP',
          style: TextStyle(
            color: Color(0xFF80FF72),
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'PARANORMAL FIELD UNIT',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF80FF72),
                  letterSpacing: 3,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFF111B12),
                  border: Border.all(
                    color: const Color(0xFF426D3B),
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.graphic_eq,
                      color: Color(0xFF80FF72),
                      size: 64,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'INVESTIGATION READY',
                      style: TextStyle(
                        color: Color(0xFF80FF72),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Audio • Video • Evidence Analysis',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _toolButton(
                Icons.mic,
                'EVP AUDIO RECORDER',
                'Record unexplained sounds',
              ),
              const SizedBox(height: 12),
              _toolButton(
                Icons.videocam,
                'VIDEO EVIDENCE',
                'Capture investigation footage',
              ),
              const SizedBox(height: 12),
              _toolButton(
                Icons.sensors,
                'FIELD SENSORS',
                'Explore supported phone sensors',
              ),
              const SizedBox(height: 12),
              _toolButton(
                Icons.folder_open,
                'EVIDENCE ARCHIVE',
                'Review saved investigations',
              ),
              const Spacer(),
              const Text(
                'SYSTEM ONLINE  •  LOCAL SESSION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF80FF72),
                  fontSize: 11,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _toolButton(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111B12),
        border: Border.all(
          color: const Color(0xFF304A2D),
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF80FF72), size: 30),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF80FF72),
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white60, fontSize: 12),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Color(0xFF80FF72),
        ),
      ),
    );
  }
}
