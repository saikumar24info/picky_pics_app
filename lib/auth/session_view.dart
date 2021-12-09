// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_day/auth/home_page.dart';

import 'package:project_one_day/auth/session_cubit.dart';

// ignore: use_key_in_widget_constructors
class SessionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Icon(Icons.person),
            TextButton(
              child: Text('SignOut',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
            ),
          ],
          title: Text(
            "Welcome :",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 30,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Image.network(
                    "https://media.istockphoto.com/photos/mountain-landscape-picture-id517188688?k=20&m=517188688&s=612x612&w=0&h=i38qBm2P-6V4vZVEaMy_TaTEaoCMkYhvLCysE7yJQ5Q="),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                child: Image.network(
                    "https://images.unsplash.com/photo-1610878180933-123728745d22?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y2FuYWRhJTIwbmF0dXJlfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
              ),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__480.jpg")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://expertphotography.b-cdn.net/wp-content/uploads/2018/07/nature-photography.jpg")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://static.scientificamerican.com/sciam/cache/file/4E0744CD-793A-4EF8-B550B54F7F2C4406_source.jpg")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f9cca07d4c42920d4d348c7%2Frainforest%2F960x0.jpg%3Ffit%3Dscale")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://img.theculturetrip.com/wp-content/uploads/2017/09/khajjiar.jpg")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://m.media-amazon.com/images/I/71lmT5SQMvL.jpg")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://images.pexels.com/photos/1766838/pexels-photo-1766838.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://toib.b-cdn.net/wp-content/uploads/2017/04/munnar.jpg")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://i1.adis.ws/i/canon/canon-get-inspired-urban-nature-photography-tips-5-1920x1080?w=100%&sm=aspect&aspect=16:9&qlt=80&fmt=jpg&fmt.options=interlaced&bg=rgb(255,255,255)")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://s01.sgp1.cdn.digitaloceanspaces.com/article/148615-eoqalnvfou-1601822469.jpg")),
              const Padding(padding: EdgeInsets.all(20)),
              Card(
                  child: Image.network(
                      "https://freerangestock.com/sample/86378/rocky-point-beach-in-sonora-mexico.jpg")),
              const Padding(padding: EdgeInsets.all(5)),
              TextButton(
                child: Text('sign out'),
                onPressed: () =>
                    BlocProvider.of<SessionCubit>(context).signOut(),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
