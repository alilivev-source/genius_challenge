class HelperService {

  static const int hintCost = 30;

  static const int removeTwoAnswersCost = 30;

  static const int revealLetterCost = 30;

  static const int skipQuestionCost = 0;

  static const int friendHelpCost = 0;

  static bool canUseHint(
    int coins,
  ) {
    return coins >= hintCost;
  }

  static bool canRemoveTwoAnswers(
    int coins,
  ) {
    return coins >= removeTwoAnswersCost;
  }

  static bool canRevealLetter(
    int coins,
  ) {
    return coins >= revealLetterCost;
  }

  static int useHint(
    int coins,
  ) {
    return coins - hintCost;
  }

  static int useRemoveTwoAnswers(
    int coins,
  ) {
    return coins -
        removeTwoAnswersCost;
  }

  static int useRevealLetter(
    int coins,
  ) {
    return coins -
        revealLetterCost;
  }
}