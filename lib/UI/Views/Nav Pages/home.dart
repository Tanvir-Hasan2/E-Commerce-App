// import 'package:ecommerce/Const/app_colors.dart';
// import 'package:ecommerce/Model/products.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class Home extends StatelessWidget {
//   const Home({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
//       child: Container(
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//               childAspectRatio: 0.8),
//           itemBuilder: (_, index) {
//             return Container(
//               color: AppColors.whiteColor,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   boxShadow: [
//                     BoxShadow(
//                       color: AppColors.grayColor.withOpacity(0.5),
//                       spreadRadius: 2,
//                       blurRadius: 4,
//                       offset: Offset(0, 3),
//                     )
//                   ]),
//               child: Column(
//                 children: [
//
//                 ],
//               ),
//             );
//
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:e_commerce/Const/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
   const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.grayColor.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 3)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Image.network(
                  //   products[index].image.toString(),
                  //   height: 100,
                  // ),
                  // Text(
                  //   products[index].name.toString(),
                  //   textAlign: TextAlign.center,
                  //   style: TextStyle(fontSize: 13.sp),
                  // ),
                  //Text('\n$${products[index].price.toString()}',style: TextStyle( fontWeight: FontWeight.w600,),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
