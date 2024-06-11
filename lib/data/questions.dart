// lib/data/questions.dart
import '../models/question.dart';

final List<Question> questions = [
  Question(
    text: "Choose the correct translation for the following Quranic text:",
    quranText: "بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ",
    options: ["In the name of Allah, the Most Gracious, the Most Merciful", "Praise be to Allah", "Allah is the Greatest", "There is no deity but Allah"],
    correctOptionIndex: 0,
  ),
  Question(
    text: "Choose the correct translation for the following Quranic text:",
    quranText: "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
    options: ["The Most Merciful", "Master of the Day of Judgment", "Guide us to the Straight Path", "All praise is due to Allah, Lord of all the worlds"],
    correctOptionIndex: 3,
  ),
  Question(
    text: "Choose the correct translation for the following Quranic text:",
    quranText: "قُلْ هُوَ اللَّهُ أَحَدٌ",
    options: ["He is Allah, One", "He begets not, nor was He begotten", "He is the All-Hearing", "Allah is Eternal"],
    correctOptionIndex: 0,
  ),
  // Add more questions here
];
