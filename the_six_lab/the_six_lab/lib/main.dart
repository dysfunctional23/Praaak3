import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_six_lab/user/user.dart';

import 'auth/auth_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static List<User> users = [
    User('name', 'password'),
  ];

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  TextEditingController newLoginController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is NeedRegistrate) {
            return Scaffold(
              backgroundColor: const Color(0xFF211F1F),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Это обязательное поле';
                            }
                            if (value.length < 3) {
                              return "Логин должен быть не короче 3 символов";
                            }
                            if (value.contains(" ")) {
                              return 'Логин не может содержать пробелов';
                            }
                            return null;
                          },
                          controller: newLoginController,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Login',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: const Color(0xFFF4F4F4),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                                color: Color(0xFFF4F4F4),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                                color: Color(0xFFF4F4F4),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Это обязательное поле';
                            }
                            if (value.length < 3) {
                              return 'Пароль должен быть не короче 3 символов';
                            }
                            if (value.contains(" ")) {
                              return 'Пароль не может содержать пробелов';
                            }
                            return null;
                          },
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            fillColor: const Color(0xFFF4F4F4),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                                color: Color(0xFFF4F4F4),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                                color: Color(0xFFF4F4F4),
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          controller: newPasswordController,
                        ),
                      ]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xFFF5DF4D)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (MyApp.users
                              .where((element) =>
                                  element.name == newLoginController.text)
                              .isEmpty) {
                            MyApp.users.add(User(newLoginController.text,
                                newPasswordController.text));
                            BlocProvider.of<AuthCubit>(context)
                                .onAuthUser('', '');
                            newLoginController.clear();
                            newPasswordController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Пользователь с таким логином уже существует")));
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Зарегистрироваться',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xFFF5DF4D)),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).onAuthUser('', '');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Выйти',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is AuthLoaded) {
            return Scaffold(
              backgroundColor: const Color(0xFF211F1F),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hello, ',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          loginController.text,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xFFF5DF4D)),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).onAuthUser('', '');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Выйти',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state is AuthAdmin) {
            return Scaffold(
              backgroundColor: const Color(0xFF211F1F),
              body: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Hello, ',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        Text(
                          loginController.text,
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xFFF5DF4D)),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).onAuthUser('', '');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Выйти',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: const Color(0xFFF5DF4D)),
                      onPressed: () {
                        MyApp.users.clear();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Удалить всех пользователей',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Scaffold(
            backgroundColor: const Color(0xFF211F1F),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Это обязательное поле';
                          }
                          if (value.length < 3) {
                            return "Логин должен быть не короче 3 символов";
                          }
                          if (value.contains(" ")) {
                            return 'Логин не может содержать пробелов';
                          }
                          return null;
                        },
                        controller: loginController,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Login',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: const Color(0xFFF4F4F4),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3,
                              color: Color(0xFFF4F4F4),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3,
                              color: Color(0xFFF4F4F4),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Это обязательное поле';
                          }
                          if (value.length < 3) {
                            return 'Пароль должен быть не короче 3 символов';
                          }
                          if (value.contains(" ")) {
                            return 'Пароль не может содержать пробелов';
                          }
                          return null;
                        },
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          fillColor: const Color(0xFFF4F4F4),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3,
                              color: Color(0xFFF4F4F4),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3,
                              color: Color(0xFFF4F4F4),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        controller: passwordController,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: const Color(0xFFF5DF4D)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (loginController.text == 'admin' &&
                            passwordController.text == 'admin') {
                          BlocProvider.of<AuthCubit>(context).onAuthUser(
                              loginController.text, passwordController.text);
                        } else {
                          if (MyApp.users
                              .where((element) =>
                                  element.name == loginController.text)
                              .isNotEmpty) {
                            var result = MyApp.users.firstWhere((element) =>
                                element.name == loginController.text);
                            String pasw = result.password;
                            if (passwordController.text == pasw) {
                              BlocProvider.of<AuthCubit>(context).onAuthUser(
                                  loginController.text,
                                  passwordController.text);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Не верный пароль")));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Пользователь не найден")));
                          }
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Войти',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: const Color(0xFFF5DF4D)),
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).onAuthUser(' ', ' ');
                      loginController.clear();
                      passwordController.clear();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Зарегистрироваться',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }
}
