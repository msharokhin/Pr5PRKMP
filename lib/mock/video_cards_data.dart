import '../models/video_card.dart';

const List<VideoCard> videoCardsMockData = [
  VideoCard(
    title: 'NVIDIA GeForce RTX 5090',
    shortDescription: 'Флагман архитектуры Blackwell.',
    fullDescription: 'Флагман новейшей архитектуры Blackwell. Оснащен 32 ГБ сверхбыстрой видеопамяти формата GDDR7. Обеспечивает абсолютное превосходство в 4K гейминге, генерации кадров и трассировке лучей следующего поколения.',
    image: 'assets/5090.jpg',
  ),
  VideoCard(
    title: 'NVIDIA GeForce RTX 4070',
    shortDescription: 'Оптимальное решение для 2K-гейминга.',
    fullDescription: 'Сбалансированное решение для современных игр в разрешении 2K на архитектуре Ada Lovelace. Поддерживает технологии ИИ, DLSS 3.0 и аппаратную трассировку лучей при низком энергопотреблении.',
    image: 'assets/4070.jpg',
  ),
  VideoCard(
    title: 'AMD Radeon RX 7900 XTX',
    shortDescription: 'Топовый ускоритель на чиплетах RDNA 3.',
    fullDescription: 'Флагманский графический адаптер от AMD, построенный на революционной чиплетной архитектуре RDNA 3. Несет на борту 24 ГБ видеопамяти, обеспечивая колоссальную растровую производительность.',
    image: 'assets/7900.jpg',
  ),
  VideoCard(
    title: 'NVIDIA GeForce GTX 580',
    shortDescription: 'Легендарный представитель архитектуры Fermi.',
    fullDescription: 'Исторический графический ускоритель на базе архитектуры Fermi. Классическое решение прошлых лет, заложившее фундаментальные основы параллельных вычислений в современных GPU.',
    image: 'assets/580.jpg',
  ),
];
