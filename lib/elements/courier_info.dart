import 'package:flutter/material.dart';

class CourierInfo extends StatelessWidget {
  const CourierInfo({super.key});

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
              child: _buildSectionTitle('Руководство курьера'),
            ),
            _buildSectionTitle('1. Авторизация'),
            _buildSectionText(
              'После успешной авторизации вас перебросит на главную страницу, на которой будут отображаться заказы, которые надо доставить.',
            ),
            _buildSectionTitle('2. Процесс доставки'),
            _buildSectionText(
              'Сам процесс доставки происходит следующим образом:',
            ),
            _buildListText([
              'После долгого нажатия на карточку заказа, он выберется и появится кнопка для взятия заказа.',
              'Нажимаете на него и вы сразу переходите в новое окно, которое представляет собой информацию о заказе.',
              'В новом окне добавляется слайдер выдачи заказа. После скролла слайдера до конца заказ будет считаться выполненным.',
              'Вы также можете взять заказ путем нажатия на главной странице на иконку сканера и просканировать QR-код.',
            ]),
            _buildSectionTitle('3. Главное меню'),
            _buildSectionText(
              'На главной странице, если нажать на пункт меню, откроется выпадающее меню с следующими функциями:',
            ),
            _buildListText([
              'Просмотр вашей персональной информации.',
              'Просмотр истории заказов.',
              'Переключение цветовой темы.',
              'Вызов менеджера.',
              'Выход из аккаунта.',
            ]),
            _buildSectionTitle('4. История заказов'),
            _buildSectionText(
              'Если нажать в выпадающем меню на "Историю заказов", откроется история заказов курьера, которая отфильтрована по дням (на момент просмотра - сегодня и позавчера).',
            ),
            Image.asset('assets/images/Courier.png'),
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
