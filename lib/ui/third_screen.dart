import 'package:flutter/material.dart';
import 'package:suitmedia_apps_zufar/api/api_service.dart';
import 'package:suitmedia_apps_zufar/model/people.dart';
import 'package:suitmedia_apps_zufar/common/style.dart';

class ThirdPage extends StatefulWidget {
  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  late Future<People> _people;
  int data = 1;

  @override
  void initState() {
    super.initState();
    _people = ApiService().topHeadlines(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Third Screen",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return RefreshIndicator(
      color: secondaryColor,
      onRefresh: refreshData,
      child: FutureBuilder(
        future: _people,
        builder: (context, AsyncSnapshot<People> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator(
              color: secondaryColor,
            ));
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.data.length,
                itemBuilder: (context, index) {
                  var ppl = snapshot.data?.data[index];
                  return CardPeople(data: ppl!);
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Text('');
            }
          }
        },
      ),
    );
  }

  Future refreshData() async {
    if (data == 1) {
      setState(() {
        data = data + 1;
        _people = ApiService().topHeadlines(data);
      });
    } else {
      setState(() {
        data = data - 1;
        _people = ApiService().topHeadlines(data);
      });
    }
  }
}

class CardPeople extends StatelessWidget {
  final Datum data;

  const CardPeople({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: barListColor,
          ),
        ),
      ),
      child: ListTile(
        onTap: () {
          Navigator.pop(context, data);
        },
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(data.avatar),
            ),
          ),
        ),
        title: Text(
          "${data.firstName} ${data.lastName}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          data.email,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
