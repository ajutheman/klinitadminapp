// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../base/resizer/fetch_pixels.dart';
// import '../../../base/widget_utils.dart';
// import '../../../core/api_service.dart';
// import '../../home/home_screen.dart';
// import '../bloc/auth_bloc.dart';
// import '../bloc/auth_event.dart';
// import '../bloc/auth_state.dart';
// import '../repository/auth_repository.dart';
//
// class LoginScreen extends StatelessWidget {
//   LoginScreen({Key? key}) : super(key: key);
//
//   final TextEditingController _emailController =
//       TextEditingController(text: "test@example.com");
//   final TextEditingController _passwordController =
//       TextEditingController(text: "password");
//   bool isPassVisible = true;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Admin Login')),
//       body: BlocProvider(
//         create: (context) =>
//             LoginBloc(authRepository: AuthRepository(ApiService())),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: BlocListener<LoginBloc, LoginState>(
//             listener: (context, state) {
//               if (state is LoginSuccess) {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (_) => const HomeScreen()));
//               } else if (state is LoginFailure) {
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(SnackBar(content: Text(state.error)));
//               }
//             },
//             child: Column(
//               children: [
//                 getVerSpace(FetchPixels.getPixelHeight(30)),
//                 getSvgImage("kleanit.svg",
//                     height: FetchPixels.getPixelHeight(124),
//                     width: FetchPixels.getPixelHeight(84.77)),
//                 getVerSpace(FetchPixels.getPixelHeight(30)),
//                 getCustomFont("Login", 24, Colors.black, 1,
//                     fontWeight: FontWeight.w800),
//                 getVerSpace(FetchPixels.getPixelHeight(10)),
//                 getCustomFont("Glad to meet you again!", 16, Colors.black, 1,
//                     fontWeight: FontWeight.w400),
//                 getVerSpace(FetchPixels.getPixelHeight(30)),
//                 getDefaultTextFiledWithLabel(
//                   context,
//                   "Email",
//                   // emailController,
//                   _emailController,
//                   Colors.grey,
//                   height: FetchPixels.getPixelHeight(60),
//                   withprefix: true,
//                   image: "message.svg",
//                   function: () {},
//                   isEnable: false,
//                 ),
//                 getVerSpace(FetchPixels.getPixelHeight(20)),
//                 getDefaultTextFiledWithLabel(
//                   context,
//                   "Password",
//                   _passwordController,
//                   // passwordController,
//                   Colors.grey,
//                   height: FetchPixels.getPixelHeight(60),
//                   withprefix: true,
//                   image: "lock.svg",
//                   isPass: isPassVisible,
//                   withSufix: true,
//                   suffiximage: "eye.svg",
//                   imagefunction: () {
//                     // setState(() {
//                     //   isPassVisible = !isPassVisible;
//                     // });
//                   },
//                   function: () {},
//                   isEnable: false,
//                 ),
//                 getVerSpace(FetchPixels.getPixelHeight(19)),
//                 getVerSpace(FetchPixels.getPixelHeight(49)),
//                 TextField(
//                   controller: _emailController,
//                   decoration: const InputDecoration(labelText: "Email"),
//                 ),
//                 getCustomFont("Login", 24, Colors.black, 1,
//                     fontWeight: FontWeight.w800),
//                 TextField(
//                   controller: _passwordController,
//                   decoration: const InputDecoration(labelText: "Password"),
//                   obscureText: true,
//                 ),
//                 const SizedBox(height: 20),
//                 BlocBuilder<LoginBloc, LoginState>(
//                   builder: (context, state) {
//                     if (state is LoginLoading) {
//                       return const CircularProgressIndicator();
//                     }
//                     return ElevatedButton(
//                       onPressed: () {
//                         context.read<LoginBloc>().add(
//                               LoginSubmitted(
//                                 email: _emailController.text,
//                                 password: _passwordController.text,
//                               ),
//                             );
//                       },
//                       child: const Text("Login"),
//                     );
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../base/resizer/fetch_pixels.dart';
// import '../../../base/widget_utils.dart';
// import '../../../core/api_service.dart';
// import '../../home/home_screen.dart';
// import '../bloc/auth_bloc.dart';
// import '../bloc/auth_event.dart';
// import '../bloc/auth_state.dart';
// import '../repository/auth_repository.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController =
//       TextEditingController(text: "test@example.com");
//   final TextEditingController _passwordController =
//       TextEditingController(text: "password");
//
//   bool isPassVisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     // FetchPixels.setPixelRatio(context); // ensure pixel ratio is set
//     FetchPixels.init(context);
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: BlocProvider(
//         create: (_) => LoginBloc(authRepository: AuthRepository(ApiService())),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: FetchPixels.getPixelWidth(20),
//             vertical: FetchPixels.getPixelHeight(40),
//           ),
//           child: BlocListener<LoginBloc, LoginState>(
//             listener: (context, state) {
//               if (state is LoginSuccess) {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const HomeScreen()));
//               } else if (state is LoginFailure) {
//                 ScaffoldMessenger.of(context)
//                     .showSnackBar(SnackBar(content: Text(state.error)));
//               }
//             },
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   getVerSpace(FetchPixels.getPixelHeight(40)),
//                   // Center(
//                   //   child:
//                   //   // getSvgImage("kleanit.svg",
//                   //   //     height: FetchPixels.getPixelHeight(100),
//                   //   //     width: FetchPixels.getPixelWidth(100)),
//                   // ),
//                   getSvgImage("trace.svg",
//                       // getSvgImage("kleanit (1).svg",
//                       height: FetchPixels.getPixelHeight(124),
//                       width: FetchPixels.getPixelHeight(84.77)),
//                   getVerSpace(FetchPixels.getPixelHeight(40)),
//                   getCustomFont("Admin Login", 26, Colors.black, 1,
//                       fontWeight: FontWeight.bold),
//                   getVerSpace(FetchPixels.getPixelHeight(10)),
//                   getCustomFont("Welcome back! Please login to continue.", 16,
//                       Colors.black54, 1),
//                   getVerSpace(FetchPixels.getPixelHeight(30)),
//                   getDefaultTextFiledWithLabel(
//                     context,
//                     "Email",
//                     _emailController,
//                     Colors.grey,
//                     height: FetchPixels.getPixelHeight(60),
//                     withprefix: true,
//                     image: "message.svg",
//                     function: () {},
//                   ),
//                   getVerSpace(FetchPixels.getPixelHeight(20)),
//                   getDefaultTextFiledWithLabel(
//                     context,
//                     "Password",
//                     _passwordController,
//                     Colors.grey,
//                     height: FetchPixels.getPixelHeight(60),
//                     withprefix: true,
//                     image: "lock.svg",
//                     isPass: !isPassVisible,
//                     withSufix: true,
//                     suffiximage: isPassVisible ? "eye_off.svg" : "eye.svg",
//                     imagefunction: () {
//                       setState(() {
//                         isPassVisible = !isPassVisible;
//                       });
//                     },
//                     function: () {},
//                   ),
//                   getVerSpace(FetchPixels.getPixelHeight(30)),
//                   BlocBuilder<LoginBloc, LoginState>(
//                     builder: (context, state) {
//                       if (state is LoginLoading) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//
//                       return SizedBox(
//                         width: double.infinity,
//                         height: FetchPixels.getPixelHeight(50),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             context.read<LoginBloc>().add(LoginSubmitted(
//                                   email: _emailController.text,
//                                   password: _passwordController.text,
//                                 ));
//                           },
//                           child: const Text("Login"),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../base/app_theme.dart';
import '../../../base/resizer/fetch_pixels.dart';
import '../../../base/widget_utils.dart';
import '../../../core/api_service.dart';
import '../../home/home_screen.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../repository/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController =
  TextEditingController(text: '');
  final _passwordController =
  TextEditingController(text: '');
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    FetchPixels.init(context);
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: BlocProvider(
        create: (_) =>
            LoginBloc(authRepository: AuthRepository(ApiService())),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getPixelWidth(24),
            vertical: FetchPixels.getPixelHeight(48),
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (ctx, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Logo
                  getVerSpace(FetchPixels.getPixelHeight(60)),
                  getSvgImage(
                    'trace.svg',
                    height: FetchPixels.getPixelHeight(120),
                    width: FetchPixels.getPixelWidth(80),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(40)),

                  // Title
                  Text('Admin Login',
                      style: theme.textTheme.headlineSmall),
                  getVerSpace(FetchPixels.getPixelHeight(8)),
                  Text(
                    'Welcome back! Please login to continue.',
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: AppTheme.lightGrey),
                    textAlign: TextAlign.center,
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(32)),

                  // Email Field
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppTheme.lightGrey),
                      prefixIcon: Icon(Icons.email,
                          color: theme.colorScheme.secondary),
                      filled: true,
                      fillColor: theme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        BorderSide.none,
                      ),
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(20)),

                  // Password Field
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscure,
                    style: theme.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: theme.textTheme.bodyMedium
                          ?.copyWith(color: AppTheme.lightGrey),
                      prefixIcon: Icon(Icons.lock,
                          color: theme.colorScheme.secondary),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _obscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: theme.colorScheme.secondary),
                        onPressed: () =>
                            setState(() => _obscure = !_obscure),
                      ),
                      filled: true,
                      fillColor: theme.cardColor,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        BorderSide.none,
                      ),
                    ),
                  ),
                  getVerSpace(FetchPixels.getPixelHeight(32)),

                  // Login Button
                  BlocBuilder<LoginBloc, LoginState>(
                    builder: (ctx, state) {
                      if (state is LoginLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        width: double.infinity,
                        height: FetchPixels.getPixelHeight(50),
                        child: ElevatedButton(
                          onPressed: () {
                            ctx.read<LoginBloc>().add(
                              LoginSubmitted(
                                email: _emailController.text,
                                password:
                                _passwordController.text,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            AppTheme.aquaBlue,
                            foregroundColor:
                            AppTheme.white,
                            textStyle: theme.textTheme.labelLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Login'),
                        ),
                      );
                    },
                  ),

                  getVerSpace(FetchPixels.getPixelHeight(20)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
