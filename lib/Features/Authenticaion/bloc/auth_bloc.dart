import 'package:bloc/bloc.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter_movie/DI/get_it.dart';
import 'package:flutter_movie/Features/Authenticaion/bloc/auth_event.dart';
import 'package:flutter_movie/Features/Authenticaion/bloc/auth_state.dart';
import 'package:flutter_movie/Features/Authenticaion/data/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final iAuthRepository _authRepository;
  final EmailOTP myAuth = locator.get();
  AuthBloc(this._authRepository) : super(AuthInitState()) {
    on<AuthRequestRegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      var response = await _authRepository.register(event.user);

      emit(AuthRequestSuccessState(response));
    });

    on<AuthRequestLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      var response =
          await _authRepository.login(event.username, event.password);

      emit(AuthRequestSuccessState(response));
    });

    on<AuthSendEmailEvent>((event, emit) async {
      await myAuth.setConfig(
          appEmail: "mobin.ahmadiaa6@gmail.com",
          appName: "aio movie",
          userEmail: event.emailText,
          otpLength: 5,
          otpType: OTPType.digitsOnly);

      var isSend = await myAuth.sendOTP() == true;

      emit(AuthSendEmailSuccessState(isSend));
    });
  }
}
