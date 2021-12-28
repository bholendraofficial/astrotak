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
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Daily Panchang",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
                "India is a country known for its festival but knowing the exact dates can sometimes be difficult. To ensure you do not miss out on the critical dates we bring you the daily panchang."),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.deepOrangeAccent.withOpacity(0.4),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        child: Center(
                          child: Text(
                            "Date:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        width: 100,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("17 Dec 2021"),
                              const Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        child: Center(
                          child: Text(
                            "Location:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        width: 100,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FutureBuilder(
              future: panchangDataProvider.future,
              builder: (BuildContext context, AsyncSnapshot<Data> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      Data data = snapshot.data;
                      return Container(
                        child: Column(
                          children: [
                            tithiWidget(data),
                            SizedBox(
                              height: 20,
                            ),
                            nakshtraWidget(data),
                          ],
                        ),
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
          ],
        ),
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

  tithiWidget(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tithi",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Tithi Number:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
                child: Text(data.tithi.tithiDetails.tithiNumber.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Tithi Name:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(child: Text(data.tithi.tithiDetails.tithiName.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Special:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(child: Text(data.tithi.tithiDetails.special.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Summary:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(child: Text(data.tithi.tithiDetails.summary.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Deity:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(child: Text(data.tithi.tithiDetails.deity.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("End Time:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
                child: Text(data.tithi.endTime.hour.toString() +
                    " hr " +
                    data.tithi.endTime.minute.toString() +
                    " min " +
                    data.tithi.endTime.minute.toString() +
                    " sec")),
          ],
        ),
      ],
    );
  }

  nakshtraWidget(Data data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Nakshtra",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Nakshtra Number:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
                child:
                    Text(data.nakshatra.nakshatraDetails.nakNumber.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Nakshtra Name:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
                child:
                    Text(data.nakshatra.nakshatraDetails.nakName.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Ruler:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
                child: Text(data.nakshatra.nakshatraDetails.ruler.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Deity:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
                child: Text(data.nakshatra.nakshatraDetails.deity.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("Summary:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
                child:
                    Text(data.nakshatra.nakshatraDetails.summary.toString())),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              child: const Text("End Time:"),
              width: MediaQuery.of(context).size.width / 3,
            ),
            Expanded(
                child: Text(data.tithi.endTime.hour.toString() +
                    " hr " +
                    data.tithi.endTime.minute.toString() +
                    " min " +
                    data.tithi.endTime.minute.toString() +
                    " sec")),
          ],
        ),
      ],
    );
  }
}
