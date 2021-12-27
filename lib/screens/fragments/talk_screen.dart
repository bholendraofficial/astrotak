import 'package:flutter/material.dart';

class TalkToAstrologerScreen extends StatefulWidget {
  const TalkToAstrologerScreen({Key key}) : super(key: key);

  @override
  _TalkToAstrologerScreenState createState() => _TalkToAstrologerScreenState();
}

class _TalkToAstrologerScreenState extends State<TalkToAstrologerScreen> {
  @override
  Widget build(BuildContext context) {
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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          child: Image.network(
                              "https://tak-astrotak-av.s3.ap-south-1.amazonaws.com/astro-images/agents/K.k-Mishra_740x502.jpg"),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Arvind shukla",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "20 years",
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.ac_unit_outlined,
                                    color: Colors.deepOrangeAccent,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                        "Demo sjfhdsjkhfk jkhsdfkjhdskl sfjhlkasjflkjsd sdfjhsdlkfj"),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.ac_unit_outlined,
                                    color: Colors.deepOrangeAccent,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text("English, Hindi"),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.ac_unit_outlined,
                                    color: Colors.deepOrangeAccent,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "₹100/ min",
                                      style: TextStyle(
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
                    ),
                  );
                },
                shrinkWrap: true,
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
