import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Color.fromARGB(255, 141, 221, 145), // Set green color to the app bar
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context);
    },
  ),
  title: Text('My Cart'),
  actions: [
    IconButton(
      icon: Icon(Icons.home),
      onPressed: () {
        // Navigate to home screen or any desired action
      },
    ),
  ],
),

      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightGreen[300]!, // Light green color
              Colors.green[900]!,      // Dark green color
            ],
          ),
        ),
        child: Column(
          children: [
            // Add your containers here
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  // Add widgets inside the container here
                  CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/tomatoes.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'Tomato',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Spacer(),
                  Text( '1kg\t\t\t\t'
                    '\$30.00',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/fresh-broccoli-isolated.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  Text(
                    'Broccolli',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  Spacer(),
                  Text('1kg\t\t\t\t'
                    '\$25.00',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ),
            // Add more containers as needed
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$55.00', // Update with the total cost
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement checkout functionality
                },
                child: Text(
                  'Checkout',
                  style: TextStyle(fontSize: 20.0),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 100, 22, 245),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
