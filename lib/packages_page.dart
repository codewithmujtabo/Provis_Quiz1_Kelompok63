import 'package:flutter/material.dart';

class PackagesPage extends StatelessWidget {
  final String packageName;

  const PackagesPage({Key? key, required this.packageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get package details based on package name
    final packageDetails = _getPackageDetails(packageName);

    return Scaffold(
      appBar: AppBar(
        title: Text(packageName),
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
            // Package image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 80, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Package title and price
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        packageName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        packageDetails['subtitle'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Rp ${packageDetails['price']}',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                      if (packageDetails['originalPrice'] != null)
                        Text(
                          'Rp ${packageDetails['originalPrice']}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Text(
                        'Hemat ${packageDetails['discount']}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Package description
            const Text(
              'Deskripsi Paket',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              packageDetails['description'],
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            
            // Items included
            const Text(
              'Barang yang Termasuk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...packageDetails['items'].map<Widget>((item) => _buildPackageItem(item)).toList(),
            
            const SizedBox(height: 24),
            
            // Benefits
            const Text(
              'Manfaat Paket',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...packageDetails['benefits'].map<Widget>((benefit) => _buildBenefitItem(benefit)).toList(),
            
            const SizedBox(height: 24),
            
            // Terms and conditions
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
                    'Syarat dan Ketentuan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...packageDetails['terms'].map<Widget>((term) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                        Expanded(child: Text(term)),
                      ],
                    ),
                  )).toList(),
                ],
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
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Rp ${packageDetails['price']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // No functionality - just a placeholder button
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
              ),
              child: const Text(
                'Sewa Paket',
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

  Widget _buildPackageItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
              child: Icon(Icons.image, size: 30, color: Colors.grey),
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
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'x${item['quantity']}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitItem(String benefit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.green[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              size: 16,
              color: Colors.green[700],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              benefit,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getPackageDetails(String packageName) {
    // Sample package details based on package name
    switch (packageName) {
      case 'Paket Hemat 1':
        return {
          'subtitle': 'Paket untuk pemula ekonomis',
          'price': 120000,
          'originalPrice': 150000,
          'discount': 20,
          'description': 'Paket ini berisi peralatan dasar yang diperlukan untuk berkemah bagi pemula dengan harga ekonomis. Ideal untuk perjalanan 1-2 hari di area camping yang sudah memiliki fasilitas dasar.',
          'items': [
            {
              'name': 'Tenda 2 orang',
              'description': 'Tenda kapasitas 2 orang, waterproof',
              'quantity': 1,
            },
            {
              'name': 'Sleeping Bag',
              'description': 'Sleeping bag standard, nyaman hingga suhu 15°C',
              'quantity': 2,
            },
            {
              'name': 'Matras',
              'description': 'Matras camping tipis',
              'quantity': 2,
            },
            {
              'name': 'Senter',
              'description': 'Senter LED dengan baterai tahan 8 jam',
              'quantity': 1,
            },
          ],
          'benefits': [
            'Hemat 20% dibanding sewa satuan',
            'Free biaya pengantaran ke lokasi camping populer',
            'Panduan camping untuk pemula',
            'Bantuan setup via video call jika diperlukan',
          ],
          'terms': [
            'Minimal sewa 2 hari, maksimal 7 hari',
            'Deposit sebesar Rp 200.000 dikembalikan setelah semua barang diperiksa dalam kondisi baik',
            'Kerusakan atau kehilangan akan dikenakan biaya sesuai ketentuan',
            'Pembatalan H-1 dikenakan biaya 50% dari total sewa',
          ],
        };
      case 'Paket Promo A':
        return {
          'subtitle': 'Paket lengkap untuk keluarga',
          'price': 250000,
          'originalPrice': 350000,
          'discount': 30,
          'description': 'Paket promo khusus untuk keluarga atau grup yang ingin berkemah dengan kenyamanan lebih. Cocok untuk 4-6 orang dengan perlengkapan lengkap.',
          'items': [
            {
              'name': 'Tenda 6 orang',
              'description': 'Tenda kapasitas 6 orang, waterproof, dengan sekat',
              'quantity': 1,
            },
            {
              'name': 'Sleeping Bag Premium',
              'description': 'Sleeping bag tebal, nyaman hingga suhu 10°C',
              'quantity': 4,
            },
            {
              'name': 'Matras Tebal',
              'description': 'Matras camping nyaman 2.5cm',
              'quantity': 4,
            },
            {
              'name': 'Lampu Camping',
              'description': 'Lampu camping LED rechargeable',
              'quantity': 2,
            },
            {
              'name': 'Kompor Portable',
              'description': 'Kompor camping dengan tabung gas mini',
              'quantity': 1,
            },
            {
              'name': 'Set Peralatan Masak',
              'description': 'Panci, wajan, dan peralatan makan 4 orang',
              'quantity': 1,
            },
          ],
          'benefits': [
            'Hemat 30% dibanding sewa satuan',
            'Free biaya pengantaran ke semua lokasi di dalam kota',
            'Bonus tabung gas mini',
            'Panduan camping lengkap termasuk resep masakan',
            'Termasuk tenda tambahan kecil untuk penyimpanan barang',
          ],
          'terms': [
            'Minimal sewa 2 hari, maksimal 10 hari',
            'Deposit sebesar Rp 500.000 dikembalikan setelah semua barang diperiksa dalam kondisi baik',
            'Kerusakan atau kehilangan akan dikenakan biaya sesuai ketentuan',
            'Pembatalan H-2 dikenakan biaya 50% dari total sewa',
            'Promo berlaku hingga akhir bulan',
          ],
        };
      case 'Paket Lengkap':
        return {
          'subtitle': 'Paket profesional untuk pendaki',
          'price': 450000,
          'originalPrice': 600000,
          'discount': 25,
          'description': 'Paket lengkap untuk pendakian atau camping di area ekstrem dengan perlengkapan kualitas premium. Dirancang untuk pendaki berpengalaman yang membutuhkan peralatan andal.',
          'items': [
            {
              'name': 'Tenda Gunung 4 Season',
              'description': 'Tenda 4 season tahan angin kencang dan hujan lebat',
              'quantity': 1,
            },
            {
              'name': 'Sleeping Bag Ekstrem',
              'description': 'Sleeping bag untuk suhu hingga 0°C',
              'quantity': 2,
            },
            {
              'name': 'Matras Self-Inflating',
              'description': 'Matras tebal self-inflating 5cm',
              'quantity': 2,
            },
            {'name': 'Ransel Carrier 60L',
              'description': 'Ransel carrier profesional kapasitas 60L',
              'quantity': 2,
            },
            {
              'name': 'Sepatu Gunung',
              'description': 'Sepatu waterproof khusus gunung',
              'quantity': 2,
            },
            {
              'name': 'Jaket Gunung',
              'description': 'Jaket waterproof & windproof',
              'quantity': 2,
            },
            {
              'name': 'Peralatan Masak Lengkap',
              'description': 'Set lengkap dengan kompor camping premium',
              'quantity': 1,
            },
            {
              'name': 'GPS Portable',
              'description': 'GPS khusus hiking dengan peta offline',
              'quantity': 1,
            },
          ],
          'benefits': [
            'Hemat 25% dibanding sewa satuan',
            'Free biaya pengantaran ke mana saja',
            'Konsultasi rute pendakian dengan tim profesional',
            'Pelatihan singkat penggunaan peralatan',
            'Panduan survival dan peta detail lokasi',
            'Komunikasi radio darurat',
          ],
          'terms': [
            'Minimal sewa 3 hari, maksimal 14 hari',
            'Deposit sebesar Rp 1.000.000 dikembalikan setelah semua barang diperiksa dalam kondisi baik',
            'Wajib menunjukkan ID dan kontak darurat',
            'Wajib memiliki pengalaman mendaki sebelumnya',
            'Kerusakan atau kehilangan akan dikenakan biaya sesuai ketentuan',
            'Pembatalan H-3 dikenakan biaya 50% dari total sewa',
          ],
        };
      default:
        return {
          'subtitle': 'Paket custom',
          'price': 200000,
          'originalPrice': 250000,
          'discount': 20,
          'description': 'Paket custom dengan berbagai pilihan peralatan camping sesuai kebutuhan Anda.',
          'items': [
            {
              'name': 'Tenda',
              'description': 'Tenda pilihan sesuai kebutuhan',
              'quantity': 1,
            },
            {
              'name': 'Peralatan Tidur',
              'description': 'Sleeping bag dan matras',
              'quantity': 2,
            },
            {
              'name': 'Peralatan Tambahan',
              'description': 'Sesuai kebutuhan',
              'quantity': 1,
            },
          ],
          'benefits': [
            'Hemat 20% dibanding sewa satuan',
            'Fleksibel sesuai kebutuhan',
            'Konsultasi paket gratis',
          ],
          'terms': [
            'Minimal sewa 2 hari',
            'Deposit disesuaikan dengan nilai peralatan',
            'Syarat dan ketentuan lainnya berlaku',
          ],
        };
    }
  }
}