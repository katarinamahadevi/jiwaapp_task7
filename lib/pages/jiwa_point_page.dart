import 'package:flutter/material.dart';

class JiwaPointPage extends StatefulWidget {
  const JiwaPointPage({Key? key}) : super(key: key);

  @override
  _JiwaPointPageState createState() => _JiwaPointPageState();
}

class _JiwaPointPageState extends State<JiwaPointPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
      backgroundColor: Colors.red[400],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
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
                  // TabBar
                  TabBar(
                    controller: _tabController,
                    labelColor: Colors.red[400],
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(text: 'Point Didapat'),
                      Tab(text: 'Point Terpakai'),
                    ],
                  ),
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          Text(
            'Total Jiwa Point Saat Ini',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '694',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '694 Jiwa Point akan hangus pada 28 Februari 2026',
              style: TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointHistoryList({required bool isEarned}) {
    // Sample point history data
    final earnedPointHistory = [
      {
        'date': '26 Feb 2025 | 15:18',
        'description':
            'Bonus Jiwa Point dari Transaksi # J +20251261740549300001',
        'points': '+694 Jiwa Point',
        'validUntil': 'berlaku hingga 28 Feb 2026',
      },
      {
        'date': '15 Feb 2025 | 00:00',
        'description':
            'Bonus Jiwa Point dari Transaksi # J +20251141735185983Z6',
        'points': '+2.955 Jiwa Point',
        'validUntil': 'berlaku hingga 28 Feb 2026',
      },
    ];

    final usedPointHistory = [
      {
        'date': '10 Jan 2025 | 14:30',
        'description': 'Penggunaan Jiwa Point untuk Transaksi',
        'points': '-500 Jiwa Point',
        'validUntil': 'Telah digunakan',
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
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item['date']!,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              SizedBox(height: 4),
              Text(
                item['description']!,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Text(
                item['points']!,
                style: TextStyle(
                  color: isEarned ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                item['validUntil']!,
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }
}
