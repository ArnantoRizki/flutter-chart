
import 'package:flutter/material.dart';
import '../widgets/chart.dart';


class DataPage extends StatefulWidget {
  @override
  _DataPageState createState() => _DataPageState();
}



class _DataPageState extends State<DataPage> {
  ChartController chartController;
  double height, width;
  double heightStat;

  double highest, lowest;

  List<ScoreDetail> _listScore = <ScoreDetail>[
    ScoreDetail("1",20),
    ScoreDetail("2",25),
    ScoreDetail("3",50),
    ScoreDetail("4",80),
    ScoreDetail("5",65),
    ScoreDetail("6",74),
    ScoreDetail("7",70),
    ScoreDetail("8",46),
    ScoreDetail("9",60),
    ScoreDetail("10",80),
  ];


  @override
  void initState() {
    super.initState();
    chartController = ChartController();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    heightStat = (height * 0.3);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text('Data', style: TextStyle(color: Colors.black),),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Chart(
                controller: chartController,
                width: width,
                heightStat: heightStat,
                standart: 65.0,
                lisnilai: _listScore,
                onTap: (value){
                  setState(() {
                    chartController.copy(value);
                  });
                },
              ),
            ),
            SliverList(delegate: SliverChildBuilderDelegate((context, index){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: chartController.index==index? Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text("${_listScore[index].name}", style: TextStyle(fontSize: 20.0),),
                            Text("index"),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("VALUE : "),
                              Text("${_listScore[index].value}"),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ):Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.grey[50]
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("${_listScore[index].name}", style: TextStyle(fontSize: 20.0),),
                          Text("index"),
                        ],
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("VALUE : "),
                            Text("${_listScore[index].value}"),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }, childCount: _listScore.length))
          ],
        ),
      ),
    );
  }
}
