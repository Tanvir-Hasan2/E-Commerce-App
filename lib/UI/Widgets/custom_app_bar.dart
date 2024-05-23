// import 'package:flutter/material.dart';
//
// class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
//   final String title;
//   final bool automaticallyImplyLeading;
//
//   const CustomAppBar({
//      required this.title,
//     required this.automaticallyImplyLeading,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: Colors.blue,
//       shape: const ContinuousRectangleBorder(
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(60),
//           bottomRight: Radius.circular(60),
//         ),
//       ),
//       title: Text(title, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
//     centerTitle: true,
//     elevation: 0,
//     automaticallyImplyLeading: automaticallyImplyLeading, // remove back button
//     );
//   }
//
//   @override
//   Size get preferredSize => Size.fromHeight(kToolbarHeight);
// }

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  final bool automaticallyImplyLeading;
  final Widget? drawer;
  final Widget? endDrawer;
  final IconData? iconData;
  final VoidCallback? onIconTap;
  final Color? backgroundColor;
  final Color? titleTextColor;
  final Color? iconColor;
  final bool centerTitle;

  const CustomAppBar({
    required this.title,
    required this.automaticallyImplyLeading,
    this.drawer,
    this.endDrawer,
    this.iconData,
    this.onIconTap,
    this.backgroundColor,
    this.titleTextColor,
    this.iconColor,
    required this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: backgroundColor ?? Colors.blue,
      backgroundColor: backgroundColor ?? Colors.white,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
          bottomRight: Radius.circular(60),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          //color: titleTextColor ?? Colors.white,
          color: titleTextColor ?? Colors.black87,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: centerTitle,
      elevation: 0,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: drawer != null ? Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            color: iconColor,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ) : null,
      actions: <Widget>[
        if (endDrawer != null)
          Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.more_vert),
                color: iconColor,
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        if (iconData != null && onIconTap != null)
          IconButton(
            icon: Icon(iconData),
            color: iconColor,
            onPressed: onIconTap,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
