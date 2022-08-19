import 'package:e_commerce/base/custom_loader.dart';
import 'package:e_commerce/base/show_custom_snackbar.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/models/sign_up_body_model.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:e_commerce/widgets/static_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void _registration(AuthController authController) {
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar(
          "Type in your name",
          title: "Name",
        );
      } else if (phone.isEmpty) {
        showCustomSnackBar(
          "Type in your phone number ",
          title: "Phone number",
        );
      } else if (email.isEmpty) {
        showCustomSnackBar(
          "Type in your email address",
          title: "Email",
        );
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar(
          "Type in a valid email address",
          title: "Invalid email address",
        );
      } else if (password.isEmpty) {
        showCustomSnackBar(
          "Type in your password",
          title: "Password",
        );
      } else if (password.length < 6) {
        showCustomSnackBar(
          "Password cannot be less than six(6) characters",
          title: "Password",
        );
      } else {
        SignUpBodyModel signUpBody = SignUpBodyModel(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccessful) {
            print("Successful registration");
            Get.offNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.messsage);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor:
            Get.isDarkMode ? context.theme.primaryColorDark : Colors.white,
        body: GetBuilder<AuthController>(builder: (_authController) {
          return !_authController.isLoading
              ? SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      //app logo
                      Container(
                        height: Dimensions.screenHeight * 0.25,
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Get.isDarkMode
                                ? context.theme.primaryColorDark
                                : Colors.white,
                            radius: Dimensions.radius20 * 4,
                            backgroundImage:
                                AssetImage("assets/image/logo part 1.png"),
                          ),
                        ),
                      ),
                      //Name
                      AppTextField(
                        textController: nameController,
                        hintText: "Name",
                        icon: Icons.person,
                        color: AppColors.yellowColor,
                      ),
                      SizedBox(height: Dimensions.height20),
                      //email
                      AppTextField(
                        textController: emailController,
                        hintText: "Email",
                        icon: Icons.email,
                        color: AppColors.yellowColor,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: Dimensions.height20),
                      //password
                      AppTextField(
                        textController: passwordController,
                        hintText: "Password",
                        icon: Icons.password_sharp,
                        color: AppColors.yellowColor,
                        obscureText: true,
                      ),
                      SizedBox(height: Dimensions.height20),
                      //phone
                      AppTextField(
                        textController: phoneController,
                        hintText: "Phone",
                        icon: Icons.phone,
                        color: AppColors.yellowColor,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: Dimensions.height20),
                      //Sign Up button
                      GestureDetector(
                        onTap: () {
                          _registration(_authController);
                        },
                        child: Container(
                          width: Dimensions.screenWidth / 2,
                          height: Dimensions.screenHeight / 13,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius30),
                              color: AppColors.mainColor),
                          child: Center(
                              child: BigText(
                            text: "Sign Up",
                            size: Dimensions.font20 + 10,
                            color: Colors.white,
                          )),
                        ),
                      ),
                      SizedBox(height: Dimensions.height10),
                      //tag line
                      RichText(
                        text: TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Get.back(),
                          text: "Have an account already?",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font20),
                        ),
                      ),
                      SizedBox(height: Dimensions.screenHeight * 0.05),
                      //Sign up options
                      RichText(
                        text: TextSpan(
                          text: "Use one of the following to sign in",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.font16),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                            3,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: Get.isDarkMode
                                        ? context.theme.primaryColorDark
                                        : Colors.white,
                                    radius: Dimensions.radius30,
                                    backgroundImage: AssetImage(
                                        "assets/image/" + signUpImages[index]),
                                  ),
                                )),
                      )
                    ],
                  ),
                )
              : const CustomLoader();
        }));
  }
}
