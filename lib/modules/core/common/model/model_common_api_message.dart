/// A [ModelCommonAPIMessage] widget is a widget that describes part of the API Model Unauthorised
class ModelCommonAPIMessage {
  String? message;
  String? status;

  ModelCommonAPIMessage({
    this.message,
    this.status,
  });

  ModelCommonAPIMessage.fromJson(Map<String, dynamic> json) {
    message = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = message;
    data['status'] = status;
    return data;
  }
}
