import 'dart:convert';
import 'package:flutter/material.dart';
import 'Photo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'http Request Demo'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<Photo>>(
          future: fetchPhoto(),
          builder: (context, snapshot) {
            return snapshot.hasData? PhotoList(photos: snapshot.data,) : Center(child: CircularProgressIndicator());
          }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class PhotoList extends StatelessWidget {
  final List<Photo> photos;

  const PhotoList({Key key, this.photos}) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2
      ),
      itemCount: photos.length,
      itemBuilder: (context,index){
        return Column(
          children:<Widget>[
            Image.network(photos[index].thumbnailUrl),
            Text(photos[index].title)
          ]
        );
      },
    );
  }
}
