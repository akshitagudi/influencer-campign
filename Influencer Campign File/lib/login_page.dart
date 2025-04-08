import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_page.dart';
import 'utils/app_colors.dart';
import 'login_controller.dart';
import 'utils/responsive_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: _buildLoginPage(context, isDesktop: false),
      tablet: _buildLoginPage(context, isDesktop: false),
      desktop: _buildLoginPage(context, isDesktop: true),
    );
  }

  Widget _buildLoginPage(BuildContext context, {required bool isDesktop}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: isDesktop ? screenWidth * 0.4 : screenWidth * 0.85,
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 40 : 20,
              vertical: isDesktop ? 30 : 20,
            ),
            decoration: isDesktop
                ? BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  )
                : null,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // App Title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Influencer Campaign Tracker',
                        style: TextStyle(
                          color: AppColors.mainColor,
                          fontSize: isDesktop ? 40 : screenWidth * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  Image.asset(
                    'assets/images/icon3.png',
                    height:
                        isDesktop ? screenHeight * 0.25 : screenHeight * 0.30,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Login Heading
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontSize: isDesktop ? 28 : screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Username Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        prefixIcon:
                            Icon(Icons.person, color: AppColors.mainColor),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.02),

                  // Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon:
                            Icon(Icons.lock, color: AppColors.mainColor),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: AppColors.mainColor,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(16),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.04),

                  // Login Button
                  GestureDetector(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        bool success = await loginController.login(
                          usernameController.text.trim(),
                          passwordController.text.trim(),
                        );
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Login Success',
                                style: TextStyle(
                                    fontSize: 15, color: AppColors.mainColor),
                              ),
                              backgroundColor: Colors.white,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          Future.delayed(Duration(seconds: 4), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashboardPage()),
                            );
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Login failed!',
                                style: TextStyle(color: Colors.red),
                              ),
                              backgroundColor: Colors.white,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: screenHeight * 0.07,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 10,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: isDesktop ? 18 : screenWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
