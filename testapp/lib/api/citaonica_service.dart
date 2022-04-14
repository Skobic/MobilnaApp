import 'package:dio/dio.dart';
import 'package:testapp/models/responses/citaonica_response.dart';

import 'dio_client.dart';

class CitaonicaService {
  Future<List<CitaonicaResponse>> getCitaonice(DioClient dioClient) async {
    // Perform GET request to the endpoint "/users/<id>"
    try {
      Response citaoniceData = await dioClient.dio.get('/citaonice');

      // Prints the raw data returned by the server
      //print('User Info: ${userData.data}');

      // Parsing the raw JSON data to the User class
      List<CitaonicaResponse> citaonice = (citaoniceData.data as List)
          .map((data) => CitaonicaResponse.fromJson(data))
          .toList();

      return citaonice;
    } catch (error, stacktrace) {
      throw Exception("Exception occured: $error stackTrace: $stacktrace");
    }
  }
}
