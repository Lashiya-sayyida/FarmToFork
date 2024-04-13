import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FarmerPage extends StatefulWidget {
  final String id;
  const FarmerPage({super.key, required this.id});

  @override
  State<FarmerPage> createState() => _FarmerPageState();
}

class _FarmerPageState extends State<FarmerPage> {
  List<Map<String, dynamic>> farmerData = [];
  List<Map<String, dynamic>> location = [];

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    fetchAndSetFarmerData();
  }

  Future<void> fetchAndSetFarmerData() async {
    List<Map<String, dynamic>> farmerLocationData = [];
    try {
      QuerySnapshot querySnapshot = await db.collection('tbl_farmer').get();

      for (DocumentSnapshot docSnapshot in querySnapshot.docs) {
        if (docSnapshot.exists) {
          Map<String, dynamic> farmer =
              docSnapshot.data() as Map<String, dynamic>;
          farmer['id'] = docSnapshot.id; // Include the document ID

          // Call fetchLocation function with the place_id
          Map<String, dynamic>? locationData =
              await fetchLocation(farmer['place_id']);

          if (locationData != null) {
            // Add district name and place name to the farmer data
            farmer['district_name'] = locationData['district'];
            farmer['place_name'] = locationData['places'];

            farmerLocationData.add(farmer);
          }
          setState(() {
            farmerData = farmerLocationData;
          });
        } else {
          print('Document with ID ${docSnapshot.id} does not exist');
          // Handle the case where the document doesn't exist
        }
      }
    } catch (e) {
      print("Error fetching and setting farmer data: $e");
      // Handle the error as needed
    }
  }

  Future<Map<String, dynamic>?> fetchLocation(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> placeSnapshot =
          await db.collection('tbl_place').doc(id).get();

      String placeName = placeSnapshot['place_name'].toString();
      String distid = placeSnapshot['district_id'].toString();

      // Fetch district information
      DocumentSnapshot<Map<String, dynamic>> districtSnapshot =
          await db.collection('tbl_district').doc(distid).get();

      // Extract district name
      String districtName = districtSnapshot['district_name'].toString();

      // Return the district name and place names as a map
      return {
        'district': districtName,
        'places': placeName,
      };
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> fetchVegetables() async {
    try {
      QuerySnapshot vegetableSnapshot = await FirebaseFirestore.instance
          .collection('tbl_vegetable')
          .where('farmer_id', isEqualTo: widget.id)
          .get();
      List<Map<String, dynamic>> vegData = [];
      vegetableSnapshot.docs.forEach((doc) async {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        data?['id'] = doc.id;
        // Fetch category name based on category_id
        String categoryName = await getCategoryName(data?['category_id']);
        data?['category_name'] = categoryName;
        vegData.add(data!);
      });
    } catch (e) {
      print('Vegetables error: $e');
    }
  }

  Future<String> getCategoryName(String categoryId) async {
  try {
    DocumentSnapshot categorySnapshot = await FirebaseFirestore.instance
        .collection('tbl_category')
        .doc(categoryId)
        .get();

    // Check if the document exists and contains the 'name' field
    if (categorySnapshot.exists && categorySnapshot.get('category_name') != null) {
      return categorySnapshot.get('category_name') as String;
    } else {
      // Return a default value or handle the null case accordingly
      return 'Category Name Not Found';
    }
  } catch (e) {
    print("Error getting category name: $e");
    // Return a default value or handle the error case accordingly
    return 'Error Getting Category Name';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(widget.id),
      ),
    );
  }
}
