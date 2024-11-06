
import 'package:flutter/widgets.dart';

///setting the flex field will ignore the width and height
class Empty extends StatelessWidget{

  double? width, height;
  int? flex;

  ///setting the flex field will ignore the width and height
  Empty({this.width, this.height, this.flex});

  @override
  Widget build(BuildContext context) {
    return (flex == null)?
        Container(width: width, height: height):
        Expanded(flex: flex!, child: Container(),);
  }

}
