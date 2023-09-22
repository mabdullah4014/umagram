import 'package:umagram/dto/free/dto_free_entity.dart';

dtoFreeEntityFromJson(DtoFreeEntity data, Map<String, dynamic> json) {
	if (json['questionnaire_output'] != null) {
		data.questionnaireOutput = new List<DtoFreeQuestionnaireOutput>();
		(json['questionnaire_output'] as List).forEach((v) {
			data.questionnaireOutput.add(new DtoFreeQuestionnaireOutput().fromJson(v));
		});
	}
	if (json['questionnaire'] != null) {
		data.questionnaire = new List<DtoFreeQuestionnaire>();
		(json['questionnaire'] as List).forEach((v) {
			data.questionnaire.add(new DtoFreeQuestionnaire().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> dtoFreeEntityToJson(DtoFreeEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.questionnaireOutput != null) {
		data['questionnaire_output'] =  entity.questionnaireOutput.map((v) => v.toJson()).toList();
	}
	if (entity.questionnaire != null) {
		data['questionnaire'] =  entity.questionnaire.map((v) => v.toJson()).toList();
	}
	return data;
}

dtoFreeQuestionnaireOutputFromJson(DtoFreeQuestionnaireOutput data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> dtoFreeQuestionnaireOutputToJson(DtoFreeQuestionnaireOutput entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['min'] = entity.min;
	data['max'] = entity.max;
	data['symbol'] = entity.symbol;
	return data;
}

dtoFreeQuestionnaireFromJson(DtoFreeQuestionnaire data, Map<String, dynamic> json) {
	if (json['classification'] != null) {
		data.classification = json['classification'].toString();
	}
	if (json['question_output'] != null) {
		data.questionOutput = new List<DtoFreeQuestionnaireQuestionOutput>();
		(json['question_output'] as List).forEach((v) {
			data.questionOutput.add(new DtoFreeQuestionnaireQuestionOutput().fromJson(v));
		});
	}
	if (json['questions'] != null) {
		data.questions = new List<DtoFreeQuestionnaireQuestion>();
		(json['questions'] as List).forEach((v) {
			data.questions.add(new DtoFreeQuestionnaireQuestion().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> dtoFreeQuestionnaireToJson(DtoFreeQuestionnaire entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['classification'] = entity.classification;
	if (entity.questionOutput != null) {
		data['question_output'] =  entity.questionOutput.map((v) => v.toJson()).toList();
	}
	if (entity.questions != null) {
		data['questions'] =  entity.questions.map((v) => v.toJson()).toList();
	}
	return data;
}

dtoFreeQuestionnaireQuestionOutputFromJson(DtoFreeQuestionnaireQuestionOutput data, Map<String, dynamic> json) {
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
	return data;
}

Map<String, dynamic> dtoFreeQuestionnaireQuestionOutputToJson(DtoFreeQuestionnaireQuestionOutput entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['min'] = entity.min;
	data['max'] = entity.max;
	data['symbol'] = entity.symbol;
	return data;
}

dtoFreeQuestionnaireQuestionFromJson(DtoFreeQuestionnaireQuestion data, Map<String, dynamic> json) {
	if (json['statement'] != null) {
		data.statement = json['statement'].toString();
	}
	if (json['answers'] != null) {
		data.answers = new List<DtoFreeQuestionnaireQuestionsAnswer>();
		(json['answers'] as List).forEach((v) {
			data.answers.add(new DtoFreeQuestionnaireQuestionsAnswer().fromJson(v));
		});
	}
	if (json['selectedAnswer'] != null) {
		data.selectedAnswer = new DtoFreeQuestionnaireQuestionsAnswer().fromJson(json['selectedAnswer']);
	}
	return data;
}

Map<String, dynamic> dtoFreeQuestionnaireQuestionToJson(DtoFreeQuestionnaireQuestion entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['statement'] = entity.statement;
	if (entity.answers != null) {
		data['answers'] =  entity.answers.map((v) => v.toJson()).toList();
	}
	if (entity.selectedAnswer != null) {
		data['selectedAnswer'] = entity.selectedAnswer.toJson();
	}
	return data;
}

dtoFreeQuestionnaireQuestionsAnswerFromJson(DtoFreeQuestionnaireQuestionsAnswer data, Map<String, dynamic> json) {
	if (json['statement'] != null) {
		data.statement = json['statement'].toString();
	}
	if (json['points'] != null) {
		data.points = json['points'] is String
				? int.tryParse(json['points'])
				: json['points'].toInt();
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	return data;
}

Map<String, dynamic> dtoFreeQuestionnaireQuestionsAnswerToJson(DtoFreeQuestionnaireQuestionsAnswer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['statement'] = entity.statement;
	data['points'] = entity.points;
	data['type'] = entity.type;
	return data;
}