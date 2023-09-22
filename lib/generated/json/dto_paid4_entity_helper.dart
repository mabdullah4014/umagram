import 'package:umagram/dto/paid4/dto_paid4_entity.dart';

dtoPaid4EntityFromJson(DtoPaid4Entity data, Map<String, dynamic> json) {
  if (json['questionnaire'] != null) {
    data.questionnaire = [];
    (json['questionnaire'] as List<dynamic>).forEach((v) {
      List<DtoPaid4Questionnaire> dtoPaid4list = [];
      v.forEach((element) {
        dtoPaid4list.add(new DtoPaid4Questionnaire().fromJson(element));
      });
      data.questionnaire.add(dtoPaid4list);
    });
  }
  return data;
}

dtoPaid4QuestionnaireFromJson(
    DtoPaid4Questionnaire data, Map<String, dynamic> json) {
  if (json['option1'] != null) {
    data.option1 = json['option1'].toString();
  }
  if (json['option2'] != null) {
    data.option2 = json['option2'].toString();
  }
  return data;
}

Map<String, dynamic> dtoPaid4QuestionnaireToJson(DtoPaid4Questionnaire entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['option1'] = entity.option1;
  data['option2'] = entity.option2;
  return data;
}
