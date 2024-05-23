// import 'package:flutter/material.dart';
// import 'package:propertymaster/utilities/AppColors.dart';
// import 'package:propertymaster/utilities/AppStrings.dart';
//
// class ResaleDeal extends StatefulWidget {
//   const ResaleDeal({super.key});
//
//   @override
//   State<ResaleDeal> createState() => _ResaleDealState();
// }
//
// class _ResaleDealState extends State<ResaleDeal> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: AppColors.colorSecondaryLight,
//             iconTheme: const IconThemeData(color: AppColors.white,),
//             title: const Text(
//               AppStrings.resaleDeal,
//               style: TextStyle(color: AppColors.white,),
//             ),
//             bottom: const TabBar(
//               tabs: [
//                 Tab(icon: Icon(Icons.directions_car),text: "All Property1"),
//                 Tab(icon: Icon(Icons.directions_transit),),
//                 Tab(icon: Icon(Icons.directions_bike),),
//                 Tab(icon: Icon(Icons.directions_bike),),
//               ],
//             ),
//           ),
//           body: const TabBarView(
//             children: [
//               Icon(Icons.directions_car),
//               Icon(Icons.directions_transit),
//               Icon(Icons.directions_bike),
//               Icon(Icons.directions_bike),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
