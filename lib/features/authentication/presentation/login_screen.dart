import 'package:ecommerce_website/core/routing/app_router.dart';
import 'package:ecommerce_website/core/shared/custom_footer_widget.dart';
import 'package:ecommerce_website/core/validation/text_validation.dart';
import 'package:ecommerce_website/features/authentication/logic/google_cubit/google_cubit.dart';
import 'package:ecommerce_website/features/authentication/logic/login_cubit/login_cubit.dart';
import 'package:ecommerce_website/features/authentication/presentation/widgets/custom_auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _searchController = TextEditingController();
  bool isEnabled = true;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CustomAuthAppbar(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16.w : 24.w,
                vertical: isMobile ? 10.h : 60.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? double.infinity : 300,
                    ),
                    child: Form(
                      key: _formKey,
                      child: BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {
                          if (state is LoginLoading) {
                            isEnabled = false;
                          }
                          if (state is LoginSuccess) {
                            context.push(AppRouter.homeScreen);
                          }
                          if (state is LoginFailure) {
                            isEnabled = true;
                          }
                        },
                        builder: (context, state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Log In to Exclusive',
                                style: TextStyle(
                                  fontSize: isMobile ? 24.sp : 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Enter your details below',
                                style: TextStyle(
                                  fontSize: isMobile ? 14.sp : 8.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 14.h),
                              TextFormField(
                                  enabled: isEnabled,
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    errorText: (state is LoginFailure &&
                                            (state).errMessage.isNotEmpty)
                                        ? (state).errMessage // ✅
                                        : null,
                                    hintText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Your Email";
                                    } else {
                                      TextValidation.emailValidator(value);
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 20.h),
                              TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  enabled: isEnabled,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Your Password";
                                    } else {
                                      TextValidation.passwordValidator(value);
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 30.h),
                              SizedBox(
                                width: double.infinity,
                                height: 45.h,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      BlocProvider.of<LoginCubit>(context)
                                          .login(_emailController.text,
                                              _passwordController.text);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFDB4444),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  child: state is LoginLoading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 3,
                                            color: Colors.white,
                                          ))
                                      : Text(
                                          'Login',
                                          style: TextStyle(
                                            fontSize: isMobile ? 16.sp : 8.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              BlocConsumer<GoogleCubit, GoogleState>(
                                listener: (context, state) {
                                  if (state is GoogleLoading) {
                                    isEnabled = false;
                                  }
                                  if (state is GoogleSuccess) {
                                    isEnabled = true;
                                    context.push(AppRouter.homeScreen);
                                  }
                                  if (state is GoogleFailure) {
                                    isEnabled = true;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(state.errMessage),
                                        backgroundColor: Colors.black,
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return SizedBox(
                                    width: double.infinity,
                                    height: 56.h,
                                    child: OutlinedButton.icon(
                                      onPressed: () async {
                                        await BlocProvider.of<GoogleCubit>(
                                                context)
                                            .signUpWithGoogle();
                                      },
                                      icon: Image.asset(
                                        'assets/icons/IconGoogle.png',
                                        height: 20.h,
                                      ),
                                      label: state is GoogleLoading
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                color: Colors.black,
                                              ),
                                            )
                                          : Text(
                                              'Login with Google',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    isMobile ? 14.sp : 8.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            color: Colors.grey[300]!),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.r),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: isMobile ? 8.h : 24.h),
                              Center(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password ?',
                                    style: TextStyle(
                                      color: const Color(0xffDB4444),
                                      fontSize: isMobile ? 14.sp : 8.sp,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: isMobile ? 8.h : 24.h),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    GoRouter.of(context)
                                        .go(AppRouter.signUpScreen);
                                  },
                                  child: Text(
                                    'Don\'t Have An Account? Sign Up!',
                                    style: TextStyle(
                                      color: const Color(0xffDB4444),
                                      fontSize: isMobile ? 14.sp : 8.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const CustomFooterWidget()
          ],
        ),
      ),
    );
  }
}
