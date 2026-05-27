import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final FocusNode nameFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  String fullName = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool isCheckingEmail = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool acceptedTerms = false;

  @override
  void dispose() {
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!value.contains('@') || !value.contains('.')) {
      return 'Enter a valid email';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'Password must contain at least 1 digit';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  String getPasswordStrength() {
    if (password.isEmpty) return '';
    if (password.length < 8) return 'Weak';
    if (RegExp(r'[0-9]').hasMatch(password) && password.length >= 10) {
      return 'Strong';
    }
    return 'Medium';
  }

  Future<void> submitForm() async {
    FocusScope.of(context).unfocus();

    final bool isValid = formKey.currentState!.validate();

    if (!isValid) return;

    if (!acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept Terms & Conditions'),
        ),
      );
      return;
    }

    formKey.currentState!.save();

    setState(() {
      isCheckingEmail = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (email.toLowerCase().startsWith('taken')) {
      setState(() {
        isCheckingEmail = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This email is already taken'),
        ),
      );
      return;
    }

    setState(() {
      isCheckingEmail = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Signup successful. Welcome, $fullName!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strength = getPasswordStrength();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Join the movie app to save your favorite movies.',
                ),

                const SizedBox(height: 24),

                TextFormField(
                  focusNode: nameFocus,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: validateName,
                  onSaved: (value) {
                    fullName = value!.trim();
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(emailFocus);
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  focusNode: emailFocus,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: validateEmail,
                  onSaved: (value) {
                    email = value!.trim();
                  },
                  onChanged: (value) {
                    email = value.trim();
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(passwordFocus);
                  },
                ),

                const SizedBox(height: 16),

                TextFormField(
                  focusNode: passwordFocus,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: obscurePassword,
                  textInputAction: TextInputAction.next,
                  validator: validatePassword,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  onSaved: (value) {
                    password = value!;
                  },
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(confirmPasswordFocus);
                  },
                ),

                if (strength.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text('Password strength: $strength'),
                ],

                const SizedBox(height: 16),

                TextFormField(
                  focusNode: confirmPasswordFocus,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword = !obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: obscureConfirmPassword,
                  textInputAction: TextInputAction.done,
                  validator: validateConfirmPassword,
                  onChanged: (value) {
                    confirmPassword = value;
                  },
                  onSaved: (value) {
                    confirmPassword = value!;
                  },
                  onFieldSubmitted: (_) {
                    submitForm();
                  },
                ),

                const SizedBox(height: 16),

                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('I accept Terms & Conditions'),
                  value: acceptedTerms,
                  onChanged: (value) {
                    setState(() {
                      acceptedTerms = value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: isCheckingEmail ? null : submitForm,
                  child: isCheckingEmail
                      ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Create Account'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}