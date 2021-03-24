import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallify/data/data.dart';
import 'package:wallify/models/photos_model.dart';
import 'package:wallify/widget/widget.dart';

class CategorieScreen extends StatefulWidget {
  final String categorie;

  CategorieScreen({@required this.categorie});

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  List<PhotosModel> photos = new List.empty();

  getCategorieWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/search?query=${widget.categorie}&per_page=30&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
      });

      setState(() {});
    });
  }

  @override
  void initState() {
    getCategorieWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D1D),
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: wallPaper(photos, context),
      ),
    );
  }
}
