import 'package:dio/dio.dart';
import 'package:testapp/models/requests/reset_lozinke_request.dart';
import 'package:testapp/models/requests/zaboravljena_lozinka_email_request.dart';
import 'dio_client.dart';

class ZaboravljenaLozinkaService {
  Future<Response?> slanjeEmaila(
      {required DioClient dioClient,
      required ZaboravljenaLozinkaEmailRequest emailData}) async {
    Response? response;

    try {
      response = await dioClient.dio.post(
        '/zaboravljena-lozinka/',
        data: emailData.toJson(),
      );
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }

  Future<Response?> resetujLozinku(
      {required DioClient dioClient,
      required ResetLozinkeRequest resetData}) async {
    Response? response;

    try {
      response = await dioClient.dio.post(
        '/zaboravljena-lozinka-promjena/',
        data: resetData.toJson(),
      );
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }
}
