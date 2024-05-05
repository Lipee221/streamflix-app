import 'package:flutter/material.dart';

class UpcomingWidget extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Próximas estreias",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  
                ),
              ),
                            
            ],
          ),
        ),
      SizedBox(height: 15),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
          for(int i=1; i < 5; i++)
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
              "images/2.png",
              
              height: 180,
              width: 300,
              fit: BoxFit.cover,
              )        
            ),
            )
        ],)
      )

      ],
    );
  }

}