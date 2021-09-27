import 'package:flutter/material.dart';
import 'package:spacex/models/models.dart';
import 'package:spacex/pages/description_page.dart';
import 'package:spacex/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:spacex/provider/graphql_call.dart';

void main()
{
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> GraphqlCall()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => MyApp(),
        '/description' : (context) => Description(model : ModalRoute.of(context).settings.arguments)
      },
    ),
  ));
}

