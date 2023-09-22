import 'package:umagram/generated/json/base/json_convert_content.dart';

class DtoPaid4Entity with JsonConvert<DtoPaid4Entity> {
  List<List<DtoPaid4Questionnaire>> questionnaire;
}

class DtoPaid4Questionnaire with JsonConvert<DtoPaid4Questionnaire> {
  String option1;
  String option2;
  String selectedOption;

  String getOutputString() {
    if (selectedOption == null) return "";
    if (selectedOption == option1)
      return option2;
    else
      return option1;
  }
}
