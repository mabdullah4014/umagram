import 'package:umagram/generated/json/base/json_convert_content.dart';
import 'package:umagram/generated/json/base/json_field.dart';

class DtoPaid2Entity with JsonConvert<DtoPaid2Entity> {
	@JSONField(name: "questionnaire_output")
	List<DtoPaid2QuestionnaireOutput> questionnaireOutput;
	List<DtoPaid2Questionnaire> questionnaire;
}

class DtoPaid2QuestionnaireOutput with JsonConvert<DtoPaid2QuestionnaireOutput> {
	int min;
	int max;
	String output;
}

class DtoPaid2Questionnaire with JsonConvert<DtoPaid2Questionnaire> {
	String classification;
	List<DtoPaid2QuestionnaireAnswer> answers;
	DtoPaid2QuestionnaireAnswer selectedAnswer;
}

class DtoPaid2QuestionnaireAnswer with JsonConvert<DtoPaid2QuestionnaireAnswer> {
	String statement;
	int points;
	String result;
}
