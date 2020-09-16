import 'package:life_in_the_uk/models/Option.dart';
import 'package:life_in_the_uk/models/OptionStatus.dart';
import 'package:life_in_the_uk/models/Question.dart';

var questions = [
  Question(
    title: 'What does an aged population have an impact on?',
    hint:
        'The older population need more refined health care, this extra need places a strain on the NHS',
    options: [
      Option('The cost of Bus Fares'),
      Option('The cost of Health Care', status: OptionStatus.notSelected),
      Option('The cost of Insurance', status: OptionStatus.notSelected),
      Option('The price of food', status: OptionStatus.notSelected)
    ],
    answers: Set.from([1, 3]),
  ),
  Question(
    title: 'What is NOT a fundamental principle of British life?',
    hint:
        'The older population need more refined health care, this extra need places a strain on the NHS',
    options: [
      Option('Driving a car'),
      Option('Looking after the environment'),
      Option('Treating others with fairness'),
      Option('Looking after yourself and family')
    ],
    answers: Set.from([0]),
  ),
  Question(
    title: 'Which flag has a white cross on a blue background?',
    hint:
        'The older population need more refined health care, this extra need places a strain on the NHS',
    options: ["Irish", "Scottish", "English", "Welsh"]
        .map((e) => Option(e))
        .toList(),
    answers: Set.from([1]),
  ),
  Question(
    title: 'What is the capital of UK?',
    hint:
        'The older population need more refined health care, this extra need places a strain on the NHS',
    options: ["Belfast", "London", "Edinburgh", "Cardiff"]
        .map((e) => Option(e))
        .toList(),
    answers: Set.from([1]),
  ),
  Question(
    title: 'When is St David\'s day?',
    hint:
        'The older population need more refined health care, this extra need places a strain on the NHS',
    options: [
      "1st of March",
      "17th of March",
      "30th of November",
      "23rd of April"
    ].map((e) => Option(e)).toList(),
    answers: Set.from([0]),
  ),
];
