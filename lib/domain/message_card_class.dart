import 'package:flutter/material.dart';

class MessageCardClass {
  String image;
  String nome;
  String tempoMensagem;
  String mensagem;
  Icon icon;
  int views;

  MessageCardClass({
    required this.image,
    required this.nome,
    required this.tempoMensagem,
    required this.mensagem,
    required this.icon,
    required this.views,
  });
}