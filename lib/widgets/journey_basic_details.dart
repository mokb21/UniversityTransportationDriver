import 'package:flutter/material.dart';

class JourneyBasicDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(
              left: 5.0,
              right: 5.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.0),
                Text(
                  'Journey Name',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.blue,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Email@email.com'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('test'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
