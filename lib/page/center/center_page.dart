import 'package:flutter/material.dart';
import 'package:sportition_client/models/centers/center_dto.dart';
import 'package:sportition_client/services/center/center_service.dart';
import 'package:sportition_client/shared/styles/app_colors.dart';

class CenterPage extends StatefulWidget {
  const CenterPage({Key? key}) : super(key: key);

  @override
  _CenterPageState createState() => _CenterPageState();
}

class _CenterPageState extends State<CenterPage> {
  CenterDTO? _centerDTO;

  late Future<void> _initializeCenterDTOFuture;

  @override
  void initState() {
    super.initState();
    _initializeCenterDTOFuture = _initializeCenterDTO();
  }

  Future<void> _initializeCenterDTO() async {
    // CenterDTO를 가져오는 로직을 여기에 추가합니다.
    // 예시로 null을 반환합니다.
    // 실제로는 CenterService를 사용하여 데이터를 가져와야 합니다.
    final centerInfo = await CenterService().getCenterInfo();
    setState(() {
      _centerDTO = centerInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeCenterDTOFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: Text('오류가 발생했습니다.')),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: const Text(
                '센터 정보',
                style: TextStyle(
                  fontSize: 19,
                  fontFamily: 'Notosans',
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: _centerDTO == null
                /* 
                센터 정보가 없는 경우
               */
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '센터 UID를 입력하세요:',
                        style: TextStyle(fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          onSubmitted: (value) {
                            setState(() {
                              _centerDTO = CenterDTO(
                                centerName: '입력된 센터 이름',
                                centerUID: value,
                              );
                            });
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '센터 UID',
                          ),
                        ),
                      ),
                    ],
                  )
                /*
                센터 정보가 있는 경우
                 */
                : Column(
                    children: [
                      Container(
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          _centerDTO!.centerName,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/setting/edit/center',
                          );
                        },
                        child: const Text(
                          '센터 정보 수정',
                          style: TextStyle(
                            color: AppColors.mainRedColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        }
      },
    );
  }
}
