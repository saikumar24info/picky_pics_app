// import 'package:flutter/material.dart';

// class homepage extends StatefulWidget {
//   const homepage({Key? key}) : super(key: key);

//   @override
//   _homepageState createState() => _homepageState();
// }

// class _homepageState extends State<homepage> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'scroll images',
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             'Favorite Images',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//           elevation: 50,
//         ),
//         body:
//  Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
          
//             TextButton(
//               child: Text('sign out'),
//               onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
