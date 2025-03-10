import 'package:ecommerce_website/core/routing/app_router.dart';
import 'package:ecommerce_website/core/shared/custom_footer_widget.dart';
import 'package:ecommerce_website/core/validation/text_validation.dart';
import 'package:ecommerce_website/features/authentication/logic/register_cubit/register_cubit.dart';
import 'package:ecommerce_website/features/authentication/presentation/widgets/custom_auth_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
        child: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              isEnabled = false;
            }
            if (state is RegisterSuccess) {
              context.push(AppRouter.homeScreen);
            }
            if (state is RegisterFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errMessage)),
              );
            }
          },
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sign Up to Exclusive',
                              style: TextStyle(
                                fontSize: isMobile ? 24.sp : 14.sp,
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
                                } else if (!TextValidation.isValidEmail(
                                    value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            TextFormField(
                              enabled: isEnabled,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }

                                return null;
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
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
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
                                  height: 40.h,
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
                                );
                              },
                            ),
                            SizedBox(height: 16.h),
                            SizedBox(
                              width: double.infinity,
                              height: 56.h,
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  BlocProvider.of<RegisterCubit>(context)
                                      .signUpWithGoogle();
                                },
                                icon: Image.asset(
                                  'assets/icons/IconGoogle.png',
                                  height: 20.h,
                                ),
                                label: Text(
                                  'Login with Google',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: isMobile ? 14.sp : 8.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: Colors.grey[300]!),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: isMobile ? 8.h : 24.h),
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
                                    fontSize: isMobile ? 14.sp : 8.sp,
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
