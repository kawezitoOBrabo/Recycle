import "package:myapp/domain/domain_video_player.dart";
import "package:myapp/db/message_domain_video_player.dart";

class Database {
  static List domainVideoPlayer = [
    DomainVideoPlayer(
      url:
          "https://videos.pexels.com/video-files/28699246/12454963_1440_2560_50fps.mp4",
      image:
          "https://images.pexels.com/users/avatars/522575817/iddea-photo-898.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "LeitoraAvida",
      descricao: "Mulher lendo livro no campo durante o pôr do sol.",
      nomeMusica: "Sem música",
      messageCard: MessageCard.messageCard,
    ),
    DomainVideoPlayer(
      url:
          "https://videos.pexels.com/video-files/10677320/10677320-uhd_1440_2732_25fps.mp4",
      image:
          "https://images.pexels.com/users/avatars/1302114817/a-b-s-498.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "GatiinhosFofos",
      descricao: "Gato britânico de pelo curto relaxando dentro de casa.",
      nomeMusica: "Sem música",
      messageCard: MessageCard.messageCard,
    ),
    DomainVideoPlayer(
      url:
          "https://videos.pexels.com/video-files/28663010/12445553_1080_1920_60fps.mp4",
      image:
          "https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "ModaTendencias",
      descricao: "Moda e tendência com um terno/traje.",
      nomeMusica: "Sem música",
      messageCard: MessageCard.messageCard,
    ),
    DomainVideoPlayer(
      url:
          "https://videos.pexels.com/video-files/4920770/4920770-uhd_1440_2732_25fps.mp4",
      image:
          "https://images.pexels.com/users/avatars/1437723/cottonbro-studio-531.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "Exercicios",
      descricao:
          "Atividade física, ação e movimento, em um contexto de aventura.",
      nomeMusica: "Sem música",
      messageCard: MessageCard.messageCard,
    ),
    DomainVideoPlayer(
      url:
          "https://videos.pexels.com/video-files/6395999/6395999-hd_1080_1920_25fps.mp4",
      image:
          "https://images.pexels.com/users/avatars/2297095/pavel-danilyuk-690.jpeg?auto=compress&fit=crop&h=40&w=40&dpr=1",
      nome: "FestasEEventos",
      descricao: "Bebidas alcoólicas e celebração com taças de champagne.",
      nomeMusica: "Sem música",
      messageCard: MessageCard.messageCard,
    ),
  ];
}
