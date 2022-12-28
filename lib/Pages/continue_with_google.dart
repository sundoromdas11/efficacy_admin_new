import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:efficacy_admin/services/user_authentication.dart';
import 'package:efficacy_admin/themes/appcolor.dart';
import 'package:efficacy_admin/utils/loading_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Googlelogin extends StatefulWidget {
  static const id = '/googleLogIn';
  const Googlelogin({Key? key}) : super(key: key);

  @override
  _GoogleloginState createState() => _GoogleloginState();
}

class _GoogleloginState extends State<Googlelogin> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        left: 0, top: 96, right: 0, bottom: 0),
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC4C4C4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(
                    height: 41,
                  ),
                  Text(
                    "Hey! Welcome",
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suscipit sed augue quam amet, sed gravida.",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 63,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(48, 0, 48, 0),
                    child: SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).primaryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FaIcon(FontAwesomeIcons.google,
                                size: 16, color: AppColorLight.onPrimary),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Continue with Google",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2!
                                  .copyWith(color: AppColorLight.onPrimary),
                            )
                          ],
                        ),
                        onPressed: () async {
                          setState(() => isLoading = !isLoading);
                          var status = await Provider.of<GoogleSignInProvider>(
                                  context,
                                  listen: false)
                              .signInWithGoogle();
                          if (status == "Google Credential Acquired") {
                            setState(() => isLoading = !isLoading);
                          }
                          if (status == "Google Sign Failed") {
                            setState(() => isLoading = !isLoading);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Color(0xffE78787),
                                content: Text(
                                  'Some error occured',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
