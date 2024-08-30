import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/register_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/defaultTextFormField.dart';
import 'package:todo_app/tabs/tasks/default_elevated_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class LoginScreen extends StatefulWidget {
  static const routeName = "/login";
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailControl = TextEditingController();
    TextEditingController passwordControl = TextEditingController();
    GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    return Container(
      
      decoration: BoxDecoration(
        color:settingsProvider.isDark?AppTheme.backgroundDark:AppTheme.backgroundLight,
        image: DecorationImage(image: AssetImage("assets/images/background.png"),
        fit:BoxFit.fill)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Scaffold(
          backgroundColor:Colors.transparent,
          appBar: AppBar(
            automaticallyImplyLeading :false,
            title: Text(
              AppLocalizations.of(context)!.login,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppTheme.white,fontSize: 30),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultTextFormField(
                        controller: emailControl,
                        label:AppLocalizations.of(context)!.email,
                        validator: (value) {
                            if(value==null||value.trim().length<6){
                              return AppLocalizations.of(context)!.validateEmail;
                            }
                            return null;
                          },
                        
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DefaultTextFormField(
                        controller: passwordControl,
                        action: TextInputAction.done,
                        label:AppLocalizations.of(context)!.password,
                        validator: (value) {
                            if(value==null||value.trim().length<8){
                              return AppLocalizations.of(context)!.validatePassword;
                            }
                            return null;
                          },
                        isPassword: true,
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      DefaultElevatedBottom(lable:AppLocalizations.of(context)!.login, onPressed: login),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
                          },
                          child: Text(
                            AppLocalizations.of(context)!.noAccount,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: AppTheme.primary),
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    
  }
  void login(){
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.login(
          email: emailControl.text,
          password: passwordControl.text
          ).then((user){
          Provider.of<UserProvider>(context,listen: false).updateUser(user);
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }).catchError((error){
            String? massage;
            if(error is FirebaseAuthException){
              massage=error.message;
            }
            Fluttertoast.showToast(
              msg:massage?? "Something went wrong",
              textColor: AppTheme.white,
              timeInSecForIosWeb: 5,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: AppTheme.red,
              fontSize: 16
              );
          });
    }
  }
}
