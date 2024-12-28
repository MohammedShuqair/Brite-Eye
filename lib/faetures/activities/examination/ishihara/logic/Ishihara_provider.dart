import 'package:brite_eye/core/helpers/navigation_helper.dart';
import 'package:brite_eye/faetures/activities/examination/ishihara/ui/result_screen.dart';
import 'package:flutter/material.dart';

import '../models/test_plate.dart';
import '../repo/ishihara_repository.dart';

class IshiharaProvider extends ChangeNotifier {
  IshiharaProvider() {
    plates = IshiharaRepository().plates;
    plates.forEach((plate) {
      selectedChoices.add(null);
    });
  }

  PageController controller = PageController();
  int _currentIndex = 0;

  int? get currentChoice => selectedChoices[_currentIndex];

  void setCurrentChoice(int value) => selectedChoices[_currentIndex] = value;
  List<int?> selectedChoices = [];

  bool get choiceSelected => currentChoice != null;

  int get plateNumber => _currentIndex;
  late List<TestPlate> plates;

  bool get firstPage => _currentIndex == 0;

  Future<void> _nextPage() async {
    await controller.nextPage(
        duration: const Duration(milliseconds: 350), curve: Curves.linear);
  }

  Future<void> _previousPage() async {
    await controller.previousPage(
        duration: const Duration(milliseconds: 350), curve: Curves.linear);
  }

  void setIndex(int index) {
    if (index >= 0 && index < plates.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }

  TestPlate _getPlate() {
    return plates[_currentIndex];
  }

  String getPlateImage() {
    return _getPlate().imgPath;
  }

  String getPlateHint() {
    return _getPlate().hint;
  }

  int getPlateAnswer() {
    return _getPlate().answer;
  }

  void setChoice(int? index) async {
    if (index != null) {
      setCurrentChoice(index);
      notifyListeners();
    }
  }

  bool isCorrect() {
    return currentChoice == getPlateAnswer();
  }

  List<String> _getOptions() {
    return _getPlate().options;
  }

  String getOption(int index) {
    return _getOptions()[index];
  }

  int getOptionsLength() {
    return _getOptions().length;
  }

  List<String> _getDescriptions() {
    return _getPlate().descriptions;
  }

  String? getDescription() {
    if (choiceSelected) {
      return _getDescriptions()[currentChoice!];
    }
    return null;
  }

  int getPlatesLength() {
    return plates.length;
  }

  void nextPlate() async {
    if (!choiceSelected) {
      NavigationHelper.showSnackBar('Please select an option');
      return;
    }
    if (!isFinished()) {
      await _nextPage();
      setIndex(++_currentIndex);
    } else {
      NavigationHelper.pushReplacement(ResultScreen.id, extra: {
        'title': 'Ishihara Test Result',
        'score': calcScore(),
      });
    }
  }

  /// return score/length result
  String calcScore() {
    int score = 0;
    for (int i = 0; i < plates.length; i++) {
      if (selectedChoices[i] == plates[i].answer) {
        score++;
      }
    }
    return '$score/${plates.length}';
  }

  void previousPlate() async {
    if (_currentIndex > 0) {
      await _previousPage();

      setIndex(--_currentIndex);
    }
  }

  bool isFinished() {
    if (_currentIndex >= plates.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    setIndex(0);
    selectedChoices = [];
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
