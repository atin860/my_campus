import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Question> _questions = [
    Question(
      questionText: 'What is the capital of France?',
      options: ['Paris', 'London', 'Berlin', 'Madrid'],
      answer: 'Paris',
    ),
    Question(
      questionText: 'What is the largest planet in our solar system?',
      options: ['Earth', 'Jupiter', 'Mars', 'Saturn'],
      answer: 'Jupiter',
    ),
    // Add more questions here
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizCompleted = false;
  bool _answered = false; // To check if a question has been answered
  int _selectedIndex = -1; // To track which option was selected

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedIndex = -1; // Reset selected option index
        _answered = false; // Reset answered flag
      });
    } else {
      setState(() {
        _quizCompleted = true;
      });
    }
  }

  void _checkAnswer(int index) {
    setState(() {
      _selectedIndex = index;
      _answered = true;
      if (_questions[_currentQuestionIndex].options[index] ==
          _questions[_currentQuestionIndex].answer) {
        _score++;
      }
    });

    Future.delayed(Duration(seconds: 1), () {
      _nextQuestion(); // Proceed to the next question after 1 second
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
      _quizCompleted = false;
      _answered = false;
      _selectedIndex = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: const Color.fromARGB(255, 68, 209, 202),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey,
        ),
        padding: const EdgeInsets.all(16.0),
        child: _quizCompleted
            ? _buildResultScreen()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: _buildQuestionContainer()),
                  SizedBox(height: 20),
                  _buildOptions(), // Show options
                ],
              ),
      ),
    );
  }

  Widget _buildQuestionContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Text(
                'Total ${_questions.length}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              Text(
                'Oprating System',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
             
            ],
          ),
          Divider(),
          SizedBox(height: 30),
          Text(
            'Q.${_currentQuestionIndex + 1} : ${_questions[_currentQuestionIndex].questionText}',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Expanded(
      child: Column(
        children: List.generate(
          _questions[_currentQuestionIndex].options.length,
          (index) {
            Color optionColor;

            if (_answered) {
              if (_questions[_currentQuestionIndex].options[index] ==
                  _questions[_currentQuestionIndex].answer) {
                optionColor = Colors.green; // Correct answer
              } else if (_selectedIndex == index) {
                optionColor = Colors.red; // Incorrect answer
              } else {
                optionColor = Colors.blueAccent;
              }
            } else {
              optionColor = Colors.blueAccent; // Default color when not answered
            }

            return GestureDetector(
              onTap: !_answered
                  ? () => _checkAnswer(index)
                  : null, // Disable if already answered
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5), // Added margin
                decoration: BoxDecoration(
                  color: optionColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(16), // Added padding for better touch
                child: Center(
                  child: Text(
                    _questions[_currentQuestionIndex].options[index],
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      'assets/img/back3.jpg'), // Use your trophy image
                ),
                SizedBox(height: 20),
                Text(
                  'Your Score: $_score / ${_questions.length}',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Percentage: ${((_score / _questions.length) * 100).toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 20, color: Colors.red),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: _resetQuiz,
                  child: Text(
                    'Restart Quiz',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Question {
  final String questionText;
  final List<String> options;
  final String answer;

  Question({
    required this.questionText,
    required this.options,
    required this.answer,
  });
}
