import 'package:umagram/generated/json/base/json_convert_content.dart';
import 'package:umagram/generated/json/base/json_field.dart';

class DtoFreeEntity with JsonConvert<DtoFreeEntity> {
	@JSONField(name: "questionnaire_output")
	List<DtoFreeQuestionnaireOutput> questionnaireOutput;
	List<DtoFreeQuestionnaire> questionnaire;
}

class DtoFreeQuestionnaireOutput with JsonConvert<DtoFreeQuestionnaireOutput> {
	int min;
	int max;
	String symbol;
}

class DtoFreeQuestionnaire with JsonConvert<DtoFreeQuestionnaire> {
	String classification;
	@JSONField(name: "question_output")
	List<DtoFreeQuestionnaireQuestionOutput> questionOutput;
	List<DtoFreeQuestionnaireQuestion> questions;

}

class DtoFreeQuestionnaireQuestionOutput with JsonConvert<DtoFreeQuestionnaireQuestionOutput> {
	int min;
	int max;
	String symbol;

}

class DtoFreeQuestionnaireQuestion with JsonConvert<DtoFreeQuestionnaireQuestion> {
	String statement;
	List<DtoFreeQuestionnaireQuestionsAnswer> answers;
	DtoFreeQuestionnaireQuestionsAnswer selectedAnswer;

}

class DtoFreeQuestionnaireQuestionsAnswer with JsonConvert<DtoFreeQuestionnaireQuestionsAnswer> {
	String statement;
	int points;
	String type;

}
