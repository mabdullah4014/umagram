import 'package:umagram/dto/fortune/dto_fortune_entity.dart';

dtoFortuneEntityFromJson(DtoFortuneEntity data, Map<String, dynamic> json) {
	if (json['questionnaire_output'] != null) {
		data.questionnaireOutput = [];
		(json['questionnaire_output'] as List).forEach((v) {
			data.questionnaireOutput.add(new DtoFortuneQuestionnaireOutput().fromJson(v));
		});
	}
	if (json['questions'] != null) {
		data.questions = [];
		(json['questions'] as List).forEach((v) {
			data.questions.add(new DtoFortuneQuestion().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> dtoFortuneEntityToJson(DtoFortuneEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.questionnaireOutput != null) {
		data['questionnaire_output'] =  entity.questionnaireOutput.map((v) => v.toJson()).toList();
	}
	if (entity.questions != null) {
		data['questions'] =  entity.questions.map((v) => v.toJson()).toList();
	}
	return data;
}

dtoFortuneQuestionnaireOutputFromJson(DtoFortuneQuestionnaireOutput data, Map<String, dynamic> json) {
	if (json['min'] != null) {
		data.min = json['min'] is String
				? int.tryParse(json['min'])
				: json['min'].toInt();
	}
	if (json['max'] != null) {
		data.max = json['max'] is String
				? int.tryParse(json['max'])
				: json['max'].toInt();
	}
	if (json['symbol'] != null) {
		data.symbol = json['symbol'].toString();
	}
	if (json['comments'] != null) {
		data.comments = json['comments'].toString();
	}
	return data;
}

Map<String, dynamic> dtoFortuneQuestionnaireOutputToJson(DtoFortuneQuestionnaireOutput entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['min'] = entity.min;
	data['max'] = entity.max;
	data['symbol'] = entity.symbol;
	data['comments'] = entity.comments;
	return data;
}

dtoFortuneQuestionFromJson(DtoFortuneQuestion data, Map<String, dynamic> json) {
	if (json['original_answer'] != null) {
		data.originalAnswer = json['original_answer'].toString();
	}
	if (json['answers'] != null) {
		data.answers = [];
		(json['answers'] as List).forEach((v) {
			data.answers.add(new DtoFortuneQuestionsAnswer().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> dtoFortuneQuestionToJson(DtoFortuneQuestion entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['original_answer'] = entity.originalAnswer;
	if (entity.answers != null) {
		data['answers'] =  entity.answers.map((v) => v.toJson()).toList();
	}
	return data;
}

dtoFortuneQuestionsAnswerFromJson(DtoFortuneQuestionsAnswer data, Map<String, dynamic> json) {
	if (json['statement'] != null) {
		data.statement = json['statement'].toString();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	return data;
}

Map<String, dynamic> dtoFortuneQuestionsAnswerToJson(DtoFortuneQuestionsAnswer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['statement'] = entity.statement;
	data['type'] = entity.type;
	return data;
}