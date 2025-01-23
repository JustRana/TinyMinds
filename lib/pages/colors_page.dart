import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorsPage extends StatefulWidget {
  final String title;

  ColorsPage(this.title);

  @override
  _ColorsPageState createState() => _ColorsPageState();
}

class _ColorsPageState extends State<ColorsPage> with SingleTickerProviderStateMixin {
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

  Widget _buildColorTile(String colorName, String audioPath, String imagePath) {
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
                colorName,
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
            _buildColorTile('Black', 'assets/colors/audio_colors/black.mp3', 'assets/colors/images_colors/black.png'),
            _buildColorTile('White', 'assets/colors/audio_colors/white.mp3', 'assets/colors/images_colors/white.png'),
            _buildColorTile('Blue', 'assets/colors/audio_colors/blue.mp3', 'assets/colors/images_colors/blue.png'),
            _buildColorTile('Green', 'assets/colors/audio_colors/green.mp3', 'assets/colors/images_colors/green.png'),
            _buildColorTile('Orange', 'assets/colors/audio_colors/orange.mp3', 'assets/colors/images_colors/orange.png'),
            _buildColorTile('Pink', 'assets/colors/audio_colors/pink.mp3', 'assets/colors/images_colors/pink.png'),
            _buildColorTile('Purple', 'assets/colors/audio_colors/purple.mp3', 'assets/colors/images_colors/purple.png'),
            _buildColorTile('Red', 'assets/colors/audio_colors/red.mp3', 'assets/colors/images_colors/red.png'),
            _buildColorTile('Yellow', 'assets/colors/audio_colors/yellow.mp3', 'assets/colors/images_colors/yellow.png'),
          ],
        ),
      ),
    );
  }
}
