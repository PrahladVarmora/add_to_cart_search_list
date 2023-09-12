import 'dart:async';
import 'dart:convert';

import 'package:darshan_vachhani_flutter_yudiz/modules/core/common/model/model_common_api_message.dart';
import 'package:darshan_vachhani_flutter_yudiz/modules/core/utils/core_import.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

/// A [ApiProvider] class is used to network API call
/// Allows all classes implementing [Client] to be mutually composable.
class ApiProvider {
  static final ApiProvider _singletonApiProvider = ApiProvider._internal();

  factory ApiProvider() {
    return _singletonApiProvider;
  }

  ApiProvider._internal();

  /// HTTP methods

  /// It takes a url, a map of parameters, a map of headers and a client as parameters and returns a
  /// Future of either a dynamic or a ModelCommonAuthorised
  ///
  /// Args:
  ///   client (http): http.Client object
  ///   url (String): The url of the API
  ///   params (Map<String, dynamic>): The parameters to be sent to the server.
  ///   mHeader (Map<String, String>): This is the header that you want to pass to the API.
  ///
  /// Returns:
  ///   A Future<Either<dynamic, ModelCommonAuthorised>>

  Future<Either<dynamic, ModelCommonAPIMessage>> callGetMethod(
      http.Client client, String url, Map<String, String> mHeader) async {
    var baseUrl = Uri.parse(url);
    printWrapped('Method---GET');
    printWrapped('baseUrl--$baseUrl');
    printWrapped('mHeader--${mHeader.toString()}');
    return await client
        .get(baseUrl, headers: mHeader)
        .then((Response response) {
      printWrapped(
          'response of ----$baseUrl \nresponse body==: ${response.body}\nstatus code==: ${response.statusCode}');

      return getResponse(response, url);
    });
  }

  /// A function that returns a Future of type Either<dynamic, ModelCommonAuthorised>
  ///
  /// Args:
  ///   response: The response from the server.
  ///
  /// Returns:
  ///   The response is being returned.
  Future<Either<dynamic, ModelCommonAPIMessage>> getResponse(
      var response, var baseUrl) async {
    final int statusCode = response.statusCode!;
    if (statusCode == 500 || statusCode == 502) {
      ModelCommonAPIMessage streams = ModelCommonAPIMessage.fromJson(json.decode(
          '{"status":"error","msg":"${jsonDecode(response.body)['msg'] ?? ValidationString.validationInternalServerIssue}"}'));
      return right(
        streams,
      );
    } else if (statusCode == 401) {
      ModelCommonAPIMessage streams = ModelCommonAPIMessage.fromJson(json.decode(
          '{"status":"error","msg":"${jsonDecode(response.body)['msg']}"}'));
      return right(
        streams,
      );
    } else if (statusCode == 403 ||
        statusCode == 400 ||
        statusCode == 422 ||
        statusCode == 505) {
      ModelCommonAPIMessage streams = ModelCommonAPIMessage.fromJson(json.decode(
          '{"status":"error","msg":"${jsonDecode(response.body)['msg'].toString().trim()}"}'));
      return right(
        streams,
      );
    } else if (statusCode == 405) {
      String error = ValidationString.validationThisMethodNotAllowed;
      ModelCommonAPIMessage streams = ModelCommonAPIMessage.fromJson(json.decode(
          '{"status":"error","msg":"${(jsonDecode(response.body)['msg'] ?? error).toString().trim()}"}'));
      return right(
        streams,
      );
    } else if (statusCode < 200 || statusCode > 404) {
      String error = response.headers!['message'].toString();
      ModelCommonAPIMessage streams = ModelCommonAPIMessage.fromJson(
          json.decode('{"status":"error","msg":"$error"}'));
      return right(
        streams,
      );
    }
    /* else if (statusCode == 200) {
      ModelCommonAuthorised streams = ModelCommonAuthorised.fromJson(json.decode(
          '{"status":"${jsonDecode(response.body)['status']}","msg":"${jsonDecode(response.body)['msg']}"}'));
      if (streams.status != null && streams.status == "error") {
        return right(
          streams,
        );
      } else {
        return left(
          response.body,
        );
      }
    }*/
    return left(
      response.body,
    );
  }
}

///[ModelMultiPartFile] is used for file value
class ModelMultiPartFile {
  String filePath;
  String apiKey;

  ModelMultiPartFile({required this.filePath, required this.apiKey});
}
