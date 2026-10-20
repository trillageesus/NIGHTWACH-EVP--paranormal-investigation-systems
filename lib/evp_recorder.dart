
import 'package:flutter/material.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class EvpRecorder extends StatefulWidget {
  const EvpRecorder({super.key});

  @override
  State<EvpRecorder> createState() => _EvpRecorderState();
}

class _EvpRecorderState extends State<EvpRecorder> {
  final AudioRecorder _recorder = AudioRecorder();

  bool _isRecording = false;
  bool _isBusy = false;
  String _status = 'READY TO INVESTIGATE';
  String? _savedFile;

  Future<void> _toggleRecording() async {
    if (_isBusy) return;

    setState(() {
      _isBusy = true;
    });

    try {
      if (_isRecording) {
        final path = await _recorder.stop();

        if (!mounted) return;

        setState(() {
          _isRecording = false;
          _status = path == null ? 'RECORDING STOPPED' : 'EVIDENCE SAVED';
          _savedFile = path;
        });
      } else {
        final hasPermission = await _recorder.hasPermission();

        if (!hasPermission) {
          if (mounted) {
            setState(() {
              _status = 'MICROPHONE PERMISSION REQUIRED';
            });
          }
          return;
        }

        final directory = await getApplicationDocumentsDirectory();
        final folder = Directory('${directory.path}/NIGHTWATCH_EVP');

        await folder.create(recursive: true);

        final timestamp = DateTime.now()
            .toIso8601String()
            .replaceAll(':', '-');

        final filePath = '${folder.path}/EVP_$timestamp.m4a';

        await _recorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            sampleRate: 44100,
            bitRate: 128000,
          ),
          path: filePath,
        );

        if (!mounted) return;

        setState(() {
          _isRecording = true;
          _status = 'RECORDING IN PROGRESS';
          _savedFile = null;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _status = 'ERROR: $error';
          _isRecording = false;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF80FF72);

    return Scaffold(
      backgroundColor: const Color(0xFF080D09),
      appBar: AppBar(
        backgroundColor: const Color(0xFF111B12),
        title: const Text(
          'NIGHTWATCH // EVP',
          style: TextStyle(color: green, letterSpacing: 1.5),
        ),
        iconTheme: const IconThemeData(color: green),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.graphic_eq,
              color: green,
              size: 90,
            ),
            const SizedBox(height: 20),
            const Text(
              'AUDIO EVIDENCE UNIT',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF111B12),
                border: Border.all(color: green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    _status,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isRecording
                        ? 'Keep the microphone unobstructed.'
                        : 'Check your surroundings before recording.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: _isBusy ? null : _toggleRecording,
              style: FilledButton.styleFrom(
                backgroundColor:
                    _isRecording ? Colors.red.shade900 : green,
                foregroundColor:
                    _isRecording ? Colors.white : Colors.black,
                padding: const EdgeInsets.all(18),
              ),
              icon: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                size: 28,
              ),
              label: Text(
                _isBusy
                    ? 'PLEASE WAIT...'
                    : _isRecording
                        ? 'STOP RECORDING'
                        : 'START EVP RECORDING',
              ),
            ),
            const SizedBox(height: 20),
            if (_savedFile != null) ...[
              const Text(
                'SAVED RECORDING',
                style: TextStyle(color: green),
              ),
              const SizedBox(height: 8),
              SelectableText(
                _savedFile!,
                style: const TextStyle(color: Colors.white70),
              ),
            ],
            const Spacer(),
            const Text(
              'ORIGINAL AUDIO • LOCAL STORAGE',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: green,
                fontSize: 11,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
