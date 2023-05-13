import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CardLoader extends StatelessWidget {
  const CardLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: Row(
        children: [
          Container(
              margin: EdgeInsets.all(10.0),
              height: 160.0,
              width: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0xff424242),
              ),
              child: Center(child: CircularProgressIndicator())),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ThickLoader(),
                  Container(width: 100.0, child: ThickLoader()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBarIndicator(
                        rating: 0.0,
                        itemBuilder: (context, index) =>
                            Icon(Icons.star, color: Colors.amber),
                        itemCount: 5,
                        itemSize: 25.0,
                      ),
                      SizedBox(width: 20.0),
                      Container(width: 50.0, child: ThinLoader()),
                      SizedBox(width: 5.0)
                    ],
                  ),
                  ThinLoader(),
                  Container(width: 160.0, child: ThinLoader()),
                  // Text('Release : 05/12/2022')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ThinLoader extends StatelessWidget {
  const ThinLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(color: Color(0xff424242), minHeight: 15.0);
  }
}

class ThickLoader extends StatelessWidget {
  const ThickLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(color: Color(0xff424242), minHeight: 20.0);
  }
}
