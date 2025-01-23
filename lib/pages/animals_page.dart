import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimalsPage extends StatefulWidget {
  final String title;

  AnimalsPage(this.title);

  @override
  _AnimalsPageState createState() => _AnimalsPageState();
}

class _AnimalsPageState extends State<AnimalsPage> with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  String _currentAudioPath = '';
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _playAudio(String audioPath) async {
    try {
      if (_currentAudioPath == audioPath && _isPlaying) {
        _stopAudio();
      } else {
        await _audioPlayer.play(DeviceFileSource(audioPath));
        setState(() {
          _isPlaying = true;
          _currentAudioPath = audioPath;
        });
      }
    } catch (e) {
      print('Audio player error occurred: $e');
      setState(() {
        _isPlaying = false;
      });
      _showErrorDialog();
    }
  }

  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Audio Player Error'),
        content: Text('An error occurred while playing the audio.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimalTile(String animal, String audioPath, String imagePath) {
    return GestureDetector(
      onTap: () {
        _playAudio(audioPath);
        _animationController.forward().then((_) {
          _animationController.reverse();
        });
      },
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.1).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 252, 255),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 110),
              SizedBox(height: 12.0),
              Text(
                animal,
                style: GoogleFonts.poppins(
                  color: Color.fromARGB(255, 96, 95, 95),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (_currentAudioPath == audioPath && _isPlaying)
                const Icon(
                  Icons.volume_up,
                  color: Color.fromARGB(255, 48, 149, 80),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 243, 246),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          children: [
            _buildAnimalTile('Lion', 'assets/animals/audio_anim/lion.mp3', 'assets/animals/images_anim/lio.png'),
            _buildAnimalTile('Elephant', 'assets/animals/audio_anim/elephant.mp3', 'assets/animals/images_anim/ele.png'),
            _buildAnimalTile('Dog', 'assets/animals/audio_anim/dog_1.mp3', 'assets/animals/images_anim/do.png'),
            _buildAnimalTile('Horse', 'assets/animals/audio_anim/hours.mp3', 'assets/animals/images_anim/ho.png'),
            _buildAnimalTile('Tiger', 'assets/animals/audio_anim/tiger.mp3', 'assets/animals/images_anim/ti.png'),
            _buildAnimalTile('Butterfly', 'assets/animals/audio_anim/butterfly.mp3', 'assets/animals/images_anim/butt.png'),
          ],
        ),
      ),
    );
  }
}
