import 'package:flutter/material.dart';
import 'package:forum_apps/controllers/authentication.dart';
import 'package:forum_apps/views/login_page.dart';
import 'package:forum_apps/views/widgets/input_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthenticationController _authenticationController = Get.put(
    AuthenticationController(),
  );

  // Add a form key for validation
  final _formKey = GlobalKey<FormState>();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      final result = await _authenticationController.register(
        name: _nameController.text.trim(),
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // If registration is successful, clear fields and navigate to login
      if (result != null) {
        _clearFields();
        Get.offAll(() => const LoginPage());
      }
    }
  }

  void _clearFields() {
    _nameController.clear();
    _usernameController.clear();
    _emailController.clear();
    _passwordController.clear();
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
                  'Register Page',
                  style: GoogleFonts.poppins(
                    fontSize: size * 0.080,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                InputWidget(
                  hintText: 'Name',
                  obscureText: false,
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputWidget(
                  hintText: 'Username',
                  obscureText: false,
                  controller: _usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                InputWidget(
                  hintText: 'Email',
                  obscureText: false,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@') || !value.contains('.')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 40),
                Obx(() {
                  return ElevatedButton(
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
                        : _registerUser,
                    child: _authenticationController.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Register',
                            style: GoogleFonts.poppins(
                              fontSize: size * 0.040,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                }),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: _authenticationController.isLoading.value
                      ? null
                      : () {
                          Get.offAll(() => const LoginPage());
                        },
                  child: Text(
                    'Back to Login',
                    style: GoogleFonts.poppins(
                      fontSize: size * 0.040,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
