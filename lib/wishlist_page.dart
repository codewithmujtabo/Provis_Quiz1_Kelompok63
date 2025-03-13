import 'package:flutter/material.dart';
import 'detail_item_page.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Map<String, dynamic>> _wishlistItems = [
    {
      'name': 'Tenda 8 orang',
      'price': 60000,
      'stock': 3,
      'description': 'Tenda terbuat dari bahan xyz yang tahan kecepatan angin xyz',
      'category': 'Tenda',
      'image': 'assets/tent.jpg',
      'isAvailable': true,
    },
    {
      'name': 'Sleeping Bag Premium',
      'price': 45000,
      'stock': 5,
      'description': 'Sleeping bag dengan bahan tebal untuk area dingin hingga 5°C',
      'category': 'Alat Tidur',
      'image': 'assets/sleeping_bag.jpg',
      'isAvailable': true,
    },
    {
      'name': 'Kompor Portable',
      'price': 25000,
      'stock': 0,
      'description': 'Kompor camping ringan dan mudah dibawa',
      'category': 'Alat Masak',
      'image': 'assets/stove.jpg',
      'isAvailable': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Saya'),
      ),
      body: _wishlistItems.isEmpty
          ? _buildEmptyWishlist()
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ..._wishlistItems.map((item) => _buildWishlistItem(item)),
              ],
            ),
    );
  }

  Widget _buildEmptyWishlist() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Wishlist Anda kosong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Item yang Anda simpan akan muncul di sini',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: null, // Functionality removed
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Jelajahi Produk'),
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
              if (!item['isAvailable'])
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Stok Habis',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        _wishlistItems.remove(item);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${item['name']} dihapus dari wishlist'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${item['price']}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[700],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: null, // Functionality removed
                        icon: const Icon(Icons.shopping_cart, size: 18),
                        label: const Text('Tambah ke Keranjang'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          textStyle: const TextStyle(fontSize: 14),
                          backgroundColor: item['isAvailable'] ? null : Colors.grey[400],
                        ),
                      ),
                    ),
                  ],
                ),
                if (!item['isAvailable'])
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.notifications_none, size: 16, color: Colors.blue[700]),
                        const SizedBox(width: 4),
                        Text(
                          'Beri tahu saya saat tersedia',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[700],
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
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