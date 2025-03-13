import 'package:flutter/material.dart';
import 'detail_item_page.dart';
import 'chat_page.dart';
import 'wishlist_page.dart';
import 'cart_checkout_page.dart';
import 'packages_page.dart';
import 'transaction_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CampEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: const Color(0xFFF5F5DC), // Beige earth tone
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF8B7355), // Earth brown
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _selectedCategory = 'Semua';
  String _selectedSubCategory = '';

  final List<String> _categories = [
    'Semua', 
    'Ransel', 
    'Alat Masak', 
    'Jaket & Sepatu', 
    'Tenda'
  ];

  final List<String> _subCategories = [
    'Penerangan', 
    'Alat Tidur', 
    'Lainnya'
  ];

  final List<Map<String, dynamic>> _items = [
    {
      'name': 'Tenda 8 orang',
      'price': 60000,
      'stock': 3,
      'description': 'Tenda terbuat dari bahan xyz yang tahan kecepatan angin xyz',
      'category': 'Tenda',
      'image': 'assets/tent-8-people.png'
    },
    {
      'name': 'Sepatu Gunung',
      'price': 30000,
      'stock': 10,
      'description': 'Sepatu waterproof, merk XYZ semua ukuran',
      'category': 'Jaket & Sepatu',
      'image': 'assets/shoes.jpg'
    },
  ];

  final List<Map<String, dynamic>> _packages = [
    {
      'name': 'Paket Hemat 1',
      'image': 'assets/package1.jpg',
    },
    {
      'name': 'Paket Promo A',
      'image': 'assets/package2.jpg',
    },
    {
      'name': 'Paket Lengkap',
      'image': 'assets/package3.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildContent(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFECDCC2), // Light earth tone
          borderRadius: BorderRadius.circular(30),
        ),
        margin: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
              
              // Navigasi ke pages lain berdasarkan index
              if (index == 0) {
                // Default di home sebagai page utama
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WishlistPage()),
                );
              } else if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TransactionPage()),
                );
              } else if (index == 4) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartCheckoutPage()),
                );
              }
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xFFECDCC2), // Light earth tone
            selectedItemColor: const Color(0xFFFF8C00), // Dark orange
            unselectedItemColor: const Color(0xFF8B7355), // Earth brown
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                label: 'Wishlist',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long),
                label: 'Transaksi',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: 'Keranjang',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Search bar and profile
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFECDCC2), // Light earth tone
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    // Mengganti TextField dengan Text untuk menonaktifkan input
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Cari Perlengkapan',
                          style: TextStyle(
                            color: Color(0xFF5D4037), // Dark brown
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    const Icon(Icons.search, color: Color(0xFF5D4037)), // Dark brown
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: Color(0xFF8B7355), // Earth brown
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.person, size: 30, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Categories (non-interaktif)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _categories.map((category) {
              bool isSelected = _selectedCategory == category;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                // Mengganti ChoiceChip dengan Container untuk menonaktifkan interaksi
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFFECDCC2), // Dark orange : Light earth tone
                    borderRadius: BorderRadius.circular(20),
                    // Mempertahankan gaya visual yang sama
                    border: Border.all(
                      color: isSelected ? const Color(0xFFFF8C00) : const Color(0xFFD7CCA3), // Dark orange : Darker earth tone
                      width: 1,
                    ),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF5D4037), // White : Dark brown
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),

        // Sub-categories (non-interaktif)
                  if (_selectedCategory == 'Tenda' || _selectedCategory == 'Semua')
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _subCategories.map((subCategory) {
              bool isSelected = _selectedSubCategory == subCategory;
              // Mengganti InkWell dengan Container untuk menonaktifkan interaksi
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD7CCA3)), // Darker earth tone
                  borderRadius: BorderRadius.circular(4),
                  color: isSelected ? const Color(0xFF2E8B57).withAlpha(50) : Colors.white, // Light sea green if selected
                ),
                child: Text(
                  subCategory,
                  style: TextStyle(
                    color: isSelected ? const Color(0xFF2E8B57) : const Color(0xFF5D4037), // Sea green : Dark brown
                  ),
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: 12),

        // Sort button
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFECDCC2), // Light earth tone
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sort, size: 18, color: Color(0xFF5D4037)), // Dark brown
                SizedBox(width: 4),
                Text('Urutkan', 
                  style: TextStyle(
                    fontSize: 14, 
                    color: Color(0xFF5D4037), // Dark brown
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),

        // Items list
        ..._items.map((item) => InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailItemPage(item: item),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFECDCC2), // Light earth tone
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFD7CCA3)), // Darker earth tone
                  ),
                  child: const Center(
                    child: Icon(Icons.image, size: 40, color: Color(0xFF8B7355)), // Earth brown
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5D4037), // Dark brown
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rp. ${item['price']} (sisa ${item['stock']})',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF8C00), // Dark orange
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['description'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8B7355), // Earth brown
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )).toList(),
        
        const SizedBox(height: 20),
        
        // Package offers - layout yang lebih rapi dan menarik
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 4, bottom: 12),
              child: Text(
                'Paket Spesial',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037), // Dark brown
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFD7CCA3)), // Darker earth tone
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _packages.map((package) => Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PackagesPage(packageName: package['name']),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5DC), // Beige earth tone
                        border: Border.all(color: const Color(0xFFD7CCA3)), // Darker earth tone
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: const Color(0xFFECDCC2), // Light earth tone
                              border: Border.all(color: const Color(0xFFD7CCA3)), // Darker earth tone
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1A000000), // 10% opacity black
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Icon(Icons.image, size: 40, color: Color(0xFF8B7355)), // Earth brown
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            package['name'],
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF5D4037), // Dark brown
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}