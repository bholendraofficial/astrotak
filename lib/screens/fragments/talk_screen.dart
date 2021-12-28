/*
 * Copyright (c) 2021. Bholendra Singh
 */

import 'package:astrotak/app/app_state.dart';
import 'package:astrotak/helper/progress_dialog.dart';
import 'package:astrotak/model/sort_model.dart';
import 'package:astrotak/model/astrologer_model.dart';
import 'package:astrotak/provider/astrologer_data_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
              GestureDetector(
                child: Image.asset(
                  "assets/icons/search.png",
                  height: 24,
                  width: 24,
                ),
                onTap: () {
                  astrologerDataProvider.showSearchBar =
                      !astrologerDataProvider.showSearchBar;
                  astrologerDataProvider.notifyListeners();
                },
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
              PopupMenuButton<SortModel>(
                itemBuilder: (BuildContext context) {
                  return astrologerDataProvider.sortList
                      .map((SortModel sortModel) {
                    return PopupMenuItem<SortModel>(
                      value: sortModel,
                      child: Row(
                        children: [
                          IgnorePointer(
                            child: Checkbox(
                                value: sortModel.isSelected,
                                onChanged: null,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                          ),
                          Text(sortModel.name),
                        ],
                      ),
                    );
                  }).toList();
                },
                onSelected: (sortModel) {
                  astrologerDataProvider.sortData(sortModel);
                },
                child: Image.asset(
                  "assets/icons/sort.png",
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ),
        astrologerDataProvider.showSearchBar
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade200),
                child: TextFormField(
                  onChanged: (value) {
                    astrologerDataProvider.onSearch(value);
                  },
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.deepOrangeAccent,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                          onPressed: () {
                            astrologerDataProvider.clearSearch();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.deepOrangeAccent,
                          ))),
                ),
              )
            : const SizedBox(),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: FutureBuilder(
            future: astrologerDataProvider.future,
            builder:
                (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  if (snapshot.hasData && snapshot.data.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          Data data = snapshot.data[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl: data.images.medium.imageUrl,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 80,
                                placeholder: (context, url) => ProgressDialog
                                    .getCircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/icons/logo.png"),
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
      astrologerDataProvider.getAstroDataAPI(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
