import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class LettersPage extends StatefulWidget {
  final String title;

  LettersPage(this.title);

  @override
  _LettersPageState createState() => _LettersPageState();
}

class _LettersPageState extends State<LettersPage> with SingleTickerProviderStateMixin {
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

  Widget _buildLetterTile(String letter, String audioPath, String imagePath) {
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
                letter,
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
            _buildLetterTile('A', 'assets/letters/audio/kid-a.mp3', 'assets/letters/images_letters/A.png'),
            _buildLetterTile('B', 'assets/letters/audio/kid-b.mp3', 'assets/letters/images_letters/B.png'),
            _buildLetterTile('C', 'assets/letters/audio/kid-c.mp3', 'assets/letters/images_letters/C.png'),
            _buildLetterTile('D', 'assets/letters/audio/kid-d.mp3', 'assets/letters/images_letters/D.png'),
            _buildLetterTile('E', 'assets/letters/audio/kid-e.mp3', 'assets/letters/images_letters/E.png'),
            _buildLetterTile('F', 'assets/letters/audio/kid-f.mp3', 'assets/letters/images_letters/F.png'),
            _buildLetterTile('G', 'assets/letters/audio/kid-g.mp3', 'assets/letters/images_letters/G.png'),
            _buildLetterTile('H', 'assets/letters/audio/kid-h.mp3', 'assets/letters/images_letters/H.png'),
            _buildLetterTile('I', 'assets/letters/audio/kid-i.mp3', 'assets/letters/images_letters/I.png'),
            _buildLetterTile('J', 'assets/letters/audio/kid-j.mp3', 'assets/letters/images_letters/J.png'),
            _buildLetterTile('K', 'assets/letters/audio/kid-k.mp3', 'assets/letters/images_letters/K.png'),
            _buildLetterTile('L', 'assets/letters/audio/kid-l.mp3', 'assets/letters/images_letters/L.png'),
            _buildLetterTile('M', 'assets/letters/audio/kid-m.mp3', 'assets/letters/images_letters/M.png'),
            _buildLetterTile('N', 'assets/letters/audio/kid-n.mp3', 'assets/letters/images_letters/N.png'),
            _buildLetterTile('O', 'assets/letters/audio/kid-o.mp3', 'assets/letters/images_letters/O.png'),
            _buildLetterTile('P', 'assets/letters/audio/kid-p.mp3', 'assets/letters/images_letters/P.png'),
            _buildLetterTile('Q', 'assets/letters/audio/kid-q.mp3', 'assets/letters/images_letters/Q.png'),
            _buildLetterTile('R', 'assets/letters/audio/kid-r.mp3', 'assets/letters/images_letters/R.png'),
            _buildLetterTile('S', 'assets/letters/audio/kid-s.mp3', 'assets/letters/images_letters/S.png'),
            _buildLetterTile('T', 'assets/letters/audio/kid-t.mp3', 'assets/letters/images_letters/T.png'),
            _buildLetterTile('U', 'assets/letters/audio/kid-u.mp3', 'assets/letters/images_letters/U.png'),
            _buildLetterTile('V', 'assets/letters/audio/kid-v.mp3', 'assets/letters/images_letters/V.png'),
            _buildLetterTile('W', 'assets/letters/audio/kid-w.mp3', 'assets/letters/images_letters/W.png'),
            _buildLetterTile('X', 'assets/letters/audio/kid-x.mp3', 'assets/letters/images_letters/X.png'),
            _buildLetterTile('Y', 'assets/letters/audio/kid-y.mp3', 'assets/letters/images_letters/Y.png'),
            _buildLetterTile('Z', 'assets/letters/audio/kid-z.mp3', 'assets/letters/images_letters/Z.png'),
          ],
        ),
      ),
    );
  }
}
