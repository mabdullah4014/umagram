import 'package:umagram/generated/json/base/json_convert_content.dart';
import 'package:umagram/generated/json/base/json_field.dart';

class DtoFortuneEntity with JsonConvert<DtoFortuneEntity> {
	@JSONField(name: "questionnaire_output")
	List<DtoFortuneQuestionnaireOutput> questionnaireOutput;
	List<DtoFortuneQuestion> questions;
}

class DtoFortuneQuestionnaireOutput with JsonConvert<DtoFortuneQuestionnaireOutput> {
	int min;
	int max;
	String symbol;
	String comments;
}

class DtoFortuneQuestion with JsonConvert<DtoFortuneQuestion> {
	@JSONField(name: "original_answer")
	String originalAnswer;
	List<DtoFortuneQuestionsAnswer> answers;
	DtoFortuneQuestionsAnswer selectedAnswer;
}

class DtoFortuneQuestionsAnswer with JsonConvert<DtoFortuneQuestionsAnswer> {
	String statement;
	String type;
}
