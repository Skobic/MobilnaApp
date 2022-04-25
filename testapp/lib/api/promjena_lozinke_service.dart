import 'package:dio/dio.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/models/requests/promjena_lozinke_request.dart';

class PromjenaLozinkeService {
  Future<Response?> promjeniLozinku(
      {required DioClient dioClient,
      required PromjenaLozinkeRequest promjenaLozinkeData}) async {
    // WebLogin? retrievedObavjestenje;
    Response? response;

    try {
      response = await dioClient.dio
          .patch('/promjena-lozinke/', data: promjenaLozinkeData.toJson());

      //print('User created: ${response.data}');

      //retrievedObavjestenje = WebLogin.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }
}
