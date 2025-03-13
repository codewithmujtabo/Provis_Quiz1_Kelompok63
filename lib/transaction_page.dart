import 'package:flutter/material.dart';
import 'order_status_page.dart';
import 'return_page.dart';

class TransactionPage extends StatefulWidget {
  final bool showSuccessMessage;
  
  const TransactionPage({
    Key? key, 
    this.showSuccessMessage = false,
  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<Map<String, dynamic>> _activeOrders = [
    {
      'id': 'ORD-12345',
      'date': '14 Mar 2025',
      'items': [
        'Tenda 8 orang x1',
        'Matras x2',
      ],
      'total': 120000,
      'status': 'Menunggu Pembayaran',
      'statusCode': 0, // 0: waiting payment, 1: processed, 2: ready for pickup, 3: in use, 4: completed
    },
    {
      'id': 'ORD-12346',
      'date': '10 Mar 2025',
      'items': [
        'Paket Hemat 1',
      ],
      'total': 120000,
      'status': 'Sedang Diproses',
      'statusCode': 1,
    },
    {
      'id': 'ORD-12340',
      'date': '8 Mar 2025',
      'items': [
        'Kompor Portable x1',
        'Tabung Gas Mini x2',
        'Panci Set x1',
      ],
      'total': 75000,
      'status': 'Siap Diambil',
      'statusCode': 2,
    },
    {
      'id': 'ORD-12335',
      'date': '5 Mar 2025',
      'items': [
        'Sleeping Bag x2',
        'Senter LED x1',
      ],
      'total': 105000,
      'status': 'Sedang Digunakan',
      'statusCode': 3,
      'returnDate': '15 Mar 2025',
    },
  ];
  
  final List<Map<String, dynamic>> _historyOrders = [
    {
      'id': 'ORD-12300',
      'date': '20 Feb 2025',
      'returnDate': '24 Feb 2025',
      'items': [
        'Tenda 4 orang x1',
        'Sleeping Bag x2',
      ],
      'total': 110000,
      'status': 'Selesai',
      'statusCode': 4,
      'rating': 5,
    },
    {
      'id': 'ORD-12290',
      'date': '10 Feb 2025',
      'returnDate': '13 Feb 2025',
      'items': [
        'Paket Lengkap',
      ],
      'total': 450000,
      'status': 'Selesai',
      'statusCode': 4,
      'rating': 4,
    },
    {
      'id': 'ORD-12280',
      'date': '2 Feb 2025',
      'returnDate': '5 Feb 2025',
      'items': [
        'Sepatu Gunung x2',
        'Jaket x2',
      ],
      'total': 120000,
      'status': 'Selesai',
      'statusCode': 4,
      'rating': 5,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Show success message if needed
    if (widget.showSuccessMessage) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showSuccessDialog();
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: 16),
              const Text(
                'Pesanan Berhasil!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Pesanan Anda telah berhasil dibuat. Silakan lakukan pembayaran untuk melanjutkan proses.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                child: const Text('Lihat Detail Pesanan'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaksi Saya'),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.indigo,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.indigo,
          tabs: const [
            Tab(text: 'Aktif'),
            Tab(text: 'Riwayat'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Active orders tab
          _activeOrders.isEmpty
              ? _buildEmptyState('Belum ada pesanan aktif')
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _activeOrders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(_activeOrders[index], isActive: true);
                  },
                ),
          
          // History orders tab
          _historyOrders.isEmpty
              ? _buildEmptyState('Belum ada riwayat pesanan')
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _historyOrders.length,
                  itemBuilder: (context, index) {
                    return _buildOrderCard(_historyOrders[index], isActive: false);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pesanan Anda akan muncul di sini',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order, {required bool isActive}) {
    // Determine card color based on status
    Color statusColor;
    switch (order['statusCode']) {
      case 0:
        statusColor = Colors.orange;
        break;
      case 1:
        statusColor = Colors.blue;
        break;
      case 2:
        statusColor = Colors.green;
        break;
      case 3:
        statusColor = Colors.purple;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          if (isActive) {
            if (order['statusCode'] == 3) {
              // For items in use, navigate to return page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReturnPage(order: order),
                ),
              );
            } else {
              // For other active orders, navigate to order status page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderStatusPage(order: order),
                ),
              );
            }
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order['id'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      order['status'],
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Order date
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    'Tanggal Order: ${order['date']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              
              // Return date if applicable
              if (order['returnDate'] != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Icon(
                        Icons.event_repeat,
                        size: 14,
                        color: order['statusCode'] == 3
                            ? Colors.red[600]
                            : Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Tanggal Kembali: ${order['returnDate']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: order['statusCode'] == 3
                              ? Colors.red[600]
                              : Colors.grey[600],
                          fontWeight: order['statusCode'] == 3
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              
              const Divider(height: 24),
              
              // Items
              ...order['items'].map<Widget>((item) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 14),
                ),
              )),
              
              const SizedBox(height: 12),
              
              // Total
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total Pembayaran',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Rp ${order['total']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo[700],
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 12),
              
              // Action buttons
              if (isActive)
                Row(
                  children: [
                    if (order['statusCode'] == 0)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Show payment instructions
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Menampilkan instruksi pembayaran'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Bayar Sekarang'),
                        ),
                      ),
                    if (order['statusCode'] == 2)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Show pickup instructions
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Menampilkan instruksi pengambilan'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Ambil Barang'),
                        ),
                      ),
                    if (order['statusCode'] == 3)
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to return page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ReturnPage(order: order),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Proses Pengembalian'),
                        ),
                      ),
                  ],
                ),
              
              // Rating for completed orders
              if (!isActive && order['rating'] != null)
                Row(
                  children: [
                    const Text('Rating: '),
                    ...List.generate(
                      5,
                      (index) => Icon(
                        index < order['rating'] ? Icons.star : Icons.star_border,
                        size: 16,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}