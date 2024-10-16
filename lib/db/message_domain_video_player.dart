import 'package:flutter/material.dart';
import 'package:myapp/domain/message_card_class.dart';

class MessageCard {
  static List<MessageCardClass> messageCard = [
    MessageCardClass(
      image:
          "https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "CottonBro",
      tempoMensagem: "10 sem",
      mensagem: "Adorei a explicação, muito clara e objetiva.",
      icon: Icon(
        Icons.favorite_border_outlined,
        color: Colors.red,
      ),
      views: 3400,
    ),
    MessageCardClass(
      image:
          "https://images.pexels.com/users/avatars/1302114817/a-b-s-498.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "ABStudio",
      tempoMensagem: "8 sem",
      mensagem: "Seria interessante adicionar legendas.",
      icon: Icon(
        Icons.favorite_border_outlined,
        color: Colors.grey,
      ),
      views: 1800,
    ),
    MessageCardClass(
      image:
          "https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "CottonBro",
      tempoMensagem: "5 sem",
      mensagem: "Estou esperando mais vídeos sobre o tema!",
      icon: Icon(
        Icons.favorite_border_outlined,
        color: Colors.grey,
      ),
      views: 4100,
    ),
    MessageCardClass(
      image:
          "https://images.pexels.com/users/avatars/2297095/pavel-danilyuk-690.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "PavelDan",
      tempoMensagem: "3 sem",
      mensagem: "Você poderia melhorar o volume do áudio.",
      icon: Icon(
        Icons.favorite_border_outlined,
        color: Colors.grey,
      ),
      views: 1500,
    ),
    MessageCardClass(
      image:
          "https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "CottonBro",
      tempoMensagem: "1 sem",
      mensagem: "Vídeo excelente, parabéns pelo conteúdo!",
      icon: Icon(
        Icons.favorite_border_outlined,
        color: Colors.grey,
      ),
      views: 5000,
    ),

    // Adicione mais itens aqui...
  ];
}