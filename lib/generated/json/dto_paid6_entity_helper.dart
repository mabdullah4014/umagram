import 'package:umagram/dto/paid6/dto_paid6_entity.dart';

dtoPaid6EntityFromJson(DtoPaid6Entity data, Map<String, dynamic> json) {
	if (json['questionnaire_output'] != null) {
		data.questionnaireOutput = new List<DtoPaid6QuestionnaireOutput>();
		(json['questionnaire_output'] as List).forEach((v) {
			data.questionnaireOutput.add(new DtoPaid6QuestionnaireOutput().fromJson(v));
		});
	}
	if (json['questionnaire'] != null) {
		data.questionnaire = new List<DtoPaid6Questionnaire>();
		(json['questionnaire'] as List).forEach((v) {
			data.questionnaire.add(new DtoPaid6Questionnaire().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> dtoPaid6EntityToJson(DtoPaid6Entity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.questionnaireOutput != null) {
		data['questionnaire_output'] =  entity.questionnaireOutput.map((v) => v.toJson()).toList();
	}
	if (entity.questionnaire != null) {
		data['questionnaire'] =  entity.questionnaire.map((v) => v.toJson()).toList();
	}
	return data;
}

dtoPaid6QuestionnaireOutputFromJson(DtoPaid6QuestionnaireOutput data, Map<String, dynamic> json) {
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

Map<String, dynamic> dtoPaid6QuestionnaireOutputToJson(DtoPaid6QuestionnaireOutput entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['min'] = entity.min;
	data['max'] = entity.max;
	data['output'] = entity.output;
	return data;
}

dtoPaid6QuestionnaireFromJson(DtoPaid6Questionnaire data, Map<String, dynamic> json) {
	if (json['statement'] != null) {
		data.statement = json['statement'].toString();
	}
	if (json['isSelected'] != null) {
		data.isSelected = json['isSelected'];
	}
	return data;
}

Map<String, dynamic> dtoPaid6QuestionnaireToJson(DtoPaid6Questionnaire entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['statement'] = entity.statement;
	data['isSelected'] = entity.isSelected;
	return data;
}