part of 'video_cards_bloc.dart';

@immutable
sealed class VideoCardsState {
  const VideoCardsState();
}

// 1. Initial — состояние покоя до старта загрузки
class VideoCardsInitial extends VideoCardsState {
  const VideoCardsInitial();
}

// 2. Loading — состояние ожидания (индикатор ProgressBar)
class VideoCardsLoading extends VideoCardsState {
  const VideoCardsLoading();
}

// 3. Loaded — состояние успешной загрузки данных коллекции
class VideoCardsLoaded extends VideoCardsState {
  final List<VideoCard> cards;
  const VideoCardsLoaded(this.cards);
}

// 4. Error — состояние критического сбоя
class VideoCardsError extends VideoCardsState {
  final String message;
  const VideoCardsError(this.message);
}
