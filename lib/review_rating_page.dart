import 'package:flutter/material.dart';

class ReviewRatingPage extends StatelessWidget {
  final Map<String, dynamic> item;
  
  const ReviewRatingPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy reviews data
    final List<Map<String, dynamic>> reviews = [
      {
        'name': 'Budi Santoso',
        'role': 'Pendaki Berpengalaman',
        'rating': 5,
        'comment': 'Sangat bagus dan tahan air. Saya sudah menyewa ini beberapa kali dan tidak pernah kecewa.',
        'date': '12 Februari 2025',
        'isHelpful': 24,
      },
      {
        'name': 'Rina Wijaya',
        'role': 'Pemula',
        'rating': 4,
        'comment': 'Pertama kali berkemah dan barang ini sangat membantu. Petugasnya juga menjelaskan cara penggunaan dengan detail.',
        'date': '5 Februari 2025',
        'isHelpful': 17,
      },
      {
        'name': 'Andi Permana',
        'role': 'Pendaki Reguler',
        'rating': 5,
        'comment': 'Kualitas bagus, harga terjangkau. Sangat direkomendasikan untuk siapa saja yang membutuhkan ${item['name']}.',
        'date': '28 Januari 2025',
        'isHelpful': 10,
      },
      {
        'name': 'Dina Pratiwi',
        'role': 'Pemula',
        'rating': 3,
        'comment': 'Cukup bagus, tapi ada sedikit masalah dengan ${item['name']}. Untungnya staff membantu menyelesaikan masalahnya.',
        'date': '15 Januari 2025',
        'isHelpful': 5,
      },
    ];

    // Calculate overall rating statistics
    int totalReviews = reviews.length;
    double averageRating = reviews.map((r) => r['rating'] as int).reduce((a, b) => a + b) / totalReviews;
    
    // Count each rating
    List<int> ratingCounts = List.filled(5, 0);
    for (var review in reviews) {
      ratingCounts[(review['rating'] as int) - 1]++;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ulasan ${item['name']}'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Overall rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < averageRating.floor()
                            ? Icons.star
                            : (index < averageRating)
                                ? Icons.star_half
                                : Icons.star_outline,
                        color: Colors.amber,
                        size: 16,
                      );
                    }),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$totalReviews ulasan',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: List.generate(5, (index) {
                    int ratingValue = 5 - index;
                    double percentage = totalReviews > 0 
                        ? ratingCounts[ratingValue - 1] / totalReviews 
                        : 0;
                    
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Text(
                            '$ratingValue',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(Icons.star, size: 12, color: Colors.amber),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                FractionallySizedBox(
                                  widthFactor: percentage,
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${ratingCounts[ratingValue - 1]}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
          
          const Divider(height: 32),
          
          // Review filters
          Row(
            children: [
              const Text(
                'Filter Ulasan:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              Wrap(
                spacing: 8,
                children: [
                  _buildFilterChip('Semua'),
                  _buildFilterChip('5★', isSelected: true),
                  _buildFilterChip('4★'),
                  _buildFilterChip('3★'),
                  _buildFilterChip('2★'),
                  _buildFilterChip('1★'),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Reviews list
          ...reviews.map((review) => _buildReviewItem(review)).toList(),
        ],
      ),
    );
  }
  
  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontSize: 12,
        ),
      ),
      backgroundColor: isSelected ? Colors.indigo : Colors.grey[200],
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8),
    );
  }
  
  Widget _buildReviewItem(Map<String, dynamic> review) {
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
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Text(
                  review['name'][0],
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6, 
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            review['role'],
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          review['date'],
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < review['rating'] ? Icons.star : Icons.star_outline,
                color: Colors.amber,
                size: 16,
              );
            }),
          ),
          const SizedBox(height: 8),
          Text(
            review['comment'],
            style: const TextStyle(height: 1.5),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.thumb_up_outlined, size: 16, color: Colors.grey[600]),
              const SizedBox(width: 4),
              Text(
                '${review['isHelpful']} orang menganggap ini membantu',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}