import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../data/questions.dart';
import '../widgets/option_widget.dart';
import '../screens/score_screen.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  int currentQuestionIndex = 0;
  bool answered = false;
  bool correct = false;
  int score = 0;
  late AnimationController _controller;
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isMuted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _nextQuestion();
      }
    });
    _controller.forward();

    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    await _audioPlayer.setSource(AssetSource('background_music.mp3'));
    _audioPlayer.setVolume(0.5);
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
    _audioPlayer.resume();
  }

  void _toggleMute() {
    setState(() {
      isMuted = !isMuted;
      _audioPlayer.setVolume(isMuted ? 0 : 0.5);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  void _answerQuestion(int selectedOptionIndex) {
    if (answered) return;

    setState(() {
      answered = true;
      correct = selectedOptionIndex == questions[currentQuestionIndex].correctOptionIndex;
      if (correct) {
        score++;
        _showMotivationDialog(true);
      } else {
        _showMotivationDialog(false);
      }
      _controller.stop();
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        answered = false;
        correct = false;
        _controller.reset();
        _controller.forward();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScoreScreen(score: score, totalQuestions: questions.length),
        ),
      );
    }
  }

  void _showMotivationDialog(bool correct) {
    String title = correct ? 'Congratulations!' : 'Try Again!';
    String content = correct ? 'You got it right. Keep up the good work!' : 'Don\'t worry. Keep trying!';
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (correct) {
                _nextQuestion();
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Quran Quiz'),
        actions: [
          IconButton(
            icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
            onPressed: _toggleMute,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  question.text,
                  style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  question.quranText,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                LinearProgressIndicator(
                  value: _controller.value,
                ),
                SizedBox(height: 8),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Text(
                      '${(_controller.duration! * (1 - _controller.value)).inSeconds} seconds remaining',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      textAlign: TextAlign.center,
                    );
                  },
                ),
                SizedBox(height: 16),
                ...List.generate(
                  question.options.length,
                      (index) => OptionWidget(
                    text: question.options[index],
                    onTap: () => _answerQuestion(index),
                    disabled: answered,
                    isCorrect: answered && index == question.correctOptionIndex,
                    isSelected: answered && index != question.correctOptionIndex,
                  ),
                ),
                if (answered)
                  ElevatedButton(
                    child: Text('Next Question'),
                    onPressed: _nextQuestion,
                  ),
                SizedBox(height: 16),
                Text(
                  'Score: $score',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
