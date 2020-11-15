import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class CategoriesCard extends StatelessWidget {
  CategoriesCard({this.image, this.categoryname,this.function});

  final String image;
  final String categoryname;
  final Function function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                height: 30.0,
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                categoryname,
                style:
                TextStyle(fontFamily: 'Montserrat-Regular', fontSize: 20.0),
              ),
              Spacer(
                flex: 12,
              ),
              SvgPicture.asset(
                'assets/Next.svg',
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
