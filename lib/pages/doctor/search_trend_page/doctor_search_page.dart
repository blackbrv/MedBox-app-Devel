import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medapp/pages/doctor/trend_lansia/doctor_trend_lansia_page.dart';
import 'package:medapp/utils/colors.dart';

class dSearchPage extends StatefulWidget {
  const dSearchPage({super.key});

  @override
  State<dSearchPage> createState() => _dSearchPageState();
}

class _dSearchPageState extends State<dSearchPage> {
  TextEditingController searchController = TextEditingController();

  var dbRef = FirebaseFirestore.instance.collection('profile');
  var qr;

  List _allResult = [];
  List _resultList = [];

  getClientStream() async {
    var data = await dbRef.orderBy('nama_lansia').get();
    setState(() {
      _allResult = data.docs;
    });
    searchResultList();
  }

  onSearchChanged() {
    print(searchController.text);
    searchResultList();
  }

  searchResultList() {
    var showResult = [];
    if (searchController.text != ' ') {
      for (var clientSnapshot in _allResult) {
        var name = clientSnapshot['nama_lansia'].toString().toLowerCase();
        if (name.contains(searchController.text.toLowerCase())) {
          showResult.add(clientSnapshot);
        }
      }
    } else {
      showResult = List.from(_allResult);
    }

    setState(() {
      _resultList = showResult;
    });
  }

  @override
  void initState() {
    getClientStream();
    searchController.addListener(onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    searchController.removeListener(onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getClientStream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cari Lansia',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CupertinoSearchTextField(
              controller: searchController,
              borderRadius: BorderRadius.circular(20),
              itemSize: 20,
            ),
          ),
          Expanded(
              child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemCount: _resultList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  _resultList[index]['nama_lansia'],
                ),
                subtitle: Text(
                  _resultList[index]['umur_lansia'],
                ),
                onTap: () {
                  setState(() {
                    qr = _resultList[index]['kode_alat'];
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => dTrend(
                                qrcode: qr,
                                namaLan: _resultList[index]['nama_lansia'],
                              )));
                },
                tileColor: mCardBgColor,
                splashColor: mSecondaryColorLightOpac,
              );
            },
          )),
        ],
      )),
    );
  }
}
