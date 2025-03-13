import 'package:flutter/material.dart';

class ReturnPage extends StatefulWidget {
  final Map<String, dynamic> order;

  const ReturnPage({Key? key, required this.order}) : super(key: key);

  @override
  State<ReturnPage> createState() => _ReturnPageState();
}

class _ReturnPageState extends State<ReturnPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isProcessing = false;
  List<String> _selectedReturnMethods = ['store']; // Default to store return
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _notesController = TextEditingController();
  
  // Create list of items with condition status
  late List<Map<String, dynamic>> _items;
  
  @override
  void initState() {
    super.initState();
    
    // Initialize items with default condition (good)
    _items = List.generate(
      widget.order['items'].length,
      (index) => {
        'name': widget.order['items'][index],
        'condition': 'good', // Options: good, damaged, lost
        'notes': '',
      },
    );
  }
  
  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengembalian Barang'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Info card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.info_outline, color: Colors.blue[800]),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pesanan ${widget.order['id']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            Text(
                              'Tanggal Kembali: ${widget.order['returnDate']}',
                              style: TextStyle(
                                color: Colors.blue[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 24),
                  Text(
                    'Pastikan semua barang dikembalikan dalam kondisi baik untuk mendapatkan pengembalian deposit sepenuhnya. Kerusakan atau kehilangan akan mempengaruhi jumlah deposit yang dikembalikan.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blue[800],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Item conditions
            const Text(
              'Kondisi Barang',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Silakan laporkan kondisi setiap barang yang akan dikembalikan',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            
            ...List.generate(
              _items.length,
              (index) => _buildItemCondition(index),
            ),
            
            const SizedBox(height: 24),
            
            // Return method
            const Text(
              'Metode Pengembalian',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildReturnMethod(
              'store',
              'Kembali ke Toko',
              'Kembalikan langsung ke toko kami',
              Icons.store,
            ),
            
            _buildReturnMethod(
              'pickup',
              'Dijemput',
              'Staf kami akan menjemput di lokasi Anda (+Rp 20.000)',
              Icons.local_shipping,
            ),
            
            const SizedBox(height: 24),
            
            // Return date if pickup is selected
            if (_selectedReturnMethods.contains('pickup')) ...[
              const Text(
                'Tanggal Penjemputan',
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
                          child: Text(
                            '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: null, // Functionality removed
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.indigo,
                            side: BorderSide(color: Colors.indigo),
                          ),
                          child: const Text('Pilih Tanggal'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Penjemputan dilakukan pada rentang waktu 09.00 - 18.00 WIB',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 24),
            ],
            
            // Additional notes
            const Text(
              'Catatan Tambahan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: 'Tambahkan informasi penting terkait pengembalian (opsional)',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
                enabled: false, // Disable input
              ),
            ),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
          onPressed: null, // Functionality removed
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: _isProcessing
              ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text('Memproses...'),
                  ],
                )
              : const Text(
                  'Ajukan Pengembalian',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildItemCondition(int index) {
    final item = _items[index];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item['name'],
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Kondisi Barang',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: _buildConditionOption(
                  index,
                  'good',
                  'Baik',
                  Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildConditionOption(
                  index,
                  'damaged',
                  'Rusak',
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildConditionOption(
                  index,
                  'lost',
                  'Hilang',
                  Colors.red,
                ),
              ),
            ],
          ),
          
          if (item['condition'] != 'good') ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: TextFormField(
                initialValue: item['notes'],
                onChanged: null, // Functionality removed
                maxLines: 2,
                decoration: const InputDecoration(
                  hintText: 'Jelaskan kondisi atau kerusakan',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
                enabled: false, // Disable input
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item['condition'] == 'damaged'
                  ? 'Catatan: Barang rusak akan dikenakan biaya perbaikan'
                  : 'Catatan: Barang hilang akan dikenakan biaya penggantian',
              style: TextStyle(
                fontSize: 12,
                color: item['condition'] == 'damaged'
                    ? Colors.orange[700]
                    : Colors.red[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConditionOption(
    int index,
    String value,
    String label,
    Color color,
  ) {
    final isSelected = _items[index]['condition'] == value;
    
    return InkWell(
      onTap: null, // Functionality removed
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.1) : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: isSelected ? color : Colors.grey,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReturnMethod(
    String value,
    String title,
    String subtitle,
    IconData icon,
  ) {
    final isSelected = _selectedReturnMethods.contains(value);
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Colors.indigo : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: null, // Functionality removed
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.indigo[50] : Colors.grey[100],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSelected ? Colors.indigo : Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.indigo : Colors.black,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Radio(
                value: true,
                groupValue: isSelected,
                onChanged: null, // Functionality removed
                activeColor: Colors.indigo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}