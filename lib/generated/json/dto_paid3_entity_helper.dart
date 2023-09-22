import 'package:umagram/dto/paid3/dto_paid3_entity.dart';

dtoPaid3EntityFromJson(DtoPaid3Entity data, Map<String, dynamic> json) {
	if (json['questionnaire_output'] != null) {
		data.questionnaireOutput = new List<DtoPaid3QuestionnaireOutput>();
		(json['questionnaire_output'] as List).forEach((v) {
			data.questionnaireOutput.add(new DtoPaid3QuestionnaireOutput().fromJson(v));
		});
	}
	if (json['questionnaire'] != null) {
		data.questionnaire = new List<DtoPaid3Questionnaire>();
		(json['questionnaire'] as List).forEach((v) {
			data.questionnaire.add(new DtoPaid3Questionnaire().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> dtoPaid3EntityToJson(DtoPaid3Entity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.questionnaireOutput != null) {
		data['questionnaire_output'] =  entity.questionnaireOutput.map((v) => v.toJson()).toList();
	}
	if (entity.questionnaire != null) {
		data['questionnaire'] =  entity.questionnaire.map((v) => v.toJson()).toList();
	}
	return data;
}

dtoPaid3QuestionnaireOutputFromJson(DtoPaid3QuestionnaireOutput data, Map<String, dynamic> json) {
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

Map<String, dynamic> dtoPaid3QuestionnaireOutputToJson(DtoPaid3QuestionnaireOutput entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['min'] = entity.min;
	data['max'] = entity.max;
	data['output'] = entity.output;
	return data;
}

dtoPaid3QuestionnaireFromJson(DtoPaid3Questionnaire data, Map<String, dynamic> json) {
	if (json['statement'] != null) {
		data.statement = json['statement'].toString();
	}
	if (json['isSelected'] != null) {
		data.isSelected = json['isSelected'];
	}
	return data;
}

Map<String, dynamic> dtoPaid3QuestionnaireToJson(DtoPaid3Questionnaire entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['statement'] = entity.statement;
	data['isSelected'] = entity.isSelected;
	return data;
}