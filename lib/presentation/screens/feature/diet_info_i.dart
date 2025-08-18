import 'package:flutter/material.dart';
import 'package:mydiet/presentation/const.dart';

class DietInfoI extends StatefulWidget {
  const DietInfoI({super.key});

  @override
  State<DietInfoI> createState() => _DietInfoIState();
}

class _DietInfoIState extends State<DietInfoI> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Text(
              '식단 기록',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '원하시는 음식을 검색하세요.',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                    ),
                    onChanged: (value) {
                      print("검색어: $value");
                    },
                  ),
                ),

                const SizedBox(width: 8),

                ElevatedButton(
                  onPressed: () {
                    // 검색 실행
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: Const().buildColors()[0], // 버튼 색
                    foregroundColor: Colors.white, // 아이콘 색
                    elevation: 2, // 살짝 그림자
                  ),
                  child: const Icon(Icons.search, size: 24),
                )
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: Text(
                '검색 결과가 여기에 표시됩니다',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
