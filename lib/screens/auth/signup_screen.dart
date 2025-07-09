import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:formz/formz.dart';
import 'package:notes_app/features/auth/presentation/cubit/signup/signup_cubit.dart';
import 'package:notes_app/features/auth/presentation/cubit/signup/signup_state.dart';
import 'package:notes_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:notes_app/features/auth/data/repositories/auth_repository_impl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _termsAccepted = false;

  late final SignupCubit _signupCubit;
  late final AuthRepository _authRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = AuthRepositoryImpl();
    _signupCubit = SignupCubit(_authRepository);
    
    // Initialize form fields in the cubit
    _nameController.addListener(() {
      _signupCubit.nameChanged(_nameController.text);
    });
    _emailController.addListener(() {
      _signupCubit.emailChanged(_emailController.text);
    });
    _passwordController.addListener(() {
      _signupCubit.passwordChanged(_passwordController.text);
    });
    _confirmPasswordController.addListener(() {
      _signupCubit.confirmPasswordChanged(_confirmPasswordController.text);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _signupCubit.close();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _onTermsChanged(bool? value) {
    if (value != null) {
      setState(() {
        _termsAccepted = value;
      });
      _signupCubit.termsChanged(value);
    }
  }

  void _onSignUp() {
    // Trigger validation for all fields first
    _signupCubit.nameChanged(_nameController.text);
    _signupCubit.emailChanged(_emailController.text);
    _signupCubit.passwordChanged(_passwordController.text);
    _signupCubit.confirmPasswordChanged(_confirmPasswordController.text);
    _signupCubit.termsChanged(_termsAccepted);
    
    // If form is valid, proceed with signup
    if (_formKey.currentState?.validate() ?? false) {
      _signupCubit.signup();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black,
              Color(0xFF1A0000),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocProvider.value(
            value: _signupCubit,
            child: BlocConsumer<SignupCubit, SignupState>(
              listener: (context, state) {
                if (state.status == FormzSubmissionStatus.success) {
                  Navigator.pushReplacementNamed(context, '/home');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Account created successfully!'),
                      backgroundColor: Colors.green,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                } else if (state.status == FormzSubmissionStatus.failure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error ?? 'An error occurred'),
                      backgroundColor: Colors.red,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              builder: (context, state) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Back Button and Title
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, color: Colors.white70, size: 20),
                            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Create Account',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Logo/Icon
                      Center(
                        child: Icon(
                          Icons.note_alt_rounded,
                          size: 100,
                          color: Colors.white,
                        ).animate().fadeIn(duration: 300.ms),
                      ),
                      const SizedBox(height: 24),
                      
                      // Form
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Name Field
                            TextFormField(
                              controller: _nameController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(Icons.person_outline, color: Colors.white70),
                                filled: true,
                                fillColor: Colors.black26,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            
                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(color: Colors.white),
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
                                filled: true,
                                fillColor: Colors.black26,
                                errorText: state.email.invalid ? state.email.error : null,
                                errorStyle: const TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                                ),
                              ),
                              onChanged: (value) => _signupCubit.emailChanged(value),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.white70,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                filled: true,
                                fillColor: Colors.black26,
                                errorText: state.password.invalid ? state.password.error : null,
                                errorStyle: const TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                                ),
                              ),
                              onChanged: (value) => _signupCubit.passwordChanged(value),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Confirm Password Field
                            TextFormField(
                              controller: _confirmPasswordController,
                              style: const TextStyle(color: Colors.white),
                              obscureText: _obscureConfirmPassword,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: const TextStyle(color: Colors.white70),
                                prefixIcon: const Icon(Icons.lock_outline, color: Colors.white70),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                                    color: Colors.white70,
                                  ),
                                  onPressed: _toggleConfirmPasswordVisibility,
                                ),
                                filled: true,
                                fillColor: Colors.black26,
                                errorText: !state.passwordsMatch ? 'Passwords do not match' : null,
                                errorStyle: const TextStyle(color: Colors.redAccent),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.white12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                                ),
                              ),
                              onChanged: (value) => _signupCubit.confirmPasswordChanged(value),
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Terms and Conditions
                            Row(
                              children: [
                                Checkbox(
                                  value: _termsAccepted,
                                  onChanged: _onTermsChanged,
                                  activeColor: Colors.redAccent,
                                  checkColor: Colors.white,
                                  fillColor: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                      if (states.contains(MaterialState.selected)) {
                                        return Colors.redAccent;
                                      }
                                      return Colors.grey.shade700;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      style: GoogleFonts.poppins(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                      children: [
                                        const TextSpan(text: 'I agree to the '),
                                        TextSpan(
                                          text: 'Terms of Service',
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // TODO: Navigate to terms of service
                                            },
                                        ),
                                        const TextSpan(text: ' and '),
                                        TextSpan(
                                          text: 'Privacy Policy',
                                          style: const TextStyle(
                                            color: Colors.redAccent,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              // TODO: Navigate to privacy policy
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Sign Up Button
                            SizedBox(
                              height: 54,
                              child: ElevatedButton(
                                onPressed: (state.status == FormzSubmissionStatus.inProgress || 
                                          !_termsAccepted || 
                                          !state.isValid)
                                    ? null
                                    : _onSignUp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 2,
                                  shadowColor: Colors.redAccent.withOpacity(0.3),
                                ),
                                child: state.status == FormzSubmissionStatus.inProgress
                                    ? const SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        ),
                                      )
                                    : Text(
                                        'Create Account',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // Already have an account? Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account? ',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(context, '/login');
                                  },
                                  child: Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      color: Colors.redAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

