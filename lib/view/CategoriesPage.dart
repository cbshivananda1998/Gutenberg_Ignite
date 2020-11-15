import 'package:flutter/material.dart';
import 'package:ignite_practice/view/CategoriesCard.dart';
import 'package:get/get.dart';
import 'package:ignite_practice/model/Constants.dart';
import 'package:ignite_practice/view/BooksPage.dart';


class CategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
          child: Column(

            children: [
              Text(
                "Glutenberg Project",
                style: TextStyle(
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 48.0,
                  color: kDarkPurple
                ),
              ),
              SizedBox(height: 10.0,),
              Text(
                "A social cataloging website that allows you to freely search its database of books,annotations, and reviews",
                style: TextStyle(
                  fontFamily: 'Montserrat-SemiBold',
                  fontSize: 30.0,
                ),
              ),SizedBox(height: 10.0,),
              CategoriesCard(
                image: "assets/Fiction.svg",
                categoryname: "FICTION",
                function: (){Get.to(BooksPage(category: "Fiction",));},

              ),
              SizedBox(
                height: 20.0,
              ),
              CategoriesCard(
                image: "assets/Drama.svg",
                categoryname: "DRAMA",
                function: (){Get.to(BooksPage(category: "Drama",));},
              ),
              SizedBox(
                height: 20.0,
              ),
              CategoriesCard(
                image: "assets/Humour.svg",
                categoryname: "HUMOR",
                function: (){Get.to(BooksPage(category: "Humor",));},
              ),
              SizedBox(
                height: 20.0,
              ),
              CategoriesCard(
                image: "assets/Politics.svg",
                categoryname: "POLITICS",
                function: (){Get.to(BooksPage(category: "Politics",));},
              ),
              SizedBox(
                height: 20.0,
              ),
              CategoriesCard(
                image: "assets/Philosophy.svg",
                categoryname: "PHILOSOPHY",
                function: (){Get.to(BooksPage(category: "Philosophy",));},
              ),
              SizedBox(
                height: 20.0,
              ),
              CategoriesCard(
                image: "assets/History.svg",
                categoryname: "HISTORY",
                function: (){Get.to(BooksPage(category: "History",));},
              ),
              SizedBox(
                height: 20.0,
              ),
              CategoriesCard(
                image: "assets/Adventure.svg",
                categoryname: "ADVENTURE",
                function: (){Get.to(BooksPage(category: "Adventure",));},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
