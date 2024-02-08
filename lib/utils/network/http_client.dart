import 'package:clinicx_patient/providers/global_controller.dart';
import 'package:clinicx_patient/utils/network/dio_request_logger.dart';
import 'package:clinicx_patient/utils/network/preferences.dart';
import 'package:dio/dio.dart';

class HttpClient {
  Dio? _dio;

  Future<void> initialize() async {
    // Directory cacheDirectory = await getTemporaryDirectory();
    // HiveCacheStore cacheStore = HiveCacheStore(
    //   cacheDirectory.path,
    //   hiveBoxName: "vanoma_http_cache",
    // );
    // CacheOptions customCacheOptions = CacheOptions(
    //   store: cacheStore,
    //   policy: CachePolicy.forceCache,
    //   priority: CachePriority.high,
    //   maxStale: const Duration(minutes: 1),
    //   hitCacheOnErrorExcept: [401, 404],
    //   keyBuilder: (request) {
    //     return request.uri.toString();
    //   },
    // );

    _dio = Dio(BaseOptions(
      baseUrl: "https://clinicx.onrender.com/",
      connectTimeout: 30000,
      receiveTimeout: 30000,
      headers: {'user-agent': 'Dio/4.0.6'},
    ))
      ..interceptors.add(DioRequestLogger(level: Level.BASIC))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: _onEveryRequest,
        onError: _onEveryRequestError,
      ));
  }

  Future<Response> request(String url, String method, data) async {
    Response response = await _dio!.request(
      url,
      data: data,
      options: Options(method: method),
    );

    return response;
  }

  Future<void> _onEveryRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = preferences.getString("token");
    print("ACCESS TOKEN $accessToken");
    if (accessToken != null) {
      options.headers['Authorization'] = accessToken;
    }
    handler.next(options);
  }

  Future<void> _onEveryRequestError(
      DioError error, ErrorInterceptorHandler handler) async {
    print(error.response?.data);
    print(error.response?.realUri);
    if (error.response?.statusCode == 401) {
      // try {
      //   await _refreshAccessToken();
      // } on DioError catch (_) {
      // await globalController.signOut();
      return;
      // }
      // try {
      //   var response = await _dio!.request(
      //     error.requestOptions.path,
      //     data: error.requestOptions.data,
      //     queryParameters: error.requestOptions.queryParameters,
      //     options: Options(
      //       method: error.requestOptions.method,
      //       headers: error.requestOptions.headers,
      //     ),
      //   );
      //   return handler.resolve(response);
      // } on DioError catch (err) {
      //   return handler.next(err);
      // }
    }

    if (error.type == DioErrorType.response) {
      return handler.next(DioError(
        requestOptions: error.requestOptions,
        response: error.response,
        error: error.message,
        type: error.type,
      ));
    }

    if (error.message.contains("SocketException")) {
      return handler.next(DioError(
        requestOptions: error.requestOptions,
        response: error.response,
        error: "It appears you don't have internet. Please try again later.",
        type: error.type,
      ));
    }

    return handler.next(error);
  }

  // Future _refreshAccessToken() async {
  //   final refreshToken = preferences.getString("token");
  //   if (refreshToken != null) {
  //     final response = await request(
  //       '${IDENTITY_SERVICE_URL}token_renew',
  //       'GET',
  //       {'data': refreshToken},
  //     );

  //     //Save new token
  //     await preferences.setString("token", response.data['data']['token']);
  //   }
  // }
}

final httpClient = HttpClient();
