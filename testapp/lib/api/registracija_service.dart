import 'package:dio/dio.dart';
import 'package:testapp/models/requests/registracija_request.dart';

import 'dio_client.dart';

class RegistracijaService {
  Future<Response?> createKorisnik(
      {required DioClient dioClient,
      required RegistracijaRequest korisnikInfo}) async {
    Response? response;

    try {
      response = await dioClient.dio.post(
        '/registracija/',
        data: korisnikInfo.toJson(),
      );
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }
}
