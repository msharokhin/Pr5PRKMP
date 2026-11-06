import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../models/video_card.dart';
import '../../mock/video_cards_data.dart';

part 'video_cards_event.dart';
part 'video_cards_state.dart';

class VideoCardsBloc extends Bloc<VideoCardsEvent, VideoCardsState> {
  // Задаем базовое стартовое состояние Initial
  VideoCardsBloc() : super(const VideoCardsInitial()) {
    // Регистрируем обработчик события загрузки каталога
    on<LoadVideoCardsEvent>(_onLoadVideoCards);
  }

  Future<void> _onLoadVideoCards(
      LoadVideoCardsEvent event,
      Emitter<VideoCardsState> emit,
      ) async {
    emit(const VideoCardsLoading()); // Отправляем в UI статус загрузки
    try {
      // Имитируем искусственную задержку асинхронного потока на 1 секунду
      await Future.delayed(const Duration(seconds: 1));
      // Транслируем наружу состояние Loaded с готовым мок-списком объектов
      emit(const VideoCardsLoaded(videoCardsMockData));
    } catch (e) {
      emit(const VideoCardsError('Не удалось загрузить каталог ускорителей'));
    }
  }
}
