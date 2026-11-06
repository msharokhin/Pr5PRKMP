part of 'video_cards_bloc.dart';

@immutable
sealed class VideoCardsEvent {
  const VideoCardsEvent();
}

// Событие инициализации и загрузки каталога видеокарт
class LoadVideoCardsEvent extends VideoCardsEvent {
  const LoadVideoCardsEvent();
}
