// import 'package:airbnb_flutter_clone/airbnb_clone/notifier/authentication_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'home_screen.dart';
//
// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});
//
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   bool isSignUp = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(title: Text(isSignUp ? "Sign Up" : "Sign In")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//                 controller: emailController,
//                 decoration: InputDecoration(labelText: 'Email')),
//             TextField(
//                 controller: passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (isSignUp) {
//                   await authProvider.signup(
//                       emailController.text, passwordController.text);
//                 } else {
//                   await authProvider.signin(
//                       emailController.text, passwordController.text);
//                 }
//                 if (authProvider.user != null) {
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()));
//                 }
//               },
//               child: Text(isSignUp ? "Sign Up" : "Sign In"),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   isSignUp = !isSignUp;
//                 });
//               },
//               child: Text(isSignUp
//                   ? "Already have an account? Sign In"
//                   : "Don't have an account? Sign Up"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:airbnb_flutter_clone/airbnb_clone/notifier/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A StatefulWidget to handle Firebase email/password authentication.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>(); // Global key for form validation
  bool isLogin = false; // Tracks whether the user is logging in or signing up
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email/Pass Auth'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Username input field (only shown when signing up)
              !isLogin
                  ? TextFormField(
                      key: const ValueKey('username'),
                      decoration:
                          const InputDecoration(hintText: 'Enter Username'),
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Username must be at least 3 characters long';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          username = value!;
                        });
                      },
                    )
                  : Container(),

              /// Email input field
              TextFormField(
                key: const ValueKey('email'),
                decoration: const InputDecoration(hintText: 'Enter Email'),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Invalid email';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    email = value!;
                  });
                },
              ),

              /// Password input field
              TextFormField(
                obscureText: true,
                key: const ValueKey('password'),
                decoration: const InputDecoration(hintText: 'Enter Password'),
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onSaved: (value) {
                  setState(() {
                    password = value!;
                  });
                },
              ),

              const SizedBox(height: 10),

              /// Submit button for login/signup
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      isLogin
                          ? await authProvider.signin(
                              context, email, password) // Calls signin function
                          : await authProvider.signup(context, email,
                              password); // Calls signup function
                    }
                  },
                  child: Text(isLogin ? 'Login' : 'Signup'),
                ),
              ),

              const SizedBox(height: 10),

              /// Toggle button to switch between login and signup
              TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text(
                  isLogin
                      ? "Don't have an account? Signup"
                      : "Already Signed Up? Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
