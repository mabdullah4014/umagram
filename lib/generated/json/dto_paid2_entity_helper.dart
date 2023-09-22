import 'package:umagram/dto/paid2/dto_paid2_entity.dart';

dtoPaid2EntityFromJson(DtoPaid2Entity data, Map<String, dynamic> json) {
	if (json['questionnaire_output'] != null) {
		data.questionnaireOutput = new List<DtoPaid2QuestionnaireOutput>();
		(json['questionnaire_output'] as List).forEach((v) {
			data.questionnaireOutput.add(new DtoPaid2QuestionnaireOutput().fromJson(v));
		});
	}
	if (json['questionnaire'] != null) {
		data.questionnaire = new List<DtoPaid2Questionnaire>();
		(json['questionnaire'] as List).forEach((v) {
			data.questionnaire.add(new DtoPaid2Questionnaire().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> dtoPaid2EntityToJson(DtoPaid2Entity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.questionnaireOutput != null) {
		data['questionnaire_output'] =  entity.questionnaireOutput.map((v) => v.toJson()).toList();
	}
	if (entity.questionnaire != null) {
		data['questionnaire'] =  entity.questionnaire.map((v) => v.toJson()).toList();
	}
	return data;
}

dtoPaid2QuestionnaireOutputFromJson(DtoPaid2QuestionnaireOutput data, Map<String, dynamic> json) {
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
	if (json['output'] != null) {
		data.output = json['output'].toString();
	}
	return data;
}

Map<String, dynamic> dtoPaid2QuestionnaireOutputToJson(DtoPaid2QuestionnaireOutput entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['min'] = entity.min;
	data['max'] = entity.max;
	data['output'] = entity.output;
	return data;
}

dtoPaid2QuestionnaireFromJson(DtoPaid2Questionnaire data, Map<String, dynamic> json) {
	if (json['classification'] != null) {
		data.classification = json['classification'].toString();
	}
	if (json['answers'] != null) {
		data.answers = new List<DtoPaid2QuestionnaireAnswer>();
		(json['answers'] as List).forEach((v) {
			data.answers.add(new DtoPaid2QuestionnaireAnswer().fromJson(v));
		});
	}
	if (json['selectedAnswer'] != null) {
		data.selectedAnswer = new DtoPaid2QuestionnaireAnswer().fromJson(json['selectedAnswer']);
	}
	return data;
}

Map<String, dynamic> dtoPaid2QuestionnaireToJson(DtoPaid2Questionnaire entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['classification'] = entity.classification;
	if (entity.answers != null) {
		data['answers'] =  entity.answers.map((v) => v.toJson()).toList();
	}
	if (entity.selectedAnswer != null) {
		data['selectedAnswer'] = entity.selectedAnswer.toJson();
	}
	return data;
}

dtoPaid2QuestionnaireAnswerFromJson(DtoPaid2QuestionnaireAnswer data, Map<String, dynamic> json) {
	if (json['statement'] != null) {
		data.statement = json['statement'].toString();
	}
	if (json['points'] != null) {
		data.points = json['points'] is String
				? int.tryParse(json['points'])
				: json['points'].toInt();
	}
	if (json['result'] != null) {
		data.result = json['result'].toString();
	}
	return data;
}

Map<String, dynamic> dtoPaid2QuestionnaireAnswerToJson(DtoPaid2QuestionnaireAnswer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['statement'] = entity.statement;
	data['points'] = entity.points;
	data['result'] = entity.result;
	return data;
}