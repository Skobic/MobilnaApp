import 'package:dio/dio.dart';
import 'package:testapp/api/dio_client.dart';

class OdjavaService {
  Future<Response?> createOdjava({
    required DioClient dioClient,
  }) async {
    // WebLogin? retrievedObavjestenje;
    Response? response;

    try {
      response = await dioClient.dio.post('/odjava');

      //print('User created: ${response.data}');

      //retrievedObavjestenje = WebLogin.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return response;
  }
}
