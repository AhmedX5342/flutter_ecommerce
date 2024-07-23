import 'package:ecommerce/logic/auth_cubit.dart';
import 'package:ecommerce/logic/auth_states.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/text_field_widget.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>AuthCubit(),
      child: Scaffold(
        body: Container(
          child: Center(
            child: BlocBuilder<AuthCubit,AuthStates>(
              builder: (context,state){
                var cubit = AuthCubit.get(context); // -----------
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Log In',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextFieldWidget(label: 'Email', isPassword: false, controller: cubit.emailController),
                    SizedBox(height: 10.0),
                    TextFieldWidget(label: 'Password', isPassword: true, controller: cubit.passwordController),
                    SizedBox(height: 20.0),
                    (state is AuthLoading)? const Center(child: CircularProgressIndicator()):
                      ElevatedButton(
                        onPressed: () {
                          cubit.Login(context);
                        },
                        child: Text('Log In'),
                      ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
                      },
                      child: Text('Sign up instead'),
                    ),
                    SizedBox(height: 20.0),
                    if(state is AuthSuccess)
                      const Text('Logged in successfully'),
                    if(state is AuthError)
                      const Text('Incorrect email or password')
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
