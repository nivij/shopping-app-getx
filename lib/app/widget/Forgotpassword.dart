import 'package:flutter/material.dart';

import 'Forgetcontainer.dart';

class ForgotPassword{
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)),
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Make Selection!",
            style: Theme.of(context)
                .textTheme
                .headline2
                ?.copyWith(fontSize: 30),
          ),
          Text(
            "Select one of the options given below to reset your password",
            style:
            Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: 30,
          ),
          forgotscontainer(
              onTap: () {

              },
              title: "E-mail",
              subtitle:
              "Reset via E-mail Verification",
              Iconn: Icons.email_outlined),
          SizedBox(
            height: 20,
          ),
          forgotscontainer(
            onTap: () {

            },
            title: "Phone no",
            subtitle:
            "Reset via Phone no Verfication",
            Iconn: Icons.phone_android_outlined,
          ),
        ],
      ),
    ),
  );
}
}