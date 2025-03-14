import 'package:ecommerce_website/utils/appconstraints.dart';
import 'package:ecommerce_website/core/routing/app_router.dart';
import 'package:ecommerce_website/shared/custom_footer_widget.dart';
import 'package:ecommerce_website/utils/validation/text_validation.dart';
import 'package:ecommerce_website/features/authentication/logic/google_cubit/google_cubit.dart';
import 'package:ecommerce_website/features/authentication/logic/register_cubit/register_cubit.dart';
import 'package:ecommerce_website/features/authentication/presentation/widgets/custom_auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _searchController = TextEditingController();
  bool isEnabled = true;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(120),
        child: CustomAuthAppbar(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              isEnabled = false;
            }
            if (state is RegisterSuccess) {
              context.push(AppRouter.homeScreen);
            }
            if (state is RegisterFailure) {
              isEnabled = true;
            }
          },
          builder: (context, state) => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstraints.isMobile(context) ? 16.w : 24.w,
                  vertical: AppConstraints.isMobile(context) ? 10.h : 60.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: AppConstraints.isMobile(context) ? double.infinity : 300,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign Up to Exclusive',
                              style: TextStyle(
                                fontSize: AppConstraints.isMobile(context) ? 24.sp : 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'Enter your details below',
                              style: TextStyle(
                                fontSize: AppConstraints.isMobile(context) ? 14.sp : 8.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 14.h),
                            TextFormField(
                              enabled: isEnabled,
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            TextFormField(
                              enabled: isEnabled,
                              controller: _emailController,
                              decoration: InputDecoration(
                                errorText: (state is RegisterFailure &&
                                        (state).errMessage.isNotEmpty)
                                    ? (state).errMessage // ✅
                                    : null,
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              validator: (value) {
                                return TextValidation.emailValidator(value);
                              },
                            ),
                            SizedBox(height: 20.h),
                            TextFormField(
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
                                return TextValidation.passwordValidator(value);
                              },
                            ),
                            SizedBox(height: 20.h),
                            TextFormField(
                              controller: _confirmPasswordController,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                } else if (value != _passwordController.text) {
                                  return 'Password does not match';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            BlocBuilder<RegisterCubit, RegisterState>(
                              builder: (context, state) {
                                return SizedBox(
                                  width: double.infinity,
                                  height: 45.h,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<RegisterCubit>(context)
                                            .signIn(_emailController.text,
                                                _passwordController.text);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFDB4444),
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                    ),
                                    child: state is RegisterLoading
                                        ? const SizedBox(
                                            height: 20,
                                            width: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 3,
                                              color: Colors.white,
                                            ))
                                        : Text(
                                            'Sign Up',
                                            style: TextStyle(
                                              fontSize: AppConstraints.isMobile(
                                                      context) ? 16.sp : 8.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                  ),
                                );
                              },
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
                                    onPressed: () {
                                      BlocProvider.of<GoogleCubit>(context)
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
                                            'Sign Up with Google',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: AppConstraints.isMobile(
                                                      context) ? 14.sp : 8.sp,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                    style: OutlinedButton.styleFrom(
                                      side:
                                          BorderSide(color: Colors.grey[300]!),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.r),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: AppConstraints.isMobile(context) ? 8.h : 24.h),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  GoRouter.of(context)
                                      .go(AppRouter.loginScreen);
                                },
                                child: Text(
                                  'Already have an account ?',
                                  style: TextStyle(
                                    color: const Color(0xffDB4444),
                                    fontSize: AppConstraints.isMobile(context) ? 14.sp : 8.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
      ),
    );
  }
}
