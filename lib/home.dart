import 'package:flutter/material.dart';
import 'package:flutter_mentor_quiz_app_tut/answer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? Icon(
                Icons.check_circle,
                color: Colors.green,
              )
            : Icon(
                Icons.clear,
                color: Colors.red,
              ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Приложение "Тест"',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 25.0,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map(
              (answer) => Answer(
                answerText: answer['answerText'],
                answerColor: answerWasSelected
                    ? answer['score']
                        ? Colors.green
                        : Colors.red
                    : null,
                answerTap: () {
                  // if answer was already selected then nothing happens onTap
                  if (answerWasSelected) {
                    return;
                  }
                  //answer is being selected
                  _questionAnswered(answer['score']);
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
              ),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Выберете вариант ответа, чтобы продолжить'),
                  ));
                  return;
                }
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Повторить' : 'Следующий вопрос'),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Text(
                '${_totalScore.toString()}/${_questions.length}',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
            ),
            if (answerWasSelected && !endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected
                        ? 'Вы ответили правильно!'
                        : 'Вы ответили неправильно!',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.black,
                child: Center(
                  child: Text(
                    _totalScore > 4
                        ? 'Баллы: $_totalScore'
                        : 'Ваш результат: $_totalScore.',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: _totalScore > 4 ? Colors.green : Colors.red,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final _questions = const [
  {
    'question': 'Столица США?',
    'answers': [
      {'answerText': 'Вашингтон', 'score': true},
      {'answerText': 'Чикаго', 'score': false},
      {'answerText': 'Нью-Йорк', 'score': false},
    ],
  },
  {
    'question': 'Столица Казахстана?',
    'answers': [
      {'answerText': 'Ташкент', 'score': false},
      {'answerText': 'Костанай', 'score': false},
      {'answerText': 'Нур-Султан', 'score': true},
    ],
  },
  {
    'question': 'Столица Чехии?',
    'answers': [
      {'answerText': 'Будапешт', 'score': false},
      {'answerText': 'Вена', 'score': false},
      {'answerText': 'Прага', 'score': true},
    ],
  },
  {
    'question': 'Столица Греции?',
    'answers': [
      {'answerText': 'Патры', 'score': false},
      {'answerText': 'Афины', 'score': true},
      {'answerText': 'Салоники', 'score': false},
    ],
  },
  {
    'question': 'Столица Колумбии?',
    'answers': [
      {'answerText': 'Богота', 'score': true},
      {'answerText': 'Медельин', 'score': false},
      {'answerText': 'Панама', 'score': false},
    ],
  },
  {
    'question': 'Столица Мароко?',
    'answers': [
      {'answerText': 'Касабланка', 'score': true},
      {'answerText': 'Маракеш', 'score': false},
      {'answerText': 'Фес', 'score': false},
    ],
  },
  {
    'question': 'Столица Франции?',
    'answers': [
      {'answerText': 'Париж', 'score': true},
      {'answerText': 'Гамбург', 'score': false},
      {'answerText': 'Марсель', 'score': false},
    ],
  },
  {
    'question': 'Столица Мексики?',
    'answers': [
      {'answerText': 'Палермо', 'score': false},
      {'answerText': 'Гвадалахара', 'score': false},
      {'answerText': 'Мехико', 'score': true},
    ],
  },
  {
    'question': 'Cтолица Канады?',
    'answers': [
      {'answerText': 'Оттава', 'score': true},
      {'answerText': 'Торонто', 'score': false},
      {'answerText': 'Ванкувер', 'score': false},
    ],
  },
  {
    'question': 'Столица Эквадора?',
    'answers': [
      {'answerText': 'Гуаякиль', 'score': false},
      {'answerText': 'Амбато', 'score': false},
      {'answerText': 'Кито', 'score': true},
    ],
  },
  {
    'question': 'Столица Кении?',
    'answers': [
      {'answerText': 'Момбаса', 'score': false},
      {'answerText': 'Найроби', 'score': true},
      {'answerText': 'Накуру', 'score': false},
    ],
  },
  {
    'question': 'Столица Японии?',
    'answers': [
      {'answerText': 'Хиросима', 'score': false},
      {'answerText': 'Токио', 'score': true},
      {'answerText': 'Нагасаки', 'score': false},
    ],
  },
  {
    'question': 'Столица Танзании?',
    'answers': [
      {'answerText': 'Додома', 'score': true},
      {'answerText': 'Мбея', 'score': false},
      {'answerText': 'Дар-зс-Салам', 'score': false},
    ],
  },
  {
    'question': 'Столица Китая?',
    'answers': [
      {'answerText': 'Гонконг', 'score': false},
      {'answerText': 'Шанхай', 'score': false},
      {'answerText': 'Пекин', 'score': true},
    ],
  },
  {
    'question': 'Столица Афганистана?',
    'answers': [
      {'answerText': 'Кандагар', 'score': false},
      {'answerText': 'Кабул', 'score': true},
      {'answerText': 'Герат', 'score': false},
    ],
  },
];
