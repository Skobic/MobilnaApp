import 'package:dio/dio.dart';
import 'package:testapp/models/requests/potvrda_dolaska_request.dart';

import 'dio_client.dart';

class PotvrdaDolaskaService {
  Future<Response?> potvrdiDolazakIndRez(
      {required DioClient dioClient,
      required PotvrdaDolaskaRequest qrKodInfo,
      required int idMjesta,
      required int idRezervacije}) async {
    Response? response;

    try {
      response = await dioClient.dio.patch(
        '/mjesta/${idMjesta.toString()}/rezervacije/${idRezervacije.toString()}',
        data: qrKodInfo.toJson(),
      );
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }

  Future<Response?> potvrdiDolazakGrupRez(
      {required DioClient dioClient,
      required PotvrdaDolaskaRequest qrKodInfo,
      required int idSale,
      required int idRezervacije}) async {
    Response? response;

    try {
      response = await dioClient.dio.patch(
        '/grupne-sale/${idSale.toString()}/rezervacije/${idRezervacije.toString()}',
        data: qrKodInfo.toJson(),
      );
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }
}
