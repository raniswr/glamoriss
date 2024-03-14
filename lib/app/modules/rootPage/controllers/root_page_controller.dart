import 'dart:async';
import 'dart:io';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:glamori/app/data/model/model_article.dart';
import 'package:glamori/app/data/model/model_bestseller_product.dart';
import 'package:glamori/app/data/model/model_bestseller_treatment.dart';
import 'package:glamori/app/data/model/model_detail_product.dart';
import 'package:glamori/app/data/model/model_get_all_product.dart';
import 'package:glamori/app/data/model/model_get_profile.dart';
import 'package:glamori/app/data/model/model_promotion.dart';
import 'package:glamori/app/data/model/model_sudah_dibeli.dart';
import 'package:glamori/app/data/model/model_transaction_section.dart';
import 'package:glamori/app/data/model/model_user.dart';
import 'package:glamori/app/data/model/model_videos.dart';
import 'package:glamori/app/data/services/api_services.dart';
import 'package:glamori/app/data/services/user_services.dart';
import 'package:glamori/app/data/stirage_method.dart';
import 'package:glamori/app/modules/rootPage/views/widgets/belanja_widget.dart';
import 'package:glamori/app/modules/rootPage/views/widgets/home_widget.dart';
import 'package:glamori/app/modules/rootPage/views/widgets/login_widget.dart';
import 'package:glamori/app/modules/rootPage/views/widgets/profile_widget.dart';
import 'package:glamori/app/modules/rootPage/views/widgets/transaksi_widget.dart';
import 'package:glamori/app/modules/treatmentPages/controllers/treatment_pages_controller.dart';
import 'package:glamori/app/modules/treatmentPages/views/treatment_pages_view.dart';
import 'package:glamori/app/routes/app_pages.dart';
import 'package:glamori/core/assets.dart';
import 'package:glamori/core/themes/colors.dart';
import 'package:glamori/utils/sqlite_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;
import "dart:ui" as ui;
import 'package:path_provider/path_provider.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RootPageController extends GetxController {
  // final loginFormKey = GlobalKey<FormState>();

  bool isLoading = false;
  int selectedIndex = 0;
  List<IconModel> get icons => [
        IconModel(id: 0, icon: Assets.icHome, size: 24.0, label: 'Home'),
        IconModel(id: 1, icon: Assets.icTreatment, size: 24.0, label: 'Treatment'),
        IconModel(id: 2, icon: Assets.icBelanja, size: 24.0, label: 'Belanja'),
        IconModel(id: 3, icon: Assets.icTransaksi, size: 24.0, label: 'Transaksi'),
        IconModel(id: 4, icon: Assets.icProfile, size: 22.0, label: 'Akun'),
      ];

  List<Widget> pages = [
    const HomeWidget(),
    const TreatmentPagesView(),
    const BelanjaWidget(),
    const TransaksiWidget(),
    const SizedBox.shrink(), // Default widget
  ];
  onItemTapped(int value) {
    selectedIndex = value;
    update();
    if (value == 1) {
      TreatmentPagesController controllerTreatment = Get.isRegistered<TreatmentPagesController>() ? Get.find<TreatmentPagesController>() : Get.put(TreatmentPagesController());
      controllerTreatment.initToday();
    }
    if (UserService.find.user != null) {
      if (value == 3) {
        initPembelian();
      }
    }
    if (value == 2) {
      getAllProduct();
    }
  }

//image coursel home

  List<String> imageUrls = [];
  int currentIndex = 0;
  List<String> profileUrls = [
    "assets/images/profileImage.png",
    "assets/images/qr_profile.jpeg",
  ];
  CarouselController carouselController = CarouselController();
  void nextPage() {
    try {
      currentIndex = currentIndex + 1;

      carouselController.animateToPage(currentIndex);
      update();
    } catch (_) {}
  }

  void onPageChanged(int index, CarouselPageChangedReason reason) {
    try {
      currentIndex = index;
      carouselController.animateToPage(currentIndex);
      update();
    } catch (e) {}
  }

  Future<void> handleRefresh() async {}

  List<BelanjaItem> belanjaItems = [
    BelanjaItem(id: 1, title: "Semua Product"),
    BelanjaItem(id: 2, title: "Perawatan Wajah", icon: ""),
    BelanjaItem(id: 3, title: "Perawatan Kulit", icon: ""),
    BelanjaItem(id: 4, title: "Perawatan Kulit", icon: "")
  ];

  BelanjaItem? selectedBelanjaItem;

  setSelectedBelanjaItem(val) {
    selectedBelanjaItem = val;
    update();
  }

  List<String> items = ['Perempuan', 'Laki-laki'];
  String? selectedItem;
  TextEditingController dateController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime lastDate = DateTime(now.year + 3, now.month, now.day, 23, 59, 59);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: lastDate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.yellow,
            colorScheme: const ColorScheme.light(primary: AppColors.yellow),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      dateController.text = formattedDate;
    }
  }

  setKelamin(value) {
    selectedItem = value;
    update();
  }

  TextEditingController passwordLoginController = TextEditingController();

  bool passwordLoginVisible = true;

  passwordLoginVisibility() {
    passwordLoginVisible = !passwordLoginVisible;
    update();
  }

//Value text feild
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController teleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController passwordControllerProfile = TextEditingController();
  bool passwordVisible = true;
  TextEditingController passwordKonfirmasiController = TextEditingController();
  // bool autoValidate = false;
  bool passwordKonfirmasiVisible = true;
  TextEditingController passwordKataSandiBaruController = TextEditingController();
  bool passwordKataSandiBaruVisible = true;

  void editProfile(BuildContext context) async {
    var dataLogin = await UserService.find.getLocalUser();
    String birthdate = DateFormat('yyyy-MM-dd').format(DateFormat('dd-MM-yyyy').parse(dateController.text));
    print(birthdate);
    var result = await ApiServices.editProfile(
      fullname: namaController.text,
      phone: teleponController.text,
      birthdate: birthdate,
      gender: selectedItem == 'Perempuan' ? 'perempuan' : 'laki-laki',
      email: emailController.text,
      alamat: alamatController.text,
      id: dataLogin?.id,
    );

    if (result == true) {
      EasyLoading.showSuccess('Berhasil edit profile');
      await getProfile(UserService.find.user?.id ?? "");
      update();
    } else {
      EasyLoading.showError('Gagal update profile');
    }

    update();
  }

  void updateToken(BuildContext context) async {
    var dataLogin = await UserService.find.getLocalUser();
    var result = await ApiServices.updateToken(
      id: dataLogin?.id,
    );
    if (result == true) {
      await StorageMethod.removeUserFromLocal();

      Get.offAllNamed(Routes.rootPage);
    }
    update();
  }

  void changePassword(BuildContext context) async {
    var dataLogin = await UserService.find.getLocalUser();
    var result = await ApiServices.changePassword(
      oldPassword: passwordController.text,
      newPassword: passwordKataSandiBaruController.text,
      id: dataLogin?.id,
    );

    update();
  }

  passwordVisibility() {
    passwordVisible = !passwordVisible;
    update();
  }

  passwordKonfirmasiVisibility() {
    passwordKonfirmasiVisible = !passwordKonfirmasiVisible;
    update();
  }

  passwordKataSandiBaruVisibility() {
    passwordKataSandiBaruVisible = !passwordKataSandiBaruVisible;
    update();
  }

  String? imagePath;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      File? croppedFile = await cropImage(pickedImage.path);
      print('bl ${pickedImage.path}');
      if (croppedFile != null) {
        // Update the image path
        imagePath = croppedFile.path;
        print('kheloo ${imagePath}');
        print(imagePath);

        update();

        // Upload the cropped image
        await ApiServices.uploadImage(croppedFile, UserService.find.user?.id ?? '', UserService.find.user?.token ?? '');

        // if (success) {
        //   // Image profile updated successfully
        //   print('Image profile updated successfully');
        // } else {
        //   // Failed to update image profile
        //   print('Failed to update image profile');
        // }
      } else {
        // Handle cropping failure
        print("Image cropping failed");
      }
    } else {
      // No image selected
      print("No image selected");
    }
  }

  Future<File?> cropImage(String imagePath) async {
    try {
      // Crop the image using the image_cropper package
      CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: imagePath, aspectRatioPresets: [
        CropAspectRatioPreset.original,
      ], uiSettings: [
        Platform.isAndroid
            ? AndroidUiSettings(
                toolbarTitle: 'Cropper',
                toolbarColor: Colors.black,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false,
                hideBottomControls: true,
              )
            : IOSUiSettings(
                title: 'Cropper',
              ),
      ]);

      return croppedFile?.path != null ? File(croppedFile!.path) : null;
    } catch (e) {
      return null;
    }
  }

  void deleteImage() {
    imagePath = null;
    update();
  }

  Future<void> cameraImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedImage != null) {
      // Update the image path
      imagePath = pickedImage.path;
      update();
      // print("Image selected: ${pickedImage.path}");
      File? imageFile = File(imagePath ?? '');

      bool success = await ApiServices.editImageProfile(image: imageFile, id: id);
      // print(id);

      if (success) {
        // print('Image profile updated successfully');
      } else {
        // print('Failed to update image profile');
      }
    } else {
      // print("No image selected");
    }
  }

  TextEditingController phoneController = TextEditingController();
  // String? tokenReminder = LocalNotificationService.getFcmToken();
  void login(BuildContext context) async {
    // String? tokenReminder = await FirebaseMessaging.instance.getToken();
    String? tokenReminder = '';
    var result = await ApiServices.login(email: phoneController.text, password: passwordLoginController.text, tokenReminder: tokenReminder ?? '');

    // print(teleponController.text);
    if (result != null) {
      if (result.message == "Login Success") {
        // print('berhasil');
        var user = ModelUser(
          token: result.data?.accessToken,
          fullname: result.data?.patient?.fullname,
          phone: result.data?.patient?.phone,
          id: result.data?.patient?.sId,
          email: result.data?.patient?.email,
          memberId: result.data?.patient?.memberId,
          patientId: result.data?.patient?.patientId,
          isLogin: true,
          lokasi: 'LAMPUNG',
        );
        isLogin = true;
        await StorageMethod.saveUserToLocal(user);

        if (isLogin == true) {
          var dataLogin = await UserService.find.getLocalUser();
          if (dataLogin != null) {
            getProfile(UserService.find.user?.id ?? '');
            initPembelian();
          }
          pages = const [
            HomeWidget(),
            TreatmentPagesView(),
            BelanjaWidget(),
            TransaksiWidget(),
            ProfileWidget(),
          ];
        } else {
          pages = const [
            HomeWidget(),
            LoginWidget(),
            BelanjaWidget(),
            LoginWidget(),
            LoginWidget(),
          ];
        }

        isLogin = true;
        Get.toNamed(Routes.rootPage);

        update();
      }
    }
    update();
  }

  List<String> dateAppoinment = [
    '3',
    '1',
    '2',
    '2',
  ];

  final count = 0.obs;

  void increment() => count.value++;

  ModelGetProfile? users;
  getProfile(String id) async {
    var data = await ApiServices().getProfile(id);
    if (data != null) {
      users = data;
      update();
    }
  }

  ModelGetAllProduct? allProudct;

  getAllProduct() async {
    var dataLokasi = await UserService.find.getLocationUser();
    try {
      if (dataLokasi != null) {
        if (dataLokasi == 'LAMPUNG') {
          var data = await ApiServices().getAllProduct(lokasi: 'lampung');
          if (data != null) {
            allProudct = data;
            update();
          }
        } else if (dataLokasi == 'JAKARTA') {
          var data = await ApiServices().getAllProduct(lokasi: 'jakarta');
          if (data != null) {
            allProudct = data;
            update();
          }
        } else {
          var data = await ApiServices().getAllProduct(lokasi: 'lampung');
          if (data != null) {
            allProudct = data;
            update();
          }
        }
      } else {
        var data = await ApiServices().getAllProduct(lokasi: 'lampung');
        if (data != null) {
          allProudct = data;
          update();
        }
      }
    } catch (e) {
      var data = await ApiServices().getAllProduct(lokasi: 'lampung');
      if (data != null) {
        allProudct = data;
        update();
      }
    }
  }

  ModelVideo? allVideo;
  getAllVideo() async {
    var data = await ApiServices().getAlVideos();
    if (data != null) {
      allVideo = data;
      update();
    }
  }

  ModelArticle? allArticle;
  getAllArticle() async {
    var data = await ApiServices().getAllArticle();
    if (data != null) {
      allArticle = data;
      update();
    }
  }

  ModelBestSellerProduct? bestsellerProudct;

  getBestsellerProduct() async {
    isLoading = true;
    var data = await ApiServices().getBestsellerProduct();
    bestsellerProudct = data;
    update();
    isLoading = false;
  }

  ModelBestSellerTreatment? bestsellerTreatment;
  getBestsellerTreatment() async {
    isLoading = true;
    var data = await ApiServices().getBestsellerTreatment();
    bestsellerTreatment = data;
    update();
    isLoading = false;
  }

  TextEditingController searchController = TextEditingController();
  getSearchProduct(String text) async {
    var data = await ApiServices().getSearchProduct(text);
    if (data != null) {
      allProudct = data;
      update();
    }
  }

  bool isLoadinggetBelumDibayar = false;
  bool isLoadinggetSudahDibeli = false;
  ModelTrasactionSection? transaction;

  Future<void> getBelumDibayar() async {
    isLoadinggetBelumDibayar = true;
    var data = await ApiServices().getBelumDibayar(UserService.find.user?.id ?? "");

    if (data != null) {
      transaction = data;
      isLoadinggetBelumDibayar = false;
      update();
    } else {
      // Handle the case where data is null, for example, show an error message
      print('Failed to fetch data.');
    }
  }

  ModelSudahDibeli? sudahDibeli;

  Future<void> getSudahDibeli() async {
    isLoadinggetSudahDibeli = true;
    var data = await ApiServices().getSudahDibeli(UserService.find.user?.id ?? "");
    if (data != null) {
      sudahDibeli = data;
      isLoadinggetSudahDibeli = false;
      update();
    } else {
      print('Failed to fetch data. getSudahDibeli');
    }
  }

  ModelPromotion? promotion;

  Future<void> getPromotion() async {
    isLoadinggetSudahDibeli = true;
    var data = await ApiServices().getPromotion();
    if (data != null) {
      promotion = data;
      isLoadinggetSudahDibeli = false;
      update();
    } else {
      print('Failed to fetch data. getSudahDibeli');
    }
  }

  int minusFunction(int lenght) {
    int lengFinal = lenght - 1;
    return lengFinal;
  }

  bool isLogin = false;
  String id = '';
  String nameUser = '';
  String? location;

  @override
  void onReady() async {
    getCart();
    var dataLogin = await UserService.find.getLocalUser();

    if (dataLogin != null) {
      isLogin = UserService.find.user?.isLogin ?? false;
      id = UserService.find.user?.id ?? "";
      nameUser = UserService.find.user?.fullname ?? "";

      getProfile(UserService.find.user?.id ?? '');
    }

    if (isLogin) {
      pages[pages.length - 1] = const ProfileWidget();
      pages[pages.length - 4] = const TreatmentPagesView();
      pages[pages.length - 2] = const TransaksiWidget();
    } else {
      pages[pages.length - 1] = const LoginWidget();
      pages[pages.length - 4] = const LoginWidget();
      pages[pages.length - 2] = const LoginWidget();
    }
    if (promotion != null && promotion!.data != null && promotion!.data!.docs != null && promotion!.data!.docs!.isNotEmpty) {
      imageUrls.add(promotion!.data!.docs![0].image ?? '');
      imageUrls.add(promotion!.data!.docs![1].image ?? '');
      imageUrls.add(promotion!.data!.docs![2].image ?? '');
      update();
    }

    update();
    super.onReady();
  }

  List<ModelDetailProduct> carts = [];
  getCart() async {
    var sqlHelper = await SqlLiteHelper.instance.cartTable;
    carts = await sqlHelper.getAllCart();
    print('hello ${carts.length}');
    update();
  }

  getTonamedDetailBelanja(String productId, String productImage) {
    Get.toNamed(
      Routes.detailBelanjaPage,
      arguments: {
        'productId': productId,
        'productImage': productImage,
      },
    )?.then((value) => getCart());
  }

  getTonamedKeranjang() async {
    var dataLogin = await UserService.find.getLocalUser();

    if (dataLogin == null) {
      Get.toNamed(Routes.LOGIN_PAGE);
    } else {
      Get.toNamed(Routes.keranjangPage)?.then((value) => getCart());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    super.dispose();
  }

  String formatDate(String? inputDate) {
    if (inputDate == null || inputDate.isEmpty) {
      return '';
    }

    // Assuming your inputDate is in the format 'yyyy-MM-ddTHH:mm:ss'
    DateTime date = DateTime.parse(inputDate);
    // print(date);

    // Format the date without time and seconds
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);

    // Return the formatted date as a string
    return formattedDate;
  }

  String formatPrice(num productPrice) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return formatter.format(productPrice);
  }

  late YoutubePlayerController controller;
  String videoId = YoutubePlayer.convertUrlToId('') ?? '';
  YoutubePlayerController initializeYoutubePlayerController(String? video) {
    videoId = YoutubePlayer.convertUrlToId(video ?? '') ?? '';
    return YoutubePlayerController(
      initialVideoId: videoId,
      flags: YoutubePlayerFlags(
        isLive: true,
        autoPlay: false,
      ),
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  toLokasi() async {
    Get.toNamed(Routes.LOKASI_PAGE)?.then((value) async {
      var selected = value?['lokasi'];
      if (selected != null) {
        location = selected;
        update();
      }
    });
  }

  @override
  void onInit() async {
    passwordLoginVisible = false;
    currentIndex = 0;
    getAllProduct();
    getAllArticle();
    getAllVideo();

    var dataLokasi = await UserService.find.getLocationUser();
    if (dataLokasi != null) {
      location = dataLokasi;
    }
    update();
    await getPromotion();
    await getBestsellerProduct();
    await getBestsellerTreatment();

    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);

    super.onInit();
  }

  void listener() {
    if (controller.value.isFullScreen) {}
  }

  initPembelian() async {
    print("initPembelian");
    await getBelumDibayar();
  }

  initEdit() async {
    if (users == null) {
      await getProfile(UserService.find.user?.id ?? '');
    }

    namaController.text = users?.data?.fullname ?? '';
    emailController.text = users?.data?.email ?? '';
    teleponController.text = users?.data?.phone ?? '';
    alamatController.text = users?.data?.address ?? '';
    String formattedDate = users?.data?.birthdate != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(users!.data!.birthdate!)) : '';

    dateController.text = formattedDate;
    selectedItem = users?.data?.gender == 'perempuan' ? 'Perempuan' : 'Laki-laki';

    update();
  }
}

class IconModel {
  final int id;
  final String icon;
  final String label;
  final double size;

  IconModel({required this.id, required this.icon, required this.label, required this.size});
}

class BelanjaItem {
  final int id;
  final String title;
  final String? icon;

  BelanjaItem({
    required this.id,
    required this.title,
    this.icon,
  });
}
