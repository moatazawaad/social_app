import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ), (route) {
      return false;
    });

Widget loginButton({
  double width = double.infinity,
  Color background = Colors.red,
  bool isUpperCase = true,
  double height = 40.0,
  double radius = 10.0,
  //it was Function but not worked until changed to VoidCallBack
  VoidCallback? function,
  required String text,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: background,
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  FormFieldValidator<String>? onSubmit,
  FormFieldValidator<String>? onChange,
  bool isPassword = false,
  VoidCallback? onTab,
  final String? value,
  final FormFieldValidator<String>? validate,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  VoidCallback? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      //  keyboardAppearance: Brightness.dark,
      controller: controller,
      obscureText: isPassword,
      onTap: onTab,
      keyboardType: type,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      // onChanged: (String? value) {
      //   onChange;
      // },
      onChanged: onChange,
      validator: validate,
      decoration: InputDecoration(
        // hintText: 'Email',
        labelText: label,
        // hintStyle: TextStyle(
        //   color: Colors.red,
        // ),
        prefixIcon: Icon(
          prefixIcon,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffixIcon))
            : null,
        border: const OutlineInputBorder(),
      ),
    );

Widget defaultTextButton({
  required VoidCallback function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
      child: Container(
        width: double.infinity,
        height: 2.0,
        color: Colors.grey[300],
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        // navigateTo(context, WebViewScreen(url: (article['url'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );

void showToast({
  required String? text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 10,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates {
  success,
  error,
  warning,
}

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;

    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}

void printFullText(String? text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text!).forEach((match) => print(match.group(0)));
}

Widget buildLoading() => const CircularProgressIndicator();

Widget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.keyboard_backspace_outlined,
        ),
      ),
      title: Text(
        title!,
      ),
      actions: actions!,
    );
