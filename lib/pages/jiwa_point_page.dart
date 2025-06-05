import 'package:flutter/material.dart';
import 'package:jiwaapp_task7/theme/color.dart';

//HISTORI JIWA POINT

class JiwaPointPage extends StatefulWidget {
  const JiwaPointPage({Key? key}) : super(key: key);

  @override
  _JiwaPointPageState createState() => _JiwaPointPageState();
}

class _JiwaPointPageState extends State<JiwaPointPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLeftSelected = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BaseColors.primary,
      appBar: AppBar(
        backgroundColor: BaseColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Histori Jiwa Point',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          _buildTotalPointSection(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    margin: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Stack(
                      children: [
                        AnimatedAlign(
                          alignment:
                              isLeftSelected
                                  ? Alignment.centerLeft
                                  : Alignment.centerRight,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2 - 24,
                            decoration: BoxDecoration(
                              color: BaseColors.primary,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLeftSelected = true;
                                    _tabController.animateTo(0);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Point Didapat',
                                    style: TextStyle(
                                      color:
                                          isLeftSelected
                                              ? Colors.white
                                              : Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isLeftSelected = false;
                                    _tabController.animateTo(1);
                                  });
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Point Terpakai',
                                    style: TextStyle(
                                      color:
                                          isLeftSelected
                                              ? Colors.black
                                              : Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(color: BaseColors.border, thickness: 3),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildPointHistoryList(isEarned: true),
                        _buildPointHistoryList(isEarned: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalPointSection() {
    return Container(
      color: BaseColors.primary,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total Jiwa Point Saat ini',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/image_point.png',
                width: 35,
                height: 35,
              ),
              SizedBox(width: 8),
              Text(
                '694',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: BaseColors.blueContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF0058AA)),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '694 Jiwa Point akan hangus pada 28 Februari 2026',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointHistoryList({required bool isEarned}) {
    final earnedPointHistory = [
      {
        'date': '26 Feb 2025 | 15:18',
        'description': 'Bonus Jiwa Point dari Transaksi #',
        'transactionId': 'J+20251261740549300001',
        'points': '+694 Jiwa Point',
        'validUntil': '28 Feb 2026',
      },
      {
        'date': '15 Feb 2025 | 00:00',
        'description': 'Bonus Jiwa Point dari Transaksi #',
        'transactionId': 'J+20251141735185983Z6',
        'points': '+2.955 Jiwa Point',
        'validUntil': '28 Feb 2026',
      },
      {
        'date': '26 Feb 2025 | 15:18',
        'description': 'Bonus Jiwa Point dari Transaksi #',
        'transactionId': 'J+20251261740549300001',
        'points': '+694 Jiwa Point',
        'validUntil': '28 Feb 2026',
      },
      {
        'date': '26 Feb 2025 | 15:18',
        'description': 'Bonus Jiwa Point dari Transaksi #',
        'transactionId': 'J+20251261740549300001',
        'points': '+694 Jiwa Point',
        'validUntil': '28 Feb 2026',
      },
      {
        'date': '26 Feb 2025 | 15:18',
        'description': 'Bonus Jiwa Point dari Transaksi #',
        'transactionId': 'J+20251261740549300001',
        'points': '+694 Jiwa Point',
        'validUntil': '28 Feb 2026',
      },
      {
        'date': '26 Feb 2025 | 15:18',
        'description': 'Bonus Jiwa Point dari Transaksi #',
        'transactionId': 'J+20251261740549300001',
        'points': '+694 Jiwa Point',
        'validUntil': '28 Feb 2026',
      },
    ];

    final usedPointHistory = [
      {
        'date': '10 Jan 2025 | 14:30',
        'description': 'Penggunaan Transaksi #J+20251261740549300001',
        'points': '-500 Jiwa Point',
        'validUntil': '',
      },
      {
        'date': '10 Jan 2025 | 14:30',
        'description': 'Penggunaan Transaksi #J+20251261740549300001',
        'points': '-500 Jiwa Point',
        'validUntil': '',
      },
      {
        'date': '10 Jan 2025 | 14:30',
        'description': 'Penggunaan Transaksi #J+20251261740549300001',
        'points': '-500 Jiwa Point',
        'validUntil': '',
      },
      {
        'date': '10 Jan 2025 | 14:30',
        'description': 'Penggunaan Transaksi #J+20251261740549300001',
        'points': '-500 Jiwa Point',
        'validUntil': '',
      },
    ];

    final pointHistory = isEarned ? earnedPointHistory : usedPointHistory;

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: pointHistory.length,
      separatorBuilder: (context, index) => Divider(color: Colors.grey[300]),
      itemBuilder: (context, index) {
        final item = pointHistory[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => OrderDetailPage()),
              // );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['date']!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Text(
                      item['points']!,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                isEarned
                    ? Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: item['description']! + ' ',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          TextSpan(
                            text: item['transactionId']!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                    : Text(
                      item['description']!,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                SizedBox(height: 4),
                Text(
                  isEarned
                      ? 'berlaku hingga ${item['validUntil']}'
                      : item['validUntil']!,
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
