import 'package:dio/dio.dart';
import 'package:pocket_pantry_frontend/core/constants/constant.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: Constant.apiBaseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // JSON POST
  @POST('{path}')
  Future<String> postDynamic(@Path('path') String path, @Body() String body);

  // GET
  @GET('{path}')
  Future<String> getDynamic(
    @Path('path') String path,
    @Queries() Map<String, dynamic> queryParams,
  );

  // PUT
  @PUT('{path}')
  Future<String> putDynamic(@Path('path') String path, @Body() String body);

  // DELETE
  @DELETE('{path}')
  Future<String> deleteDynamic(
    @Path('path') String path,
    @Queries() Map<String, dynamic> queryParams,
  );

  // FORM URL ENCODED
  @POST('{path}')
  @FormUrlEncoded()
  Future<String> postFormDynamic(
    @Path('path') String path,
    @Body() Map<String, dynamic> fields,
  );

  @POST('{path}')
  @MultiPart()
  Future<String> postGenericMultipart(
    @Path('path') String path,
    @Body() FormData formData,
  );
}
