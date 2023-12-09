import '../constants/strings.dart';

class ValidationHelper {

  static String? checkIsNullOrEmpty(String? inputText) {
    if (inputText == null || inputText
        .trim()
        .isEmpty) {
      return Strings.fieldEmptyMsg;
    }
    return null;
  }

  static String? validateDescription(String? name) {
    String? nullableName = checkIsNullOrEmpty(name);
    if (nullableName != null) {
      return nullableName;
    }

    if (name!.length <= 3) {
      return Strings.descriptionError;
    }

    return null;
  }
}