import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:todoapp/layout/news_layout/cubit/cubit.dart';
import 'package:todoapp/modules/web_view/web_view.dart';
import 'package:todoapp/shared/cubit/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.pink,
  bool isUpperCase = true,
  double radius = 0,
  required function,
  required String text,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultTextField({
  dynamic context,
  TextInputType type = TextInputType.text,
  IconData? prefixIcon,
  required String text,
  required TextEditingController controller,
  required FormFieldValidator<String>? validator,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  bool isOutLineBorder = true,
  bool isPassword = false,
  IconData? suffix,
  int? maxLength,
  VoidCallback? suffixFunction,
  int radius = 0,
  GestureTapCallback? onTap,
}) =>
    TextFormField(
      controller: controller,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      keyboardType: type,
      obscureText: isPassword,
      validator: validator,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: text,
        border: isOutLineBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(radius.roundToDouble()))
            : null,
        prefixIcon: Icon(prefixIcon),
        suffix: suffix != null
            ? IconButton(
                onPressed: suffixFunction,
                icon: Icon(suffix),
              )
            : null,
      ),
      onTap: onTap,
      style: TextStyle(
        color: NewsCubit.get(context).isDark ? Colors.white : Colors.black,
      ),
    );

Widget dataItem(Map model, context) => Dismissible(
      key: Key(model['id'].toString()),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            start: 0, bottom: 20, end: 20, top: 20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              child: Text(
                '${model['time']}',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${model['date']}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'done', id: model['id']);
              },
              icon: const Icon(
                Icons.check_box_outlined,
                color: Colors.green,
              ),
            ),
            IconButton(
              onPressed: () {
                AppCubit.get(context)
                    .updateData(status: 'archived', id: model['id']);
              },
              icon: const Icon(
                Icons.archive_outlined,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );

Widget fellowColumn() => SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.menu_outlined,
            size: 100,
            color: Colors.black38,
          ),
          Text(
            'No tasks yet, Please add some tasks',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );

Widget newsArticleBuilder(article, context) => InkWell(
      onTap: () {
        navigateTo(context, Web(article['url']));
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsetsDirectional.all(12),
        child: PhysicalModel(
          color: NewsCubit.get(context).isDark? Colors.black26 : HexColor('#FFFFFF'),
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          shadowColor: HexColor('#888888'),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    color: NewsCubit.get(context).isDark
                        ? Colors.black38
                        : Colors.white70,
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage('${article['urlToImage']}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: HexColor('C20002'), borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    article['source']['name'],
                    style: const TextStyle(color: Colors.black),
                    textAlign:TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );

Widget divider() => Container(
      height: 1,
      color: Colors.grey,
    );

Widget articleItem(list, context, {bool isSearch = false}) =>
    ConditionalBuilder(
      condition: list.isNotEmpty,
      builder: (context) => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) =>
            newsArticleBuilder(list[index], context),
        itemCount: list.length,
      ),
      fallback: isSearch
          ? (context) => Container()
          : (context) => const Center(child: CircularProgressIndicator()),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );
