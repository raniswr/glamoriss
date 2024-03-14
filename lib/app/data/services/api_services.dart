import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:glamori/app/config/api_interface.dart';
import 'package:glamori/app/data/model/model_article.dart';
import 'package:glamori/app/data/model/model_bestseller_product.dart';
import 'package:glamori/app/data/model/model_bestseller_treatment.dart';
import 'package:glamori/app/data/model/model_card_upload.dart';
import 'package:glamori/app/data/model/model_detail_product.dart';
import 'package:glamori/app/data/model/model_edit_profile.dart';
import 'package:glamori/app/data/model/model_get_all_product.dart';
import 'package:glamori/app/data/model/model_get_profile.dart';
import 'package:glamori/app/data/model/model_login.dart';
import 'package:glamori/app/data/model/model_notif.dart';
import 'package:glamori/app/data/model/model_post_transaction.dart';
import 'package:glamori/app/data/model/model_promotion.dart';
import 'package:glamori/app/data/model/model_redeem.dart';
import 'package:glamori/app/data/model/model_redeemed.dart';
import 'package:glamori/app/data/model/model_register.dart';
import 'package:glamori/app/data/model/model_register_otp.dart';
import 'package:glamori/app/data/model/model_schedule.dart';
import 'package:glamori/app/data/model/model_sudah_dibeli.dart';
import 'package:glamori/app/data/model/model_transaction_section.dart';
import 'package:glamori/app/data/model/model_videos.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';
import 'dart:io';

class ApiServices {
  static Future<ModelLogin?> login({required String email, required String password, required String tokenReminder}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/login/member';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.post(url, data: {
        'email': email,
        'password': password,
        'tokenReminder': tokenReminder,
      });
    } on DioException catch (e) {
      EasyLoading.showError(e.response?.data['message']);
      return null;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      var modelAuth = ModelLogin.fromJson(result.data);
      if (modelAuth.message == "Login Success") {
        EasyLoading.dismiss();
        EasyLoading.showSuccess(modelAuth.message.toString());
      } else if (modelAuth.message == "Invalid password") {
        EasyLoading.showError(modelAuth.message.toString());
      }
      return modelAuth;
    } else {
      var modelAuth = ModelLogin.fromJson(result.data);
      EasyLoading.showError(modelAuth.message.toString());
      return null;
    }
  }

  static Future<bool?> register(
      {required String fullname, required String gender, required String password, required String birthdate, required String phone, required String email, required String address}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/member/register';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.post(url, data: {
        'fullname': fullname,
        'gender': gender,
        'birthdate': birthdate,
        'email': email,
        'address': address,
        'phone': phone,
        'password': password,
      });
    } on DioException catch (e) {
      EasyLoading.showError(e.response?.data['message']);
      return null;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.showError('Failed to Register');
      return null;
    }
  }

  static Future<bool?> claimReward({required String id, required String reward}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'reward/claim';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.post(url, data: {
        'member': id,
        'reward': reward,
      });
    } on DioException catch (e) {
      EasyLoading.showError(e.response?.data['message']);
      return false;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.showError('Failed to Claim Reward');
      return false;
    }
  }

  static Future<ModelRegisterOtp?> otpRegister({required String otp}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/member/confirm';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.post(url, data: {
        'otp': otp,
      });
    } on DioException catch (e) {
      EasyLoading.showError(e.response?.data['message']);
      return null;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();
      EasyLoading.showSuccess("Successfully Register Account");
      var modelAuth = ModelRegisterOtp.fromJson(result.data);
      return modelAuth;
      ;
    } else {
      EasyLoading.showError('Wrong OTP Code');
      return null;
    }
  }

  static Future<bool?> registerResend(
      {required String fullname, required String gender, required String password, required String birthdate, required String phone, required String email, required String address}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/member/resend';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.post(url, data: {
        'fullname': fullname,
        'gender': gender,
        'birthdate': birthdate,
        'email': email,
        'address': address,
        'phone': phone,
        'password': password,
      });
    } on DioException catch (e) {
      EasyLoading.showError(e.response?.data['message']);
      return null;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.showError('Failed to Register');
      return null;
    }
  }

  static Future<bool> changePasswordOtp({required String email}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/member/change-password';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.patch(url, data: {
        'email': email,
      });
    } on DioException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.response?.data['message']);
      return false;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();

      return true;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Wrong OTP Code');
      return false;
    }
  }

  static Future<bool> otpChangePassword({required String otp}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/member/confirm-password';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.patch(url, data: {
        'otp': otp,
      });
    } on DioException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.response?.data['message']);
      return false;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();

      return true;
    } else {
      EasyLoading.dismiss();
      EasyLoading.showError('Wrong OTP Code');
      return false;
    }
  }

  Future<ModelGetProfile?> getProfile(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/profile/$id';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelAllUser = ModelGetProfile.fromJson(response.data);

        return modelAllUser;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ModelDetailProduct?> getDetailProduct(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'product/$id';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelDetail = ModelDetailProduct.fromJson(response.data);

        return modelDetail;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      EasyLoading.dismiss();
      return null;
    }
  }

  static Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    String? id,
  }) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/change-password/$id';

    Response? result;
    EasyLoading.show();
    try {
      result = await dio.patch(url, data: {
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      });
      EasyLoading.dismiss();
      EasyLoading.showSuccess('Berhasil Mengubah Password');
      return true;
    } on DioException catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.response?.data['message']);

      return false;
    }
  }

  static Future<bool> editProfile({
    required String fullname,
    required String gender,
    required String birthdate,
    required String phone,
    required String email,
    required String alamat,
    String? id,
  }) async {
    Dio dio = ApiInterface.instance.api;

    String url = 'auth/profile/$id';
    Response? result;
    EasyLoading.show();
    try {
      result = await dio.patch(url, data: {
        'fullname': fullname,
        'gender': gender,
        'birthdate': birthdate,
        'email': email,
        'phone': phone,
        'address': alamat,
      });
    } on DioException catch (e) {
      EasyLoading.dismiss();

      EasyLoading.showError(e.response?.data['message']);
      return false;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      var modelEdit = ModelEditProfile.fromJson(result.data);

      EasyLoading.dismiss();
      EasyLoading.showSuccess(modelEdit.message.toString());

      return true;
    } else {
      var modelAuth = ModelRegister.fromJson(result.data);
      EasyLoading.showError(modelAuth.message.toString());
      return false;
    }
  }

  static Future<bool> updateToken({
    String? id,
  }) async {
    Dio dio = ApiInterface.instance.api;

    String url = 'auth/profile/$id';
    Response? result;
    // EasyLoading.show();
    try {
      result = await dio.patch(url, data: {
        'tokenReminder': '',
      });
    } on DioException catch (e) {
      // EasyLoading.dismiss();

      // EasyLoading.showError(e.response?.data['message']);
      return false;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      var modelEdit = ModelEditProfile.fromJson(result.data);

      // EasyLoading.dismiss();
      // EasyLoading.showSuccess(modelEdit.message.toString());

      return true;
    } else {
      var modelAuth = ModelRegister.fromJson(result.data);
      // EasyLoading.showError(modelAuth.message.toString());

      return false;
    }
  }

  static Future<void> uploadImage(File file, String id, String token) async {
    try {
      String url = 'https://glamori-be.vercel.app/api/auth/profile/$id';
      String contentType;
      if (file.path.toLowerCase().endsWith('.jpg') || file.path.toLowerCase().endsWith('.jpeg')) {
        contentType = 'image/jpeg';
      } else if (file.path.toLowerCase().endsWith('.png')) {
        contentType = 'image/png';
      } else if (file.path.toLowerCase().endsWith('.gif')) {
        contentType = 'image/gif';
      } else {
        print('Unsupported file type');
        return;
      }

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          file.path,
          filename: 'image.jpg',
          contentType: MediaType.parse(contentType),
        ),
      });
      Dio dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await dio.patch(url, data: formData);

      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('Error uploading file');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  static Future<bool> editImageProfile({
    required File? image,
    String? id,
  }) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'auth/profile/$id';
    String? filename;

    filename = image?.path.split("/").last;
    try {
      if (image != null) {
        print("${image.path}");
        var formData = FormData.fromMap(
          {
            'image': await MultipartFile.fromFile(image.path, filename: filename),
          },
        );

        Response response = await dio.patch(url, data: formData);
        if (response.statusCode == 200 || response.statusCode == 201) {
          var modelEdit = ModelEditProfile.fromJson(response.data);
          return true;
        } else {
          log('Image upload failed with status code: ${response.statusCode}');
          log('Server response: ${response.data}');
          return false;
        }
      } else {
        log('Image file does not exist');
        return false;
      }
    } on DioException catch (e) {
      log('DioError: $e');
      return false;
    }
  }

  Future<ModelGetAllProduct?> getAllProduct({String? lokasi}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'product';
    Map<String, dynamic>? queryParameters = {};

    if (lokasi != null) {
      queryParameters.addAll({"branch": lokasi});
    }

    try {
      Response response = await dio.get(url, queryParameters: queryParameters);
      // log(response.data);
      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelGetAllProduct.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelRedeem?> getRedeem(String? id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'reward/member/$id';

    try {
      Response response = await dio.get(url);
      // log(response.data);
      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelRedeem.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelRedeemed?> getRedeemed(String? id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'member-reward/redeem/$id';

    try {
      Response response = await dio.get(url);
      // log(response.data);
      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelRedeemed.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelNotif?> getAllNotif(String? id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'reminder/member/$id';

    try {
      Response response = await dio.get(url);
      // log(response.data);
      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelNotif.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelVideo?> getAlVideos() async {
    Dio dio = ApiInterface.instance.api;
    String url = 'video?status=active';

    try {
      Response response = await dio.get(url);
      // log(response.data);
      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelVideo.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelArticle?> getAllArticle() async {
    Dio dio = ApiInterface.instance.api;
    String url = 'article';

    try {
      Response response = await dio.get(url);
      // log(response.data);
      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelArticle.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<ModelPostTransaction?> postTransaction({required ModelCardUpload modelCard}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'transaction';
    Response? result;

    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
    );
    try {
      result = await dio.post(url, data: modelCard.toJson());
    } on DioException catch (e) {
      EasyLoading.showError(e.response?.data['message']);
      return null;
    }
    if (result.statusCode == 200 || result.statusCode == 201) {
      EasyLoading.dismiss();
      var modelAuth = ModelPostTransaction.fromJson(result.data);

      return modelAuth;
    } else {
      EasyLoading.dismiss();
      var modelAuth = ModelPostTransaction.fromJson(result.data);
      EasyLoading.showError(modelAuth.message.toString());
      return null;
    }
  }

  Future<ScheduleModel?> getSchedule({DateTime? date, String? idUser}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'schedule/member/${idUser}';
    Map<String, dynamic>? queryParameters = {};

    if (date != null) {
      final f = DateFormat('yyyy-MM-dd');
      var newdate = f.format(date);
      queryParameters.addAll({"fromDate": newdate});
    }

    try {
      Response response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ScheduleModel.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ScheduleModel?> getScheduleType({bool? type, DateTime? date, String? idUser}) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'schedule/member/${idUser}?filter=history';
    Map<String, dynamic>? queryParameters = {};

    if (type != null) {
      queryParameters.addAll({"virtual": type});
    } else if (date != null) {
      final f = DateFormat('yyyy-MM-dd');
      var newdate = f.format(date);
      queryParameters.addAll({"fromDate": newdate});
    } else if (type != null && date != null) {
      final f = DateFormat('yyyy-MM-dd');
      var newdate = f.format(date);

      queryParameters.addAll({"fromDate": newdate, "virtual": type});
    }

    try {
      Response response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ScheduleModel.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ScheduleModel?> getScheduleData({
    required String id,
    required String filter,
  }) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'schedule/member/$id';
    Map<String, dynamic>? queryParameters = {};
    queryParameters.addAll({"filter": filter});

    try {
      Response response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ScheduleModel.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ScheduleModel?> getScheduleToday(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'schedule/member/${id}';
    Map<String, dynamic>? queryParameters = {};
    queryParameters.addAll({"filter": 'today'});

    try {
      Response response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ScheduleModel.fromJson(response.data);
        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ScheduleModel?> getSchedule3days(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'schedule/member/${id}';
    Map<String, dynamic>? queryParameters = {};
    queryParameters.addAll({"filter": '3days'});
    try {
      Response response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ScheduleModel.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ScheduleModel?> getSchedule7days(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'schedule/member/${id}';
    Map<String, dynamic>? queryParameters = {};
    queryParameters.addAll({"filter": '7days'});

    try {
      Response response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ScheduleModel.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ScheduleModel?> getSchedule21days(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'schedule/member/${id}';
    Map<String, dynamic>? queryParameters = {};
    queryParameters.addAll({"filter": '21days'});

    try {
      Response response = await dio.get(url, queryParameters: queryParameters);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ScheduleModel.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ScheduleModel?> getScheduleHistory(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'schedule/member/${id}';
    Map<String, dynamic>? queryParameters = {};
    queryParameters.addAll({"filter": 'history'});

    try {
      Response response = await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        var modelGetAllProduct = ScheduleModel.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ModelGetAllProduct?> getSearchProduct(String product) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'product?search=${product}';
    Map<String, dynamic>? queryParameters = {};
    queryParameters.addAll({"search": product});

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelGetAllProduct.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }

  Future<ModelSudahDibeli?> getSudahDibeli(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'transaction?status=paid&patient=$id';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelTransaction = ModelSudahDibeli.fromJson(response.data);
        return modelTransaction;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ModelPromotion?> getPromotion() async {
    Dio dio = ApiInterface.instance.api;
    String url = 'promotion?status=active';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelTransaction = ModelPromotion.fromJson(response.data);
        return modelTransaction;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ModelTrasactionSection?> getBelumDibayar(String id) async {
    Dio dio = ApiInterface.instance.api;
    String url = 'transaction?status=pending&patient=$id';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelTransaction = ModelTrasactionSection.fromJson(response.data);
        print(modelTransaction.message);
        return modelTransaction;
      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<ModelBestSellerProduct?> getBestsellerProduct() async {
    Dio dio = ApiInterface.instance.api;
    String url = 'report/popular/product/this-month';

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelBestSellerProduct.fromJson(response.data);

        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<ModelBestSellerTreatment?> getBestsellerTreatment() async {
    Dio dio = ApiInterface.instance.api;
    String url = 'report/popular/treatment/this-month';

    try {
      Response response = await dio.get(url);

      if (response.statusCode == 200) {
        var modelGetAllProduct = ModelBestSellerTreatment.fromJson(response.data);
        return modelGetAllProduct;
      } else {
        return null;
      }
    } catch (e) {
      // log(e);
      return null;
    }
  }
}
