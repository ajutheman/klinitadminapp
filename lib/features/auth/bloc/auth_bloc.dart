// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../core/api_client.dart';
// import '../../../core/shared_pref.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';
//
// //
// // class AuthBloc extends Bloc<AuthEvent, AuthState> {
// //   AuthBloc() : super(AuthInitial()) {
// //     on<LoginRequested>((event, emit) async {
// //       emit(AuthLoading());
// //       try {
// //         final res = await ApiClient.postForm('/admin/login', {
// //           'email': event.email,
// //           'password': event.password,
// //         });
// //         final token = res.data['token'];
// //         await SharedPref.setToken(token);
// //         emit(AuthSuccess());
// //       } catch (e) {
// //         emit(AuthFailure('Login failed'));
// //       }
// //     });
// //   }
// // }
// // login_bloc.dart
// class LoginBloc extends Bloc<LoginEvent, LoginState> {
//   final AuthRepository authRepository;
//
//   LoginBloc(this.authRepository) : super(LoginInitial()) {
//     on<LoginSubmitted>(_onLoginSubmitted);
//   }
//
//   Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter emit) async {
//     emit(LoginLoading());
//     try {
//       final response = await authRepository.login(event.email, event.password);
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString('admin_token', response.token);
//       emit(LoginSuccess());
//     } catch (e) {
//       emit(LoginFailure(e.toString()));
//     }
//   }
// }
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';
// import 'login_event.dart';
// import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    try {
      final response = await authRepository.login(event.email, event.password);
      // Store token in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('admin_token', response.token);
      // final prefs = await SharedPreferences.getInstance();
      // await prefs.setString('admin_token', response.token);
      await prefs.setInt('admin_id', response.adminId);
      await prefs.setString('admin_name', response.name);
      await prefs.setString('admin_email', response.email);
      // Get and print FCM token
      final fcmToken = await FirebaseMessaging.instance.getToken();
      print("🔥 FCM Token: $fcmToken");

      // Optionally: call an API to register the FCM token
      if (fcmToken != null) {
        await authRepository.registerFcmToken(fcmToken); // <-- implement this
      }
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginFailure(error: e.toString()));
    }
  }
}
