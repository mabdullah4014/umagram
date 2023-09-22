import 'package:umagram/generated/json/base/json_convert_content.dart';
import 'package:umagram/generated/json/base/json_field.dart';

class DtoPaid3Entity with JsonConvert<DtoPaid3Entity> {
  @JSONField(name: "questionnaire_output")
  List<DtoPaid3QuestionnaireOutput> questionnaireOutput;
  List<DtoPaid3Questionnaire> questionnaire;
}

class DtoPaid3QuestionnaireOutput
    with JsonConvert<DtoPaid3QuestionnaireOutput> {
  int min;
  int max;
  String output;
}

class DtoPaid3Questionnaire with JsonConvert<DtoPaid3Questionnaire> {
  String statement;
  bool isSelected = false;
}
