import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_theme.dart';
import 'package:todo_app/auth/login_screen.dart';
import 'package:todo_app/auth/user_provider.dart';
import 'package:todo_app/firebase_functions.dart';
import 'package:todo_app/home_screen.dart';
import 'package:todo_app/tabs/settings/settings_provider.dart';
import 'package:todo_app/tabs/tasks/defaultTextFormField.dart';
import 'package:todo_app/tabs/tasks/default_elevated_bottom.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class RegisterScreen extends StatefulWidget {
  static const routeName = "/register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailControl = TextEditingController();
  TextEditingController passwordControl = TextEditingController();
  TextEditingController nameControl = TextEditingController();
  TextEditingController userNameControl = TextEditingController();
  TextEditingController confirmPassControl = TextEditingController();
  
  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider=Provider.of<SettingsProvider>(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color:settingsProvider.isDark?AppTheme.backgroundDark:AppTheme.backgroundLight,
          image: DecorationImage(image:AssetImage("assets/images/background.png"),
          fit: BoxFit.fill)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(
                AppLocalizations.of(context)!.register,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color:AppTheme.white,fontSize: 30),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 140,),
                        DefaultTextFormField(
                          controller: nameControl,
                          type: TextInputType.name,
                          label: AppLocalizations.of(context)!.fullName,
                          validator: (value) {
                            if (value == null || value.trim().length < 3) {
                              return AppLocalizations.of(context)!.validateFullName;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        DefaultTextFormField(
                          controller: userNameControl,
                          type: TextInputType.name,
                          label:AppLocalizations.of(context)!.userName,
                          validator: (value) {
                            if (value == null || value.trim().length < 3) {
                              return AppLocalizations.of(context)!.validateUserName;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        DefaultTextFormField(
                          controller: emailControl,
                          type: TextInputType.emailAddress,
                          label:AppLocalizations.of(context)!.email,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return AppLocalizations.of(context)!.validateEmail;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8,),
                        DefaultTextFormField(
                          controller: passwordControl,
                          label:AppLocalizations.of(context)!.password,
                          validator: (value) {
                            if (value == null || value.trim().length < 8) {
                              return AppLocalizations.of(context)!.validatePassword;
                            }
                            return null;
                          },
                          isPassword: true,
                        ),
                        SizedBox(height: 8,),
                        DefaultTextFormField(
                          controller: confirmPassControl,
                          label:AppLocalizations.of(context)!.confirmPass,
                          action: TextInputAction.done,
                          validator: (value) {
                            if (value == null || value.trim().length < 8) {
                              return AppLocalizations.of(context)!.validatePassword;
                            }
                            if(value!=passwordControl.text){
                              return AppLocalizations.of(context)!.validateconfirm;
                            }
                            return null;
                          },
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DefaultElevatedBottom(
                            lable: AppLocalizations.of(context)!.register, onPressed: register),
                        SizedBox(
                          height: 12,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                            child: Text(
                              AppLocalizations.of(context)!.haveAccount,
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
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      FirebaseFunctions.register(
          name: nameControl.text,
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
              msg:massage??"Something went wrong",
              textColor: AppTheme.white,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor:AppTheme.red,
              timeInSecForIosWeb: 5
              );
          });
    }
  }
}
