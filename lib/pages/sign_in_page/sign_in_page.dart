import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          SignInLogo(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          SignInTextFields(context),
          GrayLine(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          SignInButton(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ForgetButton()
        ],
      ),
    ));
  }

  Container GrayLine() {
    return Container(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
        child: const Divider(
          color: Colors.grey,
          thickness: 1,
          height: 0,
        ),
      ),
    );
  }

  Container ForgetButton() {
    return Container(
      child: TextButton(
          onPressed: () => {},
          child: const Text(
            'Забыли логин или пароль?',
            style: TextStyle(
                fontSize: 13,
                color: Color.fromARGB(255, 35, 33, 33),
                fontWeight: FontWeight.w300),
          )),
    );
  }

  Row SignInLogo() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Авторизация',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 35, 33, 33)))
      ],
    );
  }

  Container SignInButton() => Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(350, 55),
            backgroundColor: const Color.fromARGB(255, 35, 33, 33),
          ),
          child: const Text('Войти',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white))));

  Container SignInTextFields(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Логин',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 35, 33, 33)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(''),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
            child: TextFormField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 35, 33, 33), width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromARGB(255, 35, 33, 33), width: 1),
                      borderRadius: BorderRadius.circular(11)),
                  hintText: 'Введите логин',
                  prefixIcon: const Icon(Icons.phone),
                  hintStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey)),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Пароль',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 35, 33, 33)),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(''),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
              child: TextFormField(
                textAlign: TextAlign.left,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    alignLabelWithHint: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 35, 33, 33), width: 1),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 35, 33, 33), width: 1),
                        borderRadius: BorderRadius.circular(11)),
                    hintText: 'Введите пароль',
                    prefixIcon: const Icon(Icons.key),
                    hintStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              )),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.04,
          ),
        ],
      ),
    );
  }
}
