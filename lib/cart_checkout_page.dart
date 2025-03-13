import 'package:flutter/material.dart';

class CartCheckoutPage extends StatefulWidget {
  const CartCheckoutPage({Key? key}) : super(key: key);

  @override
  State<CartCheckoutPage> createState() => _CartCheckoutPageState();
}

class _CartCheckoutPageState extends State<CartCheckoutPage> {
  final List<Map<String, dynamic>> _cartItems = [
    {
      'name': 'Tenda 8 orang',
      'price': 60000,
      'quantity': 1,
      'days': 3,
      'description': 'Tenda terbuat dari bahan xyz yang tahan kecepatan angin xyz',
      'category': 'Tenda',
      'image': 'assets/tent.jpg',
    },
    {
      'name': 'Matras',
      'price': 15000,
      'quantity': 2,
      'days': 3,
      'description': 'Matras nyaman untuk tidur di luar ruangan',
      'category': 'Alat Tidur',
      'image': 'assets/matras.jpg',
    },
  ];

  final List<String> _promoOptions = [
    'NEWUSER20',
    'KEMPING10',
    'WEEKEND15',
  ];

  String _selectedPaymentMethod = 'transfer';
  String? _selectedPromo;
  DateTime _startDate = DateTime.now().add(const Duration(days: 1));
  DateTime _endDate = DateTime.now().add(const Duration(days: 4));
  bool _isDeliverySelected = false;
  int _deliveryFee = 25000;

  int get _subtotal => _cartItems.fold(
      0,
      (sum, item) =>
          sum + (item['price'] * item['quantity'] * item['days'] as int));

  int get _discount => _selectedPromo != null ? (_subtotal * 0.1).round() : 0;

  int get _total =>
      _subtotal - _discount + (_isDeliverySelected ? _deliveryFee : 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang & Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cart items
                  const Text(
                    'Barang yang Disewa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...List.generate(
                    _cartItems.length,
                    (index) => _buildCartItem(_cartItems[index], index),
                  ),
                  const SizedBox(height: 24),

                  // Rental duration
                  const Text(
                    'Durasi Penyewaan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tanggal Mulai',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${_startDate.day}/${_startDate.month}/${_startDate.year}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.grey,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    'Tanggal Selesai',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${_endDate.day}/${_endDate.month}/${_endDate.year}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        ElevatedButton(
                          onPressed: null, // Disabled
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.grey,
                            side: BorderSide(color: Colors.grey),
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
                          ),
                          child: const Text('Ubah Tanggal'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Delivery option
                  const Text(
                    'Opsi Pengambilan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        _buildStaticDeliveryOption(
                          title: 'Ambil di Toko',
                          subtitle: 'Gratis, ambil langsung di toko kami',
                          icon: Icons.store,
                          isSelected: !_isDeliverySelected,
                        ),
                        const Divider(),
                        _buildStaticDeliveryOption(
                          title: 'Diantar ke Lokasi',
                          subtitle:
                              'Dikenakan biaya pengantaran Rp $_deliveryFee',
                          icon: Icons.local_shipping,
                          isSelected: _isDeliverySelected,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Payment method
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        _buildStaticPaymentOption(
                          method: 'transfer',
                          title: 'Transfer Bank',
                          subtitle: 'BCA, BNI, Mandiri',
                          icon: Icons.account_balance,
                          isSelected: _selectedPaymentMethod == 'transfer',
                        ),
                        const Divider(),
                        _buildStaticPaymentOption(
                          method: 'emoney',
                          title: 'E-Money',
                          subtitle: 'GoPay, OVO, DANA',
                          icon: Icons.account_balance_wallet,
                          isSelected: _selectedPaymentMethod == 'emoney',
                        ),
                        const Divider(),
                        _buildStaticPaymentOption(
                          method: 'cash',
                          title: 'Tunai',
                          subtitle: 'Bayar saat pengambilan',
                          icon: Icons.money,
                          isSelected: _selectedPaymentMethod == 'cash',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Promo code
                  const Text(
                    'Kode Promo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Pilih Kode Promo',
                            border: OutlineInputBorder(),
                          ),
                          value: _selectedPromo,
                          items: [
                            const DropdownMenuItem<String>(
                              value: null,
                              child: Text('Tidak ada promo'),
                            ),
                            ..._promoOptions.map((promo) => DropdownMenuItem<String>(
                                  value: promo,
                                  child: Text('$promo (Diskon 10%)'),
                                )),
                          ],
                          onChanged: null, // Disabled
                        ),
                        if (_selectedPromo != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green[600]),
                                const SizedBox(width: 8),
                                Text(
                                  'Promo $_selectedPromo berhasil digunakan',
                                  style: TextStyle(
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Order summary
                  const Text(
                    'Ringkasan Pesanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      children: [
                        _buildSummaryRow('Subtotal', 'Rp $_subtotal'),
                        if (_selectedPromo != null)
                          _buildSummaryRow('Diskon Promo', '- Rp $_discount', isDiscount: true),
                        if (_isDeliverySelected)
                          _buildSummaryRow('Biaya Pengantaran', 'Rp $_deliveryFee'),
                        const Divider(),
                        _buildSummaryRow(
                          'Total',
                          'Rp $_total',
                          isTotal: true,
                        ),
                        const SizedBox(height: 16),
                        // Deposit info
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.info_outline, color: Colors.orange[800]),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Deposit sebesar Rp ${(_subtotal * 0.3).toInt()} akan dikembalikan setelah barang dikembalikan dalam kondisi baik',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.orange[800],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
      bottomNavigationBar: _cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          'Rp $_total',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: null, // Disabled
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      'Checkout',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Keranjang Anda kosong',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tambahkan item untuk mulai menyewa',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: null, // Disabled
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.withOpacity(0.5),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Jelajahi Produk'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 40, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: null, // Disabled
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${item['price']} / hari',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Jumlah: ', style: TextStyle(fontSize: 14)),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(Icons.remove, size: 16),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  '${item['quantity']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                child: const Icon(Icons.add, size: 16),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rp ${item['price'] * item['quantity'] * item['days']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Durasi sewa: ${item['days']} hari',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaticDeliveryOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.indigo[50] : Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.indigo : Colors.grey[700],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Radio(
          value: isSelected,
          groupValue: true,
          onChanged: null, // Disabled
          activeColor: Colors.indigo,
        ),
      ],
    );
  }

  Widget _buildStaticPaymentOption({
    required String method,
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isSelected,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.indigo[50] : Colors.grey[100],
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.indigo : Colors.grey[700],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        Radio(
          value: true,
          groupValue: isSelected,
          onChanged: null, // Disabled
          activeColor: Colors.indigo,
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 16 : 14,
              color: isDiscount ? Colors.green[700] : null,
            ),
          ),
        ],
      ),
    );
  }
}