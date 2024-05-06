import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _detailsPage();
  }

  Widget _detailsPage() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 400, // Altura da imagem do filme
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://pbs.twimg.com/media/GEnxkFTWIAABP8T.jpg:large'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 0, 164, 112),
                    borderRadius: BorderRadius.circular(50)),
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Color.fromARGB(255, 0, 164, 112),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 164, 112),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                          ),
                          child: Text(
                            "Assistir",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 164, 112),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                          ),
                          child: Text(
                            "Trailer",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: Text(
              'Duna parte 2',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 164, 112)),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50, vertical: 0),
            child: Text(
              '2024 - 2h 46min',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                _chipTag("Ação"),
                _chipTag("Aventura"),
                _chipTag("Ficção Científica")
              ],
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 50, top: 0, bottom: 100, right: 50),
            child: Text(
              'Em Duna: Parte 2, Paul Atreides (Timothée Chalamet) se une a Chani (Zendaya) e aos Fremen enquanto busca vingança contra os conspiradores que destruíram sua família. Uma jornada espiritual, mística e marcial se inicia. Para se tornar MuadDib, enquanto tenta prevenir o futuro horrível, mas inevitável que ele testemunhou, Paul Atreides vê uma Guerra Santa em seu nome, espalhando-se por todo o universo conhecido. Enfrentando uma escolha entre o amor de sua vida e o destino do universo, Paul deve evitar um futuro terrível que só ele pode prever. Se tudo sair como planejado, ele poderá guiar a humanidade para um futuro promissor.',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Chip _chipTag(String nameTag) {
    return Chip(
      label: Text(nameTag, style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromARGB(255, 43, 43, 56),
    );
  }
}
