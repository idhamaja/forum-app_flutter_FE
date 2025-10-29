import 'package:flutter/material.dart';
import 'package:forum_apps/controllers/authentication.dart';
import 'package:forum_apps/views/register_page.dart';
import 'package:forum_apps/views/widgets/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationController _authenticationController = Get.put(
    AuthenticationController(),
  );

  // Add a form key for validation
  final _formKey = GlobalKey<FormState>();

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final result = await _authenticationController.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If login fails and returns null, show error
      if (result == null && mounted) {
        // Error is already handled in the controller, but you can add additional handling here if needed
        print("Login failed - returned null");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to\n Forum Apps',
                  style: GoogleFonts.poppins(
                    fontSize: size * 0.080,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                InputWidget(
                  hintText: 'Username',
                  obscureText: false,
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),

                //
                const SizedBox(height: 35),

                //
                InputWidget(
                  hintText: 'Password',
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                //
                const SizedBox(height: 50),

                //
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: _authenticationController.isLoading.value
                      ? null
                      : _loginUser,
                  child: Obx(() {
                    return _authenticationController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: size * 0.040,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                  }),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: _authenticationController.isLoading.value
                      ? null
                      : () {
                          Get.to(() => const RegisterPage());
                        },
                  child: Text(
                    'Register Here',
                    style: GoogleFonts.poppins(
                      fontSize: size * 0.040,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                const Text("Develop by Idhamaja"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
