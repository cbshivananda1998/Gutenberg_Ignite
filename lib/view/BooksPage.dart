import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ignite_practice/controller/Services.dart';

import 'package:ignite_practice/model/Constants.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:ignite_practice/model/sizeConfig.dart';

class BooksPage extends StatefulWidget {
  BooksPage({this.category});

  final String category;

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  final userController = Get.put(Service());
  ScrollController _scrollController = new ScrollController();
  Timer timer;

  String encodedSearchInput = "";
  var _controller = TextEditingController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        userController.getValidBooks(widget.category, encodedSearchInput);
      }
    });

    userController.getValidBooks(widget.category, encodedSearchInput);

    super.initState();
  }

  void encode(searchInput) {
    List<String> value = searchInput.split(",");
    for (int i = 0; i < value.length; i++) {
      if (i == value.length - 1) {
        encodedSearchInput += value[i];
      } else {
        encodedSearchInput += value[i];
        encodedSearchInput += "%20";
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    userController.dispose();
    super.dispose();
  }

  _launchURL(String viewUrl) async {
    if (await canLaunch(viewUrl)) {
      await launch(viewUrl);
    } else {
      throw 'Could not launch $viewUrl';
    }
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No viewable version available',
              style: TextStyle(
              color: kDarkPurple,
              fontFamily: 'Montserrat-SemiBold',
              fontSize: 25.0),),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please select another book.',
        style: TextStyle(
        fontFamily: 'Montserrat-Regular',
        fontSize: 15.0),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL',style: TextStyle(

          fontFamily: 'Montserrat-Regular',
                color: kDarkPurple,),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SvgPicture.asset('assets/Back.svg')),
                  Spacer(
                    flex: 1,
                  ),
                  Text(
                    widget.category,
                    style: TextStyle(
                        color: kDarkPurple,
                        fontFamily: 'Montserrat-SemiBold',
                        fontSize: 30.0),
                  ),
                  Spacer(
                    flex: 20,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: Container(
                height: 40.0,
                decoration: BoxDecoration(
                  color: kLightPurle,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    encode(value);

                    userController.searched.value = true;
                    userController.getValidBooks(widget.category, encodedSearchInput);
                  },
                  decoration: InputDecoration(
                      hintText: 'Search',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: kDarkPurple)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                      prefixIcon: Icon(Icons.search),
                      suffixIcon: IconButton(
                          onPressed: () => _controller.clear(),
                          icon: Icon(Icons.close))),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                color: kLightPurle,
                height: Get.height,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => userController.loading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          )
                        :userController.size.value==0?
                    Center(
                      child:Text(
                        'No books available',
                        style: TextStyle(
                            color: kDarkPurple,
                            fontFamily: 'Montserrat-SemiBold',
                            fontSize: 30.0),
                      ),
                    ):
                    GridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 9 / 16,
                            ),
                            itemCount: userController.size.value == 0
                                ? 0
                                : userController.validBooks.value.books.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: InkWell(
                                  onTap: () async {
                                    String viewUrl =userController.getViewUrl(index);

                                    if (await canLaunch(viewUrl)) {
                                      await launch(viewUrl);
                                    } else {
                                      _showMyDialog();
                                    };

                                  },
                                  child: GridTile(
                                    child: Container(
                                      padding: EdgeInsets.all(1.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Container(
                                              height:
                                                  SizeConfig.safeBlockVertical *
                                                      22,
                                              width: SizeConfig
                                                      .safeBlockHorizontal *
                                                  50,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey,
                                                    offset: Offset(
                                                        0.0, 1.0), //(x,y)
                                                    blurRadius: 6.0,
                                                  ),
                                                ],
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                  '${userController.validBooks.value.books[index].formats.imageJpeg}',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                5.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                                '${userController.validBooks.value.books[index].title}',
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Montserrat-SemiBold'),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0.0, 0.0, 0.0, 0.0),
                                            child: Text(
                                                "${userController.validBooks.value.books[index].newAuthor}",
                                                style: TextStyle(
                                                    fontFamily:
                                                        'Montserrat-SemiBold',
                                                    color: kMediumGrey),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
