import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static void initDipHelper() {
    dio = Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1/'));
  }

}