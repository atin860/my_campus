import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:my_campus/widget/app_button.dart';
import 'package:my_campus/widget/appbar.dart';
import 'package:my_campus/widget/constant.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      appBar: AppBar(
          // automaticallyImplyLeading: false,
          title: Text(
            "Quiz",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: kappbarback),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/logo/quiz.png")),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Column(
                children: [
                  AppButton(
                      hint: "Java",
                      onPressed: () {
                        Get.to(() => const OperatingSystem());
                      }),
                  AppButton(
                      hint: "Data Structure",
                      onPressed: () {
                        Get.to(() => const OperatingSystem());
                      }),
                  AppButton(
                      hint: "Oprating System",
                      onPressed: () {
                        Get.to(() => const OperatingSystem());
                      }),
                  AppButton(
                      hint: "C language",
                      onPressed: () {
                        Get.to(() => const OperatingSystem());
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// operating system class
class OperatingSystem extends StatefulWidget {
  const OperatingSystem({super.key});

  @override
  _OperatingSystemState createState() => _OperatingSystemState();
}

class _OperatingSystemState extends State<OperatingSystem> {
  final List<Question> _questions = [
    Question(
      questionText: 'What is the main purpose of an operating system?',
      options: [
        'To manage computer hardware and software resources',
        'To provide antivirus protection',
        'To create websites',
        'To handle external devices only'
      ],
      answer: 'Paris',
    ),
    Question(
      questionText: 'What is the largest planet in our solar system?',
      options: ['Earth', 'Jupiter', 'Mars', 'Saturn'],
      answer: 'Jupiter',
    ),

    Question(
      questionText: 'What is virtual memory?',
      options: [
        'A memory management technique that gives an application the impression it has contiguous working memory',
        'Physical memory installed in the computer',
        'A type of cache memory',
        ' Temporary storage on the hard disk'
      ],
      answer:
          ' A memory management technique that gives an application the impression it has contiguous working memory',
    ),
    Question(
      questionText:
          'Which of the following is responsible for process scheduling in an OS?',
      options: ['File System', 'Kernel', 'Bootloader', 'Task Manager'],
      answer: 'Kernel',
    ),
    Question(
      questionText:
          'Which data structure uses LIFO (Last In, First Out) principle?',
      options: ['Queue', ' Stack', ' Linked List', 'Binary Tree'],
      answer: 'Stack',
    ),
    Question(
      questionText:
          ' What is the time complexity of searching for an element in a balanced binary search tree?',
      options: ['O(n)', ' O(log n)', 'O(n²)', ' O(1)'],
      answer: ' O(1)',
    ),
    Question(
      questionText:
          ' Which data structure is best suited for implementing FIFO (First In, First Out) operations?',
      options: ['Stack', '  Queue', ' Graph', ' Hash Table'],
      answer: 'Queue',
    ),
    Question(
      questionText:
          'In a linked list, what is the time complexity of accessing the n-th element directly?',
      options: ['O(1)', 'O(n)', 'O(log n)', 'O(n²)'],
      answer: 'O(n)',
    ),
    Question(
      questionText:
          'Which command is commonly used to list files in Unix/Linux?',
      options: ['list', 'dir', 'ls', ' show'],
      answer: 'ls',
    ),
    Question(
      questionText: 'What is a daemon in an operating system?',
      options: [
        'l A malicious software',
        'A background process that handles requests',
        'A type of user account',
        '  A graphical interface'
      ],
      answer: 'A background process that handles requests',
    ),
    Question(
      questionText: 'What does "booting" mean?',
      options: [
        ' Installing a new application',
        ' Starting the computer and loading the operating system',
        'Shutting down the computer',
        '   Running a diagnostic test'
      ],
      answer: ' Starting the computer and loading the operating system',
    ),
    Question(
      questionText: 'What is the role of a device driver?',
      options: [
        'To manage user accounts',
        ' To communicate with hardware devices',
        ' To optimize CPU performance',
        '   To store system files'
      ],
      answer: '  To communicate with hardware devices',
    ),
    Question(
      questionText: 'What does "paging" refer to in memory management?',
      options: [
        'Organizing files',
        'Managing virtual memory by breaking it into fixed-size pages',
        ' Compressing data',
        ' Scheduling tasks'
      ],
      answer: 'Managing virtual memory by breaking it into fixed-size pages',
    ),
    Question(
      questionText:
          'What is the primary purpose of a kernel in an operating system?',
      options: [
        'To provide a user interface',
        'To manage hardware resources',
        ' To execute application software',
        ' To handle network communications'
      ],
      answer: 'To manage hardware resources',
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

    Future.delayed(const Duration(seconds: 1), () {
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
      backgroundColor: kScaffoldColor,
      appBar: const MyAppBar(title: "Quiz"),
      body: Container(
        decoration: const BoxDecoration(color: kScaffoldColor),
        padding: const EdgeInsets.all(16.0),
        child: _quizCompleted
            ? _buildResultScreen()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: _buildQuestionContainer()),
                  const SizedBox(height: 20),
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
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                'Oprating System',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Divider(
            color: Colors.black,
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(15),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Que.${_currentQuestionIndex + 1} :',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _questions[_currentQuestionIndex].questionText,
                  style: const TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                optionColor = Colors.blue;
              }
            } else {
              optionColor = Colors.blue; // Default color when not answered
            }

            return GestureDetector(
              onTap: !_answered
                  ? () => _checkAnswer(index)
                  : null, // Disable if already answered
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8), // Added margin
                decoration: BoxDecoration(
                  color: optionColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding:
                    const EdgeInsets.all(16), // Added padding for better touch
                child: Center(
                  child: Text(
                    _questions[_currentQuestionIndex].options[index],
                    style: const TextStyle(color: Colors.white, fontSize: 18),
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
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage(
                      'assets/img/back3.jpg'), // Use your trophy image
                ),
                const SizedBox(height: 20),
                Text(
                  'Your Score: $_score / ${_questions.length}',
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Percentage: ${((_score / _questions.length) * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 20, color: Colors.red),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  onPressed: _resetQuiz,
                  child: const Text(
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
