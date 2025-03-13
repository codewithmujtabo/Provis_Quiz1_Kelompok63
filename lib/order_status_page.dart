import 'package:flutter/material.dart';

class OrderStatusPage extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderStatusPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan ${order['id']}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status card
            _buildStatusCard(context),
            const SizedBox(height: 24),
            
            // Order details
            const Text(
              'Detail Pesanan',
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
                  _buildDetailRow('No. Pesanan', order['id']),
                  const Divider(height: 24),
                  _buildDetailRow('Tanggal Pesan', order['date']),
                  if (order['returnDate'] != null) ...[
                    const SizedBox(height: 8),
                    _buildDetailRow('Tanggal Kembali', order['returnDate']),
                  ],
                  const Divider(height: 24),
                  _buildDetailRow('Status', order['status'], isHighlighted: true),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Items
            const Text(
              'Barang yang Disewa',
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
                  ...List.generate(
                    order['items'].length,
                    (index) => Padding(
                      padding: EdgeInsets.only(
                          bottom: index < order['items'].length - 1 ? 12 : 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(
                              child: Icon(Icons.inventory_2_outlined, size: 20),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(order['items'][index]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Rp ${order['total']}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[700],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Payment details if not paid yet
            if (order['statusCode'] == 0) _buildPaymentInstructions(context),
            
            // Pickup information if ready
            if (order['statusCode'] == 2) _buildPickupInstructions(context),
            
            const SizedBox(height: 24),
            
            // Help section
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
                      Icon(Icons.help_outline, color: Colors.blue[700]),
                      const SizedBox(width: 8),
                      Text(
                        'Butuh Bantuan?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Jika Anda memiliki pertanyaan atau masalah dengan pesanan ini, silakan hubungi tim dukungan kami.',
                    style: TextStyle(color: Colors.blue[700]),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // Navigate to chat page
                    },
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('Chat dengan Admin'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.blue[700],
                      side: BorderSide(color: Colors.blue[700]!),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: order['statusCode'] == 0
          ? Container(
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
              child: ElevatedButton(
                onPressed: () {
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  backgroundColor: Colors.orange,
                ),
                child: const Text(
                  'Bayar Sekarang',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildStatusCard(BuildContext context) {
    // Determine colors and icons based on status
    IconData statusIcon;
    Color statusColor;
    List<bool> steps;
    
    switch (order['statusCode']) {
      case 0:
        statusIcon = Icons.payment;
        statusColor = Colors.orange;
        steps = [false, false, false, false];
        break;
      case 1:
        statusIcon = Icons.inventory;
        statusColor = Colors.blue;
        steps = [true, false, false, false];
        break;
      case 2:
        statusIcon = Icons.inventory_2;
        statusColor = Colors.green;
        steps = [true, true, false, false];
        break;
      case 3:
        statusIcon = Icons.access_time;
        statusColor = Colors.purple;
        steps = [true, true, true, false];
        break;
      default:
        statusIcon = Icons.check_circle;
        statusColor = Colors.grey;
        steps = [true, true, true, true];
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(statusIcon, color: statusColor, size: 36),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['status'],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: statusColor,
                      ),
                    ),
                    Text(
                      _getStatusDescription(),
                      style: TextStyle(
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatusStep('Bayar', steps[0]),
              _buildStatusLine(steps[0] && steps[1]),
              _buildStatusStep('Proses', steps[1]),
              _buildStatusLine(steps[1] && steps[2]),
              _buildStatusStep('Ambil', steps[2]),
              _buildStatusLine(steps[2] && steps[3]),
              _buildStatusStep('Kembali', steps[3]),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusStep(String label, bool isCompleted) {
    return Column(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isCompleted ? Colors.green : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            isCompleted ? Icons.check : Icons.circle,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isCompleted ? Colors.green : Colors.grey,
            fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusLine(bool isActive) {
    return Expanded(
      child: Container(
        height: 2,
        color: isActive ? Colors.green : Colors.grey[300],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isHighlighted = false}) {
    Color textColor = isHighlighted ? _getStatusColor() : Colors.black;
    
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
            style: TextStyle(
              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentInstructions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Instruksi Pembayaran',
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
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orange[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.account_balance, color: Colors.orange[700]),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Transfer Bank',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              _buildBankAccount('BCA', '1234567890', 'PT Rental Camping', context),
              const SizedBox(height: 16),
              _buildBankAccount('Mandiri', '0987654321', 'PT Rental Camping', context),
              const Divider(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Rp ${order['total']}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                    },
                    icon: const Icon(Icons.copy),
                    tooltip: 'Salin jumlah',
                  ),
                ],
              ),
              const Divider(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.red[700], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Batas Waktu Pembayaran',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red[700],
                            ),
                          ),
                          Text(
                            '24 jam (berakhir 15 Mar 2025, 10:00 WIB)',
                            style: TextStyle(color: Colors.red[700]),
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
      ],
    );
  }

  Widget _buildBankAccount(String bank, String accountNumber, String accountName, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                bank,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(accountNumber),
              Text(
                accountName,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.orange,
            side: BorderSide(color: Colors.orange),
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: const Text('Salin'),
        ),
      ],
    );
  }

  Widget _buildPickupInstructions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Pengambilan',
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.store, color: Colors.green[700]),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Toko Rental Camping',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Jl. Outdoor No. 123, Kota Adventure',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Buka: Senin - Minggu, 08.00 - 20.00 WIB',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.qr_code, color: Colors.green[700]),
                        const SizedBox(width: 8),
                        Text(
                          'Kode Pengambilan: ${order['id'].substring(4)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Tunjukkan kode ini saat mengambil barang di toko kami',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.green[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {
                },
                icon: const Icon(Icons.map),
                label: const Text('Lihat Lokasi di Peta'),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size.fromHeight(45),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getStatusDescription() {
    switch (order['statusCode']) {
      case 0:
        return 'Silakan selesaikan pembayaran';
      case 1:
        return 'Pesanan Anda sedang diproses';
      case 2:
        return 'Pesanan siap untuk diambil';
      case 3:
        return 'Barang sedang digunakan';
      default:
        return 'Transaksi selesai';
    }
  }

  Color _getStatusColor() {
    switch (order['statusCode']) {
      case 0:
        return Colors.orange;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.green;
      case 3:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}