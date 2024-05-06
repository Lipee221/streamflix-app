import 'package:flutter/material.dart';

class NewMoviesWiget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Filmes recentes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
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
              for (int i = 1; i < 11; i++)
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: 190,
                      height: 300,
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF292B37),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF292B37).withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              "images/1.png",
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mamonas Assasinas",
                                    style: TextStyle(
                                      color: Color(0xFF00A470),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    "Comedia/Humor",
                                    style: TextStyle(
                                      color: Colors.white54,
                                    ),
                                  ),
                                  SizedBox(height: 3),
                                  Row(children: [
                                    Icon(Icons.star, color: Colors.amber),
                                    SizedBox(width: 5),
                                    Text("8,5",
                                        style: TextStyle(
                                          color: Colors.white54,
                                          fontSize: 16,
                                        ))
                                  ]),
                                ],
                              )),
                        ],
                      )),
                )
            ],
          ),
        ),
      ],
    );
  }
}
