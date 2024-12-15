import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/sign in/logo_component.dart';
import '../widgets/sign in/rounded_container.dart';
import '../widgets/sign in/title_box.dart';
import '../widgets/sign in/sign_in_buttons.dart';
import '../widgets/sign in/register_prompt.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Colors.white),
          const LogoWidget(), // No need to pass dimensions
          const RoundedContainer(),
          const TitleBox(),
          const SignInButtons(),
          const RegisterPrompt(),
        ],
      ),
    );
  }
}