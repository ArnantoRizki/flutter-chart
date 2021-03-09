import 'dart:ui';

import 'package:flutter/material.dart';


class MyPainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;

  MyPainter({this.startPoint, this.endPoint});

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = startPoint;
    final p2 = endPoint;
    final paint = Paint()
      ..color = Colors.grey[400]
      ..strokeWidth = 0.8;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return true;
  }
}

class ScoreDetail{
  final String name;
  final double value;

  ScoreDetail(this.name, this.value);
}

class ChartController{
  int _index;
  ScoreDetail _scoreDetail;

  void update({@required int index, @required ScoreDetail scoreDetail}){
    assert(index != null);

    _index = index;
    _scoreDetail = scoreDetail;
  }

  void copy(ChartController anotherController){
    assert(anotherController != null);

    _index = anotherController.index;
    _scoreDetail = anotherController.scoreDetail;
  }

  int get index => _index;

  ScoreDetail get scoreDetail => _scoreDetail;

  @override
  String toString() {
    return "index: ${this._index}, score: ${this._scoreDetail.value}";
  }
}

class Chart extends StatefulWidget {
  final double width;
  final double heightStat;
  final double standart;
  final List<ScoreDetail> lisnilai;
  final Function(ChartController) onTap;
  final ChartController controller;

  Chart({
    Key key, 
    this.width, 
    this.heightStat, 
    this.standart, 
    this.lisnilai, 
    this.onTap, 
    @required this.controller
  }) : assert(controller!=null), super(key: key);
  
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  // int clicked = -1;
  double highest, lowest;

  @override
  void initState() {
    super.initState();
    
    var copyList = <ScoreDetail>[];

    copyList.addAll(widget.lisnilai);

    copyList.sort((a,b)=>a.value.compareTo(b.value));    

    lowest = copyList[0].value;
    highest = copyList[copyList.length-1].value;
  }

  @override
  Widget build(BuildContext context) {
    double sizeDot = 10;
    double sizeFont = 12.0;
    double sizeFontBig = 40.0;
    
    return Container(
      // color: Colors.red,
      width: widget.width,
      height: widget.heightStat+sizeFont+sizeFontBig,
      child: Stack(
        children: [
          Positioned(
            top: sizeFont/2+sizeFontBig/2,
            bottom: sizeFont/2+sizeFontBig/2,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: widget.width,
              height: widget.heightStat,
              child: Stack(
                children: [
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: widget.heightStat * (0/100),
                    child: Container(
                      height: 0.5,
                      color: Colors.grey[100],
                      child: Divider(height: 0.1,)
                    )
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: widget.heightStat * (25/100),
                    child: Container(
                      height: 0.5,
                      color: Colors.grey[100],
                      child: Divider(height: 0.1,)
                    )
                  ),
                  widget.standart!=0.0?Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: widget.heightStat * ((100-widget.standart)/100),
                    child: Container(
                      height: 1.0,
                      color: Colors.green,
                      child: Divider(height: 0.1,)
                    )
                  ):Container(),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: widget.heightStat * (50/100),
                    child: Container(
                      height: 0.5,
                      color: Colors.grey[100],
                      child: Divider(height: 0.1,)
                    )
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: widget.heightStat * (75/100),
                    child: Container(
                      height: 0.5,
                      color: Colors.grey[100],
                      child: Divider(height: 0.1,)
                    )
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      height: 0.5,
                      color: Colors.grey[100],
                      child: Divider(height: 0.1,)
                    )
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: sizeFontBig/2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [100,90,80,70,60,50,40,30,20,10,0].map((e) => 
                      Text(e.toString(), style: TextStyle(fontSize: sizeFont, color: Colors.grey,backgroundColor: Colors.white),)
                    ).toList()
                  ),
                ),
                Expanded(
                  child: Container(
                    height: widget.heightStat+sizeFont+sizeFontBig,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.lisnilai.length,
                      itemBuilder: (context, index){
                        return Stack(
                          children: [
                            Container(
                              width: 40+sizeDot,
                              height: widget.heightStat+sizeFont+sizeFontBig,
                            ),

                            //flag_clicked
                            Positioned(
                              top: 0.0,
                              child: Container(
                                width: 50.0,
                                height: widget.heightStat+sizeFont+sizeFontBig,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                  child: Container(
                                    color: widget.controller.index==index?Color(0x75ededed):Color(0x00ededed),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(child: Container()),
                                        Container(
                                          height: widget.heightStat * (widget.lisnilai[index].value/100)+sizeFontBig/2+sizeFont/2, 
                                          child: Text(
                                            "${widget.lisnilai[index].value.round()}",
                                            style: TextStyle(
                                              color: widget.controller.index!=index? Colors.transparent:
                                              widget.lisnilai[index].value==highest? Colors.blue[300]:
                                              widget.lisnilai[index].value==lowest? Colors.pink[900]:
                                              widget.lisnilai[index].value>=widget.standart? Colors.green:Colors.red,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: sizeFontBig/2+sizeFont/2,
                                          child: Center(
                                            child: Text(
                                              "${widget.lisnilai[index].name}",
                                              style: TextStyle(color: Colors.blueGrey[400]),
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ),

                            //batang
                            Positioned(
                              bottom: sizeFont/2+sizeFontBig/2,
                              child: Container(
                                height: widget.heightStat,
                                width: 40+sizeDot,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(child: Container()),
                                      Container(
                                        height: widget.heightStat * (widget.lisnilai[index].value/100),
                                        width: sizeDot+10,
                                        decoration: BoxDecoration(
                                          color: 
                                          widget.lisnilai[index].value==highest? Colors.blue[300]:
                                          widget.lisnilai[index].value==lowest? Colors.pink[900]:
                                          widget.lisnilai[index].value>=widget.standart?  Colors.green:Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            //Line
                            index<=widget.lisnilai.length-2? Positioned(
                              top: sizeFont/2+sizeFontBig/2,
                              child: Container(
                                child: CustomPaint(
                                  size: Size(50, widget.heightStat),
                                  painter: MyPainter(
                                    startPoint: Offset(25.0,widget.heightStat*(100-widget.lisnilai[index].value)/100),
                                    endPoint: Offset(75,widget.heightStat*(100-widget.lisnilai[index+1].value)/100),
                                  ),
                                ),
                              )
                            ):Container(),

                            //dot
                            Positioned(
                              bottom: sizeFontBig/2,
                              top: sizeFontBig/2,
                              child: Container(
                                // color: Colors.blue,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: (){
                                    setState(() {
                                      widget.controller.update(
                                        index: index,
                                        scoreDetail: widget.lisnilai[index]
                                      );
                                    });
                                    widget.onTap(widget.controller);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Expanded(child: Container()),
                                        Container(
                                          height: widget.heightStat * (widget.lisnilai[index].value/100)+sizeDot/2+sizeFont/2, 
                                          child: Column(
                                            children: [
                                              Container(
                                                width: sizeDot,
                                                height: sizeDot,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: widget.controller.index!=index? Colors.grey[350]:
                                                  widget.lisnilai[index].value==highest? Colors.blue[300]:
                                                  widget.lisnilai[index].value==lowest? Colors.pink[900]:
                                                  widget.lisnilai[index].value>=widget.standart?  Colors.green:Colors.red,
                                                ),
                                                child: Center(
                                                  child: Container(
                                                    width: 0.4*sizeDot,
                                                    height: 0.4*sizeDot,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
