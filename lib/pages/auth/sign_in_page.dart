import 'package:e_commerce/base/custom_loader.dart';
import 'package:e_commerce/base/show_custom_snackbar.dart';
import 'package:e_commerce/controllers/auth_controller.dart';
import 'package:e_commerce/pages/auth/sign_up_page.dart';
import 'package:e_commerce/routes/route_helper.dart';
import 'package:e_commerce/utils/colors.dart';
import 'package:e_commerce/utils/dimensions.dart';
import 'package:e_commerce/widgets/app_text_field.dart';
import 'package:e_commerce/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    void _logIn(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
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
        authController.logIn(email, password).then((status) {
          if (status.isSuccessful) {
            Get.toNamed(RouteHelper.getInitial());
          } else {
            showCustomSnackBar(status.messsage);
          }
        });
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (_authController) {
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
                              backgroundColor: Colors.white,
                              radius: Dimensions.radius20 * 4,
                              backgroundImage:
                                  AssetImage("assets/image/logo part 1.png"),
                            ),
                          ),
                        ),
                        //welcome
                        Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: Dimensions.width20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                  fontSize: Dimensions.font20 + 50,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Sign into your account",
                                style: TextStyle(
                                    fontSize: Dimensions.font20,
                                    color: Colors.grey[500]
                                    // fontWeight: FontWeight.bold,
                                    ),
                              )
                            ],
                          ),
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
                        SizedBox(height: Dimensions.height10),

                        //tag line
                        Row(
                          children: [
                            Expanded(child: Container()),
                            RichText(
                              text: TextSpan(
                                text: "Sign into your account",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.font20),
                              ),
                            ),
                            SizedBox(width: Dimensions.width20),
                          ],
                        ),

                        SizedBox(height: Dimensions.screenHeight * 0.05),
                        //Sign In button
                        GestureDetector(
                          onTap: () {
                            _logIn(_authController);
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
                              text: "Sign In",
                              size: Dimensions.font20 + 10,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        SizedBox(height: Dimensions.screenHeight * 0.05),

                        //Sign up options
                        RichText(
                          text: TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.font20),
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.to(() => SignUpPage(),
                                          transition: Transition.fade),
                                    text: " Create",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.mainBlackColor,
                                        fontSize: Dimensions.font20)),
                              ]),
                        ),
                      ],
                    ),
                  )
                : CustomLoader();
          },
        ));
  }
}
