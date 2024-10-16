import 'dart:typed_data';
import 'dart:async';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/domain/domain_video_player.dart';
import 'package:myapp/domain/message_card_class.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import "package:share_plus/share_plus.dart";
import 'package:myapp/db/database.dart';
import 'package:myapp/db/message_domain_video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final DomainVideoPlayer domain_videoPlayer;
  const VideoPlayerScreen({
    super.key,
    required this.domain_videoPlayer,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  DomainVideoPlayer get domainVideoPlayer => widget.domain_videoPlayer;

  late VideoPlayerController _controller;
  final controller = ScreenshotController();
  final TextEditingController _textVideo = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  int selectedItemIndex = 0;

  Color _iconColor = Colors.white;
  Color _seguirColor = Colors.transparent;
  Color _seguirBorderColor = Colors.white;
  Color _seguirTextColor = Colors.white;

  List<bool> _isFavorite = List.filled(
    Database.domainVideoPlayer.length,
    false,
  );
  Color _messageIconColor = Colors.grey;

  bool _isCardVisible = false;
  bool isHovering = false;
  String _myAppLink =
      "https://play.google.com/store/apps/details?id=com.example.myapp";

  //Permissao para acessar o armazenamento
  Future<void> _requestPermission() async {
    await Permission.storage.request();
  }

  //Salva a imagem depois de receber a permissao
  Future<void> saveImage(Uint8List image) async {
    final time = DateTime.now().toIso8601String().replaceAll(".", "-");
    final result =
        await ImageGallerySaver.saveImage(image, name: "screenshoot_$time");
  }

  //Envia a mensagem sobre o vídeo
  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      MessageCardClass novaMensagem = MessageCardClass(
        image:
            "https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
        nome: "KaweSouzaFirmino",
        tempoMensagem: "Atual",
        mensagem: _messageController.text.trim(),
        icon: Icon(
          Icons.favorite_border_outlined,
          color: Colors.grey,
        ),
        views: 0,
      );
      setState(() {
        Database.domainVideoPlayer[selectedItemIndex].messageCard
            .add(novaMensagem);
        _messageController.clear();
      });
    }
  }

  //Share redes sociais
  Future<void> _shareLink() async {
    String mensagem = await "Confira esse link: $_myAppLink";
    Share.share(mensagem, subject: 'Look what I made!');
  }

  //Atera a visibilade do card
  void _messageCardVisibility() {
    setState(() {
      _isCardVisible = !_isCardVisible;
    });
  }

  EmojiParser parser = EmojiParser();
  //Show emojis
  void _showEmojis(String emoji) {
    setState(() {
      _textVideo.text += emoji;
    });
  }

  //Insert emojis

  //Inicializa o controlador do VideoPlayer
  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network("${domainVideoPlayer.url}")
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
    var coffee = parser.get('coffee');
    print(coffee);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      home: Screenshot(
        controller: controller,
        child: Stack(
          children: [
            SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size?.width ?? 0,
                  height: _controller.value.size?.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
            if (!_controller.value.isInitialized)
              Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.greenAccent,
                ),
              ),
            SafeArea(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Reels",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
                                ),
                              ),
                              PopupMenuButton<String>(
                                icon: Icon(
                                  Icons.expand_more_sharp,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                offset: Offset(
                                  0,
                                  50,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem<String>(
                                      value: 'compartilhar',
                                      child: Text('Compartilhar'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'salvar',
                                      child: Text('Salvar'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'reportar',
                                      child: Text('Reportar'),
                                    ),
                                  ];
                                },
                                onSelected: (String value) {
                                  switch (value) {
                                    case 'compartilhar':
                                      print('Compartilhar selecionado');
                                      break;
                                    case 'salvar':
                                      print('Salvar selecionado');
                                      break;
                                    case 'reportar':
                                      print('Reportar selecionado');
                                      break;
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: IconButton(
                            onPressed: () async {
                              final image = await controller.capture();
                              if (image == null) return;
                              await _requestPermission();
                              await saveImage(image);
                            },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundImage:
                                          NetworkImage(domainVideoPlayer.image),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    ("${domainVideoPlayer.nome}").toUpperCase(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 25,
                                    width: 100,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          if (_seguirColor ==
                                              Colors.transparent) {
                                            _seguirColor = Colors.redAccent;
                                            _seguirBorderColor =
                                                Colors.redAccent;
                                          } else {
                                            _seguirColor = Colors.transparent;
                                            _seguirBorderColor = Colors.white;
                                          }
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _seguirColor,
                                        side: BorderSide(
                                          color: _seguirBorderColor,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                      ),
                                      child: Text(
                                        "Seguir",
                                        style: TextStyle(
                                          color: _seguirTextColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 13),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "${domainVideoPlayer.descricao}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 11),
                                ),
                              ),
                              SizedBox(height: 14),
                              SizedBox(
                                height: 25,
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.music_note_rounded,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        domainVideoPlayer.nomeMusica,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(68, 0, 0, 0),
                                    side: BorderSide(color: Colors.transparent),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                          child: Column(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      _iconColor = _iconColor == Colors.white
                                          ? Colors.redAccent
                                          : Colors.white;
                                    },
                                  );
                                },
                                icon: Icon(
                                  _iconColor == Colors.white
                                      ? Icons.favorite_border_outlined
                                      : Icons.favorite,
                                  color: _iconColor,
                                  size: 35,
                                ),
                              ),
                              SizedBox(height: 16),
                              IconButton(
                                onPressed: _messageCardVisibility,
                                icon: Icon(
                                  Icons.comment,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(height: 16),
                              IconButton(
                                onPressed: () async {
                                  await _shareLink();
                                },
                                icon: Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              SizedBox(height: 16),
                              Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 35,
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (_isCardVisible)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _messageCardVisibility,
                  child: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height / 1.5,
                    padding: EdgeInsets.all(16),
                    child: Expanded(
                      child: buildContainerComments(),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  //Desativa o VideoPlayer quando necessário
  buildContainerComments() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 64,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.black45,
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.builder(
            itemCount: Database.domainVideoPlayer.length,
            itemBuilder: (context, index) {
              final message = Database.domainVideoPlayer[index].messageCard;
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: CircleAvatar(
                              radius:
                                  20, // Ajustado para 20 para melhor escala com o tamanho do SizedBox
                              backgroundImage:
                                  NetworkImage(message[index].image),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                message[index].nome,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                message[index].tempoMensagem,
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.black54,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: Text(
                              message[index].mensagem,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Color.fromARGB(180, 0, 0, 0),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          //
                          //Errado
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          //
                          IconButton(
                            onPressed: () {
                              setState(
                                () {
                                  _isFavorite[index] = !_isFavorite[index];
                                },
                              );
                            },
                            icon: Icon(
                              _isFavorite[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border_outlined,
                              color:
                                  _isFavorite[index] ? Colors.red : Colors.grey,
                              size: 35,
                            ),
                          ),
                          Text(
                            "${message[index].views}",
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("Ver mais"),
                  ),
                ],
              );
            },
          ),
        ),
        Column(
          children: [
            Container(
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        labelText: "Digite sua mensagem",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xff27de2d)),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _sendMessage,
                    icon: Icon(
                      Icons.send,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  @override
  void dispose() {
    //Controller video dispose
    _controller.dispose();
    //SystemChrome dispose
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    super.dispose();
  }
}