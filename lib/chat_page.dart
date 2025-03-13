import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy messages statis
    final List<Map<String, dynamic>> messages = [
      {
        'text': 'Halo! Ada yang bisa kami bantu?',
        'isMe': false,
        'time': '10:30',
      },
      {
        'text': 'Saya baru pertama kali berkemah. Apa saja yang perlu saya sewa?',
        'isMe': true,
        'time': '10:31',
      },
      {
        'text': 'Untuk pemula, kami sarankan menyewa paket hemat 1 yang berisi tenda, sleeping bag, matras, dan lampu. Mau saya jelaskan lebih detail?',
        'isMe': false,
        'time': '10:33',
      },
      {
        'text': 'Ya, tolong jelaskan lebih detail tentang paket hemat 1',
        'isMe': true,
        'time': '10:34',
      },
      {
        'text': 'Paket Hemat 1 berisi:\n- Tenda 2 orang\n- 2 Sleeping bag standard\n- 2 Matras camping\n- 1 Lampu camping\n\nTotal harga Rp 120.000 untuk 3 hari, sudah termasuk deposit. Deposit akan dikembalikan saat pengembalian barang dalam kondisi baik.',
        'isMe': false,
        'time': '10:36',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFF8B7355), // Earth brown
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(Icons.support_agent, color: Colors.white),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Admin',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: const Color(0xFFFF8C00), // Sea green untuk online status
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Ikon telepon yang tidak bisa diklik
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: null, // null berarti tidak bisa diklik
            color: Colors.white, // Warna abu-abu untuk menunjukkan disabled
          ),
        ],
      ),
      body: Column(
        children: [
          // Helpful tips
          Container(
            padding: const EdgeInsets.all(12),
            color: const Color(0xFFF5F5DC), // Beige earth tone
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: Color(0xFF8B7355), size: 20), // Earth brown
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Tips: Baru pertama kali berkemah? Tanyakan rekomendasi perlengkapan untuk pemula.',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF5D4037), // Dark brown
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                
                return Column(
                  children: [
                    if (index == 0 || index == 3)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          index == 0 ? 'Hari ini, 10:30' : 'Hari ini, 10:34',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    _buildMessageItem(message),
                  ],
                );
              },
            ),
          ),
          
          // Input area statis
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(132, 158, 158, 158),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: Row(
              children: [
                // Ikon kamera yang tidak bisa diklik
                IconButton(
                  icon: const Icon(Icons.photo_camera),
                  color: Colors.grey[400], // Warna abu-abu untuk disabled
                  onPressed: null, // null berarti tidak bisa diklik
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECDCC2), // Light earth tone
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Ketik pesan...',
                      style: TextStyle(
                        color: Color(0xFF8B7355), // Earth brown
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                // Ikon kirim yang tidak bisa diklik
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.grey[400], // Warna abu-abu untuk disabled
                  onPressed: null, // null berarti tidak bisa diklik
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(Map<String, dynamic> message) {
    final isMe = message['isMe'] as bool;
    
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        constraints: const BoxConstraints(
          maxWidth: 280, // Membatasi lebar maksimum
        ),
                  decoration: BoxDecoration(
          color: isMe ? const Color(0xFFFF8C00).withAlpha(30) : const Color(0xFFECDCC2), // Light orange for user : Light earth tone for admin
          borderRadius: BorderRadius.circular(16).copyWith(
            bottomLeft: isMe ? const Radius.circular(16) : const Radius.circular(0),
            bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(16),
          ),
        ),
        child: Text(
          message['text'],
          style: TextStyle(
            color: isMe ? const Color(0xFFFF8C00) : const Color(0xFF5D4037), // Dark orange : Dark brown
          ),
        ),
      ),
    );
  }
}