import 'package:astrotak/model/panchang_model.dart';
import 'package:astrotak/provider/panchang_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PanchangDataProvider panchangDataProvider;
  @override
  Widget build(BuildContext context) {
    panchangDataProvider = Provider.of<PanchangDataProvider>(context);
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Panchang",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: FutureBuilder(
              future: panchangDataProvider.future,
              builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                      );
                    } else {
                      return const Center(
                        child: Text("No Record(s)"),
                      );
                    }
                    break;

                  default:
                    {
                      return const Center(child: CircularProgressIndicator());
                    }
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      panchangDataProvider =
          Provider.of<PanchangDataProvider>(context, listen: false);
      panchangDataProvider.getPanchangDataAPI(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
