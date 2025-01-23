import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class NumbersPage extends StatefulWidget {
  final String title;

  NumbersPage(this.title);

  @override
  _NumbersPageState createState() => _NumbersPageState();
}

class _NumbersPageState extends State<NumbersPage> with SingleTickerProviderStateMixin {
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

  Widget _buildNumberTile(String number, String audioPath, String imagePath) {
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
                number,
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
            _buildNumberTile('1', 'assets/numbers/audio_num/kid-1.mp3', 'assets/numbers/images_num/1.png'),
            _buildNumberTile('2', 'assets/numbers/audio_num/kid-2.mp3', 'assets/numbers/images_num/2.png'),
            _buildNumberTile('3', 'assets/numbers/audio_num/kid-3.mp3', 'assets/numbers/images_num/3.png'),
            _buildNumberTile('4', 'assets/numbers/audio_num/kid-4.mp3', 'assets/numbers/images_num/4.png'),
            _buildNumberTile('5', 'assets/numbers/audio_num/kid-5.mp3', 'assets/numbers/images_num/5.png'),
            _buildNumberTile('6', 'assets/numbers/audio_num/kid-6.mp3', 'assets/numbers/images_num/6.png'),
            _buildNumberTile('7', 'assets/numbers/audio_num/kid-7.mp3', 'assets/numbers/images_num/7.png'),
            _buildNumberTile('8', 'assets/numbers/audio_num/kid-8.mp3', 'assets/numbers/images_num/8.png'),
            _buildNumberTile('9', 'assets/numbers/audio_num/kid-9.mp3', 'assets/numbers/images_num/9.png'),
            _buildNumberTile('10', 'assets/numbers/audio_num/kid-10.mp3', 'assets/numbers/images_num/10.png'),
          ],
        ),
      ),
    );
  }
}
