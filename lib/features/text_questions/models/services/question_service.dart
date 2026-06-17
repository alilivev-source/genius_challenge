import '../models/question_model.dart';

class QuestionService {

  static List<QuestionModel> questions = [

    QuestionModel(
      question: "ما هي عاصمة فرنسا؟",

      answers: [
        "لندن",
        "باريس",
        "مدريد",
        "روما"
      ],

      correctIndex: 1,

      hint: "تشتهر ببرج إيفل",
    ),

    QuestionModel(
      question: "كم عدد قارات العالم؟",

      answers: [
        "5",
        "6",
        "7",
        "8"
      ],

      correctIndex: 2,

      hint: "أكثر من 6",
    ),

    QuestionModel(
      question: "أكبر كوكب في المجموعة الشمسية؟",

      answers: [
        "المريخ",
        "الأرض",
        "زحل",
        "المشتري"
      ],

      correctIndex: 3,

      hint: "كوكب غازي عملاق",
    ),
  ];
}