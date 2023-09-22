import 'package:umagram/generated/json/base/json_convert_content.dart';
import 'package:umagram/generated/json/base/json_field.dart';

class DtoPaid6Entity with JsonConvert<DtoPaid6Entity> {
	@JSONField(name: "questionnaire_output")
	List<DtoPaid6QuestionnaireOutput> questionnaireOutput;
	List<DtoPaid6Questionnaire> questionnaire;
}

class DtoPaid6QuestionnaireOutput with JsonConvert<DtoPaid6QuestionnaireOutput> {
	int min;
	int max;
	String output;
}

class DtoPaid6Questionnaire with JsonConvert<DtoPaid6Questionnaire> {
	String statement;
	bool isSelected = false;
}
