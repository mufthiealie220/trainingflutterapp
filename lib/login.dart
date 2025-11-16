import 'package:flutter/material.dart';
import 'package:appbar/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Simpan username ke local storage
  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
  }

  // Reusable TextField
  Widget _inputField(TextEditingController controller, String placeholder, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: placeholder,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }

  // Dialog hasil login
  _showDialog(String pesan, Widget page) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(pesan),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => page),
              );
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              _inputField(_usernameController, "Masukkan Username", false),
              const SizedBox(height: 15),

              _inputField(_passwordController, "Masukkan Password", true),
              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (_usernameController.text == 'mufthie' &&
                        _passwordController.text == 'admin') {
                      saveData();
                      _showDialog('Login Berhasil', const HomePage());
                    } else {
                      _showDialog('Login Gagal, Silahkan Coba Lagi', const LoginPage());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
