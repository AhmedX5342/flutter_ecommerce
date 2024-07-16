import 'package:ecommerce/logic/auth_cubit.dart';
import 'package:ecommerce/logic/auth_states.dart';
import 'package:ecommerce/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Sign Up',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFieldWidget(label: 'Username', isPassword: false, controller: cubit.nameController),
                      SizedBox(height: 20.0),
                      TextFieldWidget(label: 'Phone', isPassword: false, controller: cubit.phoneController),
                      SizedBox(height: 10.0),
                      TextFieldWidget(label: 'Email', isPassword: false, controller: cubit.emailController),
                      SizedBox(height: 10.0),
                      TextFieldWidget(label: 'Password', isPassword: true, controller: cubit.passwordController),
                      SizedBox(height: 20.0),
                      (state is AuthLoading)? const Center(child: CircularProgressIndicator()):
                        ElevatedButton(
                          onPressed: () {
                            cubit.Signup();
                          },
                          child: Text('Sign Up'),
                        ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LogInScreen()),
                          );
                        },
                        child: Text('Log in instead'),
                      ),
                      SizedBox(height: 20.0),
                      if(state is AuthSuccess)
                        const Text('Signed up successfully'),
                      if(state is AuthError)
                        const Text('error')
                    ],
                  ),
                );
              }
              ,
            ),
          ),
        ),
      ),
    );
  }
}