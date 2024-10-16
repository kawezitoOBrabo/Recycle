import 'package:flutter/material.dart';
import 'package:myapp/domain/message_card_class.dart';

class DomainVideoPlayer {
  String url; //Video
  String image; //Imagem da pessoa
  String nome; //Nome da conta
  String descricao; //Descricao do video
  String nomeMusica; //Nome da musica adicionada
  List<MessageCardClass> messageCard; //Lista do card dinâmico de mensagens

  DomainVideoPlayer({
    required this.url,
    required this.image,
    required this.nome,
    required this.descricao,
    required this.nomeMusica,
    required this.messageCard,
  });
}