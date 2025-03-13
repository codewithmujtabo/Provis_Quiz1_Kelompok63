import 'package:flutter/material.dart';
import 'review_rating_page.dart';
import 'cart_checkout_page.dart';

class DetailItemPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const DetailItemPage({Key? key, required this.item}) : super(key: key);

  @override
  State<DetailItemPage> createState() => _DetailItemPageState();
}

class _DetailItemPageState extends State<DetailItemPage> {
  final int _quantity = 1;
  final bool _isAddedToWishlist = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              _isAddedToWishlist ? Icons.favorite : Icons.favorite_border,
              color: _isAddedToWishlist ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Produk (untuk tampilan saja)
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            ),
            
            // Informasi Produk
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.item['name'],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Stok: ${widget.item['stock']}',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp. ${widget.item['price']}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[700],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Rating
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewRatingPage(item: widget.item),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < 4 ? Icons.star : Icons.star_half,
                              color: Colors.amber,
                              size: 20,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '4.5 (4 ulasan)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Description
                  const Text(
                    'Deskripsi Produk',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.item['description'],
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Additional information
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Informasi Tambahan',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildInfoRow('Kategori', widget.item['category']),
                        const SizedBox(height: 8),
                        _buildInfoRow('Lama Sewa', 'Min. 1 hari, Maks. 7 hari'),
                        const SizedBox(height: 8),
                        _buildInfoRow('Deposit', 'Rp. ${widget.item['price']}'),
                        const SizedBox(height: 8),
                        _buildInfoRow('Ketentuan', 'Harus kembali dalam kondisi baik'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Quantity
                  Row(
                    children: [
                      const Text(
                        'Jumlah:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: null,
                            ),
                            Text(
                              '$_quantity',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const IconButton(
                              icon: Icon(Icons.add),
                              onPressed: null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // "For beginner" section
                  if (widget.item['category'] == 'Tenda')
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.lightbulb, color: Colors.amber[700]),
                              const SizedBox(width: 8),
                              const Text(
                                'Tips untuk Pemula:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tenda ini cocok untuk pemula. Pastikan untuk memasang di tempat yang rata dan tidak berbatu. Tanyakan kepada kami jika butuh bantuan cara memasangnya.',
                            style: TextStyle(height: 1.5),
                          ),
                          const SizedBox(height: 8),
                          const TextButton(
                            onPressed: null,
                            child: Text('Tanya Admin'),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Total: Rp. ${widget.item['price'] * _quantity}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Tambah ke Keranjang',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(color: Colors.grey[700]),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}