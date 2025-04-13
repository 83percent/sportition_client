import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:sportition_client/exception/join_exception.dart';
import 'package:sportition_client/models/clients/join_dto.dart';
import 'package:sportition_client/page/common/alert_component.dart';
import 'package:sportition_client/page/join/step/join_step3.dart';
import 'package:sportition_client/page/join/step/join_step2.dart';
import 'package:sportition_client/page/join/step/join_step1.dart';
import 'package:sportition_client/page/join/step/join_step_complete.dart';
import 'package:sportition_client/services/join/join_service.dart';

class JoinPage extends StatefulWidget {
  const JoinPage({Key? key}) : super(key: key);

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  static final Logger _logger = Logger('LoginService');
  late JoinService _joinService;
  late JoinDTO _joinDTO;

  String alertMessage = '';
  int pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _joinService = JoinService();
    _joinDTO = JoinDTO();
  }

  /* Step간 이동 */
  void _onPageIndexChanged(int newIndex) {
    setState(() {
      _logger.log(Level.ALL, 'joinDTO: $_joinDTO');
      pageIndex = newIndex;
    });
  }

  Future<void> _join() async {
    try {
      await _joinService.join(_joinDTO);
      // 회원가입 완료 페이지로 이동
      _onPageIndexChanged(99);
    } on JoinException catch (e) {
      _logger.log(Level.ALL, e.getMessage());
      // message alert 처리
      setState(() {
        alertMessage = e.getMessage();
      });
    } on Exception catch (e) {
      _logger.log(Level.ALL, e.toString());
      setState(() {
        alertMessage = '회원 가입에 실패하였습니다. 잠시 후 다시 시도해주세요.';
      });
    }
  }

  Widget _getStepPage() {
    switch (pageIndex) {
      /* 이메일 입력 */
      case 1:
        return JoinStep1(
          onPageIndexChanged: _onPageIndexChanged,
          joinDTO: _joinDTO,
        );
      /* 비밀번호 입력 */
      case 2:
        return JoinStep2(
          onPageIndexChanged: _onPageIndexChanged,
          joinDTO: _joinDTO,
        );
      /* 사용자 이름 입력 */
      case 3:
        return JoinStep3(
          joinDTO: _joinDTO,
          join: _join, // join 메서드 전달
        );
      /* 회원가입 완료 */
      case 99:
        return const JoinStepComplete();
      default:
        return JoinStep1(
          onPageIndexChanged: _onPageIndexChanged,
          joinDTO: _joinDTO,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              _getStepPage(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AlertComponent(message: alertMessage),
          ),
        ],
      ),
    );
  }
}
