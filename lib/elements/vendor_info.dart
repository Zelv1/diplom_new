import 'package:flutter/material.dart';

class VendorInfo extends StatelessWidget {
  const VendorInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => {
              Navigator.pop(
                context,
              ),
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: <Widget>[
            Center(
              child: _buildSectionTitle('Руководство заказчика'),
            ),
            _buildSectionTitle('1. Авторизация'),
            _buildSectionText(
              'После успешной авторизации вы попадете на главную страницу приложения.',
            ),
            _buildSectionTitle('2. Главная страница'),
            _buildSectionText(
              'На главной странице вы можете:',
            ),
            _buildListText([
              'Выбрать заказ долгим нажатием на его карточку. После этого вам доступны следующие варианты:',
              'Удалить заказ.',
              'Распечатать информацию о заказе.',
              'Просмотреть информационный стикер.',
            ]),
            _buildSectionText(
              'На всех последующих страницах также реализована возможность переключения между светлой и темной темами.',
            ),
            _buildSectionTitle('3. История заказов'),
            _buildSectionText(
              'Для просмотра истории заказов:',
            ),
            _buildListText([
              'Выберите заказ долгим нажатием на его карточку.',
              'Вам будет доступна возможность распечатать информацию о выполненной доставке.',
            ]),
            _buildSectionTitle('4. Форма оформления заказа'),
            _buildSectionText(
              'Для оформления нового заказа:',
            ),
            _buildListText([
              'Введите необходимые данные в форму.',
              'Нажмите кнопку "Опубликовать".',
              'Если введенные данные некорректны, приложение уведомит вас об ошибке.',
            ]),
            _buildSectionTitle('5. Профиль'),
            _buildSectionText(
              'В разделе "Профиль" вы можете:',
            ),
            _buildListText([
              'Просмотреть свою персональную информацию.',
              'Изменить свои личные данные.',
              'Воспользоваться кнопкой для выхода из аккаунта.',
            ]),
            Image.asset('assets/images/Vendor.png'),
          ]),
        ));
  }
}

Widget _buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildSectionText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16.0),
    ),
  );
}

Widget _buildListText(List<String> texts) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: texts
          .map(
              (text) => Text('• $text', style: const TextStyle(fontSize: 16.0)))
          .toList(),
    ),
  );
}
