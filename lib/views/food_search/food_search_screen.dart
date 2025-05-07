
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../foods/food_details_screen.dart';
import '../home_data/home_navigation_bar.dart';

class FoodSearchScreen extends StatefulWidget {
  final List<QueryDocumentSnapshot> foods;

  const FoodSearchScreen({super.key, required this.foods});

  @override
  _FoodSearchScreenState createState() => _FoodSearchScreenState();
}

class _FoodSearchScreenState extends State<FoodSearchScreen> {
  late List<QueryDocumentSnapshot> _filteredFoods;

  @override
  void initState() {
    super.initState();
    _filteredFoods = widget.foods;
  }

  void _filterFoods(String query) {
    setState(() {
      _filteredFoods = widget.foods.where((product) {
        final productName =
            (product.data() as Map<String, dynamic>)['name'] ?? '';
        return productName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  List<Widget> _buildPatternedBoxes() {
    List<Widget> rows = [];
    int i = 0;

    while (i < _filteredFoods.length) {
      // First row: 2 boxes
      List<Widget> row1 = [];
      for (int j = 0; j < 2 && i < _filteredFoods.length; j++, i++) {
        row1.add(_buildBox(_filteredFoods[i]));
      }
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: row1,
      ));
      rows.add(const SizedBox(height: 8));

      // Second row: 1 centered box
      if (i < _filteredFoods.length) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [_buildBox(_filteredFoods[i])],
        ));
        i++;
        rows.add(const SizedBox(height: 8));
      }
    }

    return rows;
  }

  Widget _buildBox(QueryDocumentSnapshot product) {
    final data = product.data() as Map<String, dynamic>;
    final foodName = data['name'] ?? 'Unnamed Food';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => FoodsDetailScreen(foodsId: product.id)),
        );
      },
      child: Container(
        width: 150,
        height: 40,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF096056),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          foodName,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ClipOval(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeNavigationBar()),
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Color(0xFF096056)),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF096056),
        title:
        const Text('Food Search', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              height: 44,
              child: TextField(
                onChanged: _filterFoods,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF096056),),
                    borderRadius: BorderRadius.circular(15),
                  ),enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color:Color(0xFF096056),),borderRadius: BorderRadius.circular(15)),
                  prefixIcon: const Icon(Icons.search),focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Color(0xFF096056),),borderRadius: BorderRadius.circular(15)),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _buildPatternedBoxes(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
