import 'package:umagram/dto/paid5/dto_paid5_entity.dart';

dtoPaid5EntityFromJson(DtoPaid5Entity data, Map<String, dynamic> json) {
	if (json['questionnaire_output'] != null) {
		data.questionnaireOutput = new List<DtoPaid5QuestionnaireOutput>();
		(json['questionnaire_output'] as List).forEach((v) {
			data.questionnaireOutput.add(new DtoPaid5QuestionnaireOutput().fromJson(v));
		});
	}
	if (json['questions'] != null) {
		data.questions = new List<DtoPaid5Question>();
		(json['questions'] as List).forEach((v) {
			data.questions.add(new DtoPaid5Question().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> dtoPaid5EntityToJson(DtoPaid5Entity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.questionnaireOutput != null) {
		data['questionnaire_output'] =  entity.questionnaireOutput.map((v) => v.toJson()).toList();
	}
	if (entity.questions != null) {
		data['questions'] =  entity.questions.map((v) => v.toJson()).toList();
	}
	return data;
}

dtoPaid5QuestionnaireOutputFromJson(DtoPaid5QuestionnaireOutput data, Map<String, dynamic> json) {
	if (json['score'] != null) {
		data.score = json['score'] is String
				? int.tryParse(json['score'])
				: json['score'].toInt();
	}
	if (json['symbol'] != null) {
		data.symbol = json['symbol'].toString();
	}
	return data;
}

Map<String, dynamic> dtoPaid5QuestionnaireOutputToJson(DtoPaid5QuestionnaireOutput entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['score'] = entity.score;
	data['symbol'] = entity.symbol;
	return data;
}

dtoPaid5QuestionFromJson(DtoPaid5Question data, Map<String, dynamic> json) {
	if (json['statement'] != null) {
		data.statement = json['statement'].toString();
	}
	if (json['answers'] != null) {
		data.answers = new List<DtoPaid5QuestionsAnswer>();
		(json['answers'] as List).forEach((v) {
			data.answers.add(new DtoPaid5QuestionsAnswer().fromJson(v));
		});
	}
	if (json['selectedAnswer'] != null) {
		data.selectedAnswer = new DtoPaid5QuestionsAnswer().fromJson(json['selectedAnswer']);
	}
	return data;
}

Map<String, dynamic> dtoPaid5QuestionToJson(DtoPaid5Question entity) {
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

dtoPaid5QuestionsAnswerFromJson(DtoPaid5QuestionsAnswer data, Map<String, dynamic> json) {
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

Map<String, dynamic> dtoPaid5QuestionsAnswerToJson(DtoPaid5QuestionsAnswer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['statement'] = entity.statement;
	data['points'] = entity.points;
	data['type'] = entity.type;
	return data;
}