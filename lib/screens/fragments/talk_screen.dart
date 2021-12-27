import 'package:astrotak/app/app_state.dart';
import 'package:astrotak/model/astrologer_model.dart';
import 'package:astrotak/provider/astrologer_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TalkToAstrologerScreen extends StatefulWidget {
  const TalkToAstrologerScreen({Key key}) : super(key: key);

  @override
  _TalkToAstrologerScreenState createState() => _TalkToAstrologerScreenState();
}

class _TalkToAstrologerScreenState extends AppState<TalkToAstrologerScreen> {
  AstrologerDataProvider astrologerDataProvider;
  @override
  Widget build(BuildContext context) {
    astrologerDataProvider = Provider.of<AstrologerDataProvider>(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Row(
            children: [
              const Text(
                "Talk to an Astrologer",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Expanded(child: SizedBox()),
              Image.asset(
                "assets/icons/search.png",
                height: 24,
                width: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                "assets/icons/filter.png",
                height: 24,
                width: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                "assets/icons/sort.png",
                height: 24,
                width: 24,
              )
            ],
          ),
        ),
        Expanded(
          child: FutureBuilder(
            future: astrologerDataProvider.future,
            builder:
                (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          Data data = snapshot.data[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    Image.network(data.images.medium.imageUrl),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.firstName + " " + data.lastName,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          data.experience.toString() + " years",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.ac_unit_outlined,
                                          color: Colors.deepOrangeAccent,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(data.skills
                                              .map((skill) => skill.name)
                                              .toList()
                                              .join(", ")),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.ac_unit_outlined,
                                          color: Colors.deepOrangeAccent,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                            child: Text(data.languages
                                                .map(
                                                    (language) => language.name)
                                                .toList()
                                                .join(", ")))
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.ac_unit_outlined,
                                          color: Colors.deepOrangeAccent,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "₹ ${data.minimumCallDurationCharges.toString()} / min",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 20),
                                      child: ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: const Icon(Icons.call),
                                          label: Container(
                                            child: const Text("Talk on Call"),
                                            padding: const EdgeInsets.all(12),
                                          )),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        },
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider(
                            color: Colors.grey,
                          );
                        },
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
        ),
      ],
    ));
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      astrologerDataProvider =
          Provider.of<AstrologerDataProvider>(context, listen: false);
      astrologerDataProvider.getAstrologerData(context);
    }
  }
}
