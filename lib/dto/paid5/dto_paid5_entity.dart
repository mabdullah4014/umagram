import 'package:umagram/generated/json/base/json_convert_content.dart';
import 'package:umagram/generated/json/base/json_field.dart';

class DtoPaid5Entity with JsonConvert<DtoPaid5Entity> {
	@JSONField(name: "questionnaire_output")
	List<DtoPaid5QuestionnaireOutput> questionnaireOutput;
	List<DtoPaid5Question> questions;
}

class DtoPaid5QuestionnaireOutput with JsonConvert<DtoPaid5QuestionnaireOutput> {
	int score;
	String symbol;
}

class DtoPaid5Question with JsonConvert<DtoPaid5Question> {
	String statement;
	List<DtoPaid5QuestionsAnswer> answers;
	DtoPaid5QuestionsAnswer selectedAnswer;
}

class DtoPaid5QuestionsAnswer with JsonConvert<DtoPaid5QuestionsAnswer> {
	String statement;
	int points;
	String type;
}
