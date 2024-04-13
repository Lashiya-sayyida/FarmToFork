import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 233, 226), // Setting app bar color to green
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('My order'),
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              // Navigate to home screen or perform any other action
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightGreen[200]!, Colors.lightGreen[800]!],
          ),
        ),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            String date = '';
            String id = '';
            String supplier = '';
            String imagePath = '';
            String imageDetails = '';

            // Assign different data for each card
            if (index == 0) {
              date = 'April 13, 2024';
              id = '123456';
              supplier = 'NatureBites';
              imagePath = 'assets/626.jpg';
              imageDetails = 'Brinjal\n 1\t\t*\t\t25\n amount=25';
            } else if (index == 1) {
              date = 'March 21, 2024';
              id = '654321';
              supplier = 'Ripple';
              imagePath = 'assets/65075.jpg';
              imageDetails ='Carrots\n 2\t\t*\t\t20\n amount=40';
            } else if (index == 2) {
              date = 'May 15, 2023';
              id = '987654';
              supplier = 'DEF farm';
              imagePath = 'assets/tomatoes.jpg';
              imageDetails = 'Tomato\n 3\t\t*\t\t30\n amount=90';
            }

            return Card(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Order Date: $date',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Order ID: $id',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Supplier: $supplier',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Adding space between image and details
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '$imageDetails',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
