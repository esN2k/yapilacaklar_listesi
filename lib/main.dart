// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_element

import 'package:flutter/material.dart';
// Scaffold, Buton ve AppBar için gerekli kaynaklar.
// Flutter bu paket ile geliyor. Genel olarak geliştiriciler işlerini kolaylaştırmak ve hızlandırmak için paketler kullanırlar. bkz. https://pub.dev/

//void main() => runApp(
//    MaterialApp(home: Todo()), //Material'dan gelen 1. class
//); //MyApp verirse main'i çalıştır, vermez ise çalıştırma

void main() {
  runApp(App());
}

class App extends StatelessWidget {
//StatelessWidget sadece AppBar gibi yeri asla değişmeyecek yerlerde kullanılır. Bizim listemiz sürekli değişir.
//Telefonun modeline göre ekranın üst tarafı kamera yüzünden değişebilir fakat bunu şu anlık ayarlamayacağım.
  @override
  Widget build(BuildContext context) {
    //Flutter Widget'ları uygulamanın o anki durumuna göre nasıl gözükeceğini belirler.
    return MaterialApp(
        //Tüm kod MaterialApp'ın içerdiği bir widget gibi düşünülebilir.
        //Material'dan gelen class
        title: 'Yapılacaklar Listesi',
        home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  //veri kaydetme
  final List<String> _todoList = <String>[];
  // Text yazma yeri
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Uygulama düzeni
    return Scaffold(
      appBar: AppBar(title: const Text('Yapılacaklar Listesi')),
      body: ListView(children: _getItems()),
      // Listeye ekleme yapma
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Görev Ekleme',
          child: Icon(Icons.add)),
    );
  }

// Listeye veri ekleme
  void _addTodoItem(String title) {
    // Değişim olursa setState bildirecek
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

//listeyi doldurma
  Widget _buildTodoItem(String title) {
    return ListTile(
      title: Text(title),
    );
  }

//Bir widget
// ismini sorma dialogu
  Future<Future> _displayDialog(BuildContext context) async {
    //isim sorma için state değiştirtme
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Listeye ekleme yap'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Ekleme Yazın'),
            ),
            actions: <Widget>[
              //ekleme butonu
              TextButton(
                child: const Text('Ekle'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
              //iptal butonu
              TextButton(
                child: const Text('İptal'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

// Tekrarlama
  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoList) {
      _todoWidgets.add(_buildTodoItem(title));
    }
    return _todoWidgets;
  }
}
