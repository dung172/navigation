import 'package:flutter/material.dart';
import 'Home.dart';
class Login extends StatelessWidget{
  const Login({Key?key}): super (key:key);
  static final nameRoute ='/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body:
      Center(
        child: LoginForm(),
      ),
    );
  }
}
class LoginForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginForm();
  }
}
class _LoginForm extends State<LoginForm>{
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  bool passwordvisible = true;
  @override
  void dispose() {
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
        child: SizedBox(
          width: 500,
          height: 500,
          child: Column(
            children: <Widget>[
              Text('Login', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800, fontFamily:'arial',color: Colors.red ),),
              TextFormField(
                controller: usernameController,
                validator: (value){
                  if(value == null || value.isEmpty ){
                    return 'Nhập tên đăng nhập';
                  } return null;
                },
                decoration: const InputDecoration(
                  icon: const Icon(Icons.account_circle),
                  labelText: 'Username',
                  hintText: 'admin',
                ),
              ),

              TextFormField(
                controller: passwordController,
                obscureText: passwordvisible,
                validator: (value){
                  if(value == null || value.isEmpty ){
                    return 'Nhập password';
                  } return null;
                },
                decoration:  InputDecoration(
                  icon:  Icon(Icons.vpn_key),
                  hintText: 'admin',
                  labelText: 'Name',
                  suffixIcon: IconButton(onPressed: (){
                   setState(() {
                     passwordvisible=!passwordvisible;
                   });
                  },
                      icon: Icon(passwordvisible?Icons.remove_red_eye_outlined:Icons.visibility_off)),
                ),
              ),

              Padding(padding: EdgeInsets.all(26),
                child: ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                      Navigator.pushNamed(context, Home.nameRoute, arguments: LoginData( usernameController.text, passwordController.text ));

                  }
                }, child: const Text('submit'),
                ),
              )
            ],
          ),
        ),

      ),
    );

  }
}

class  LoginData {
  final String user;
  final String password;
  LoginData(this.user, this.password);
}
