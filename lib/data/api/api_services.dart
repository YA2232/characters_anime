import 'package:bloc_app/constants/strings.dart';
import 'package:dio/dio.dart';

class ApiServices {
  late Dio dio;
  ApiServices() {
    BaseOptions option = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(option);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      return response.data['results'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}
