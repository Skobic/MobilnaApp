import 'package:dio/dio.dart';

import 'package:testapp/models/responses/mjesto_response.dart';

import 'dio_client.dart';

class MjestoService {
  Future<List<MjestoResponse>> getMjesta(
      DioClient dioClient, String individualnaSalaId) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response saleData = await dioClient.dio
          .get('/individualne-sale/${individualnaSalaId.toString()}/mjesta');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<MjestoResponse> mjesta = (saleData.data as List)
          .map((data) => MjestoResponse.fromJson(data))
          .toList();

      return mjesta;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
