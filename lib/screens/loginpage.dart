import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hemsirem/firebase/auth_controller.dart';
import 'package:hemsirem/getx/kayitcontroller.dart';
import 'package:hemsirem/widgets/my_text.dart';
import 'package:hemsirem/widgets/my_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _password2EditingController;
  late TextEditingController _telefonEditingController;
  late AuthController _authController;
  late GlobalKey formKey;
  List<int> sifre = [];
  bool _isVisible = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _authController = AuthController.instance;
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _password2EditingController = TextEditingController();
    _telefonEditingController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _password2EditingController.dispose();
    _telefonEditingController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: Get.size.height,
            maxWidth: Get.size.width,
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.blue.shade800,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          )),
          child: GetBuilder(
            init: Get.put(KayitController()),
            builder: (Object kayitController) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildUstYazi(kayitController),
                      buildKayitGirisEkrani(kayitController),
                    ],
                  ),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Üst Kısım Yazısı
  Expanded buildUstYazi(kayitController) {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KayitController.to.myUstTextKontrol(),
            const SizedBox(height: 10),
            const MyText(
              "Uygulamamıza Hoş Geldiniz",
              size: 20,
              fontWeight: FontWeight.w300,
            ),
          ],
        ),
      ),
    );
  }

  /// Kayıt ve giriş ekranı yazısı
  Expanded buildKayitGirisEkrani(kayitController) {
    return Expanded(
      flex: 5,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              MyTextField(
                textEditingController: _emailEditingController,
                formKey: formKey,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (email) {
                  if (email != null && !EmailValidator.validate(email)) {
                    return "Lütfen Geçerli Bir Mail Adresi Giriniz.";
                  } else {
                    return "";
                  }
                },
                hintText: "E - Mail",
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              MyTextField(
                textEditingController: _passwordEditingController,
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                validator: (password) {
                  if (password == null || password.length < 7) {
                    return "Lütfen En Az 8 Karakter Şifre Giriniz.";
                  } else {
                    return "";
                  }
                },
                hintText: "Parola",
                icon: Icons.vpn_key,
                obscureText: _isVisible ? false : true,
                suffixicon: InkWell(
                  onTap: () {
                    if (_isVisible) {
                      setState(() {
                        _isVisible = false;
                      });
                    } else {
                      setState(() {
                        _isVisible = false;
                      });
                      _isVisible = true;
                    }
                  },
                  child: _isVisible
                      ? const Icon(Icons.remove_red_eye)
                      : const Icon(Icons.remove_red_eye_outlined),
                ),
              ),

              /// Eğer kayıt olacaksa aşağıdaki 2 method çalışacak.
              KayitController.to.mySizeBoxKontol(),
              KayitController.to.myTextKontrol(),
              KayitController.to.mySizeBoxKontol(),
              KayitController.to.myTelefonKontrol(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      KayitController.to.kayitKontrol();
                    },
                    child: KayitController.to.myTextButonKontrol(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              MaterialButton(
                  color: Colors.blue.shade800,
                  child: KayitController.to.myMaterialButonKontrol(),
                  onPressed: () {
                    if (_emailEditingController.text.isNotEmpty &&
                        _passwordEditingController.text.isNotEmpty) {
                      setState(() {
                        isLoading = true;
                      });
                      kayitController.kayitliMi == true
                          ? _authController.loginMethod(
                              _emailEditingController.text.toString(),
                              _passwordEditingController.text.toString(),
                            )
                          : _authController
                              .registerMethod(
                              _emailEditingController.text.toString(),
                              _passwordEditingController.text.toString(),
                              _telefonEditingController.text.toString(),
                            )
                              .catchError((error) {
                              if (error.toString().contains("wrong-password")) {
                                Get.snackbar("Parola Hatası", "Yanlış Parola");
                              }
                              if (error.toString().contains("user-not-found")) {
                                Get.snackbar(
                                    "Kullanıcı Hatası", "Kullanıcı Yok");
                              }
                              if (error.toString().contains("invalid-email")) {
                                Get.snackbar("Geçersiz Email",
                                    "Yazmış olduğunuz email geçersiz");
                              }
                            }).whenComplete(() {
                              setState(() {
                                isLoading = false;
                              });
                            });
                    } else {
                      Get.snackbar("Hata", "Lütfen kontrol ediniz");
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
