package kr.or.profit.mapper;

import java.util.List;
import java.util.Map;

import org.antlr.grammar.v3.ANTLRParser.throwsSpec_return;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.ProcessVO;

@Mapper("trainerPageMapper")
public interface TrainerPageMapper {

	//상담 정산 리스트 조회
	List<Map<String, Object>> selectChatAccountList(Criteria cri) throws Exception;
	
	//상담 정산 목록 전체 글 개수 조회
	int selectChatCnt(Criteria cri) throws Exception;
	
	//이용권 정산 차트
	Map<String, Object> selectChartInfo(String memberId) throws Exception;
	
	//온라인 클래스 정산 리스트 조회
	List<Map<String, Object>> selectClassAccountList(Criteria cri) throws Exception;
	
	//온라인클래스 정산 목록 전체 글 개수 조회
	int selectClassCnt(Criteria cri) throws Exception;
	
	//이용권 정산 차트
	Map<String, Object> selectChart2Info(String memberId) throws Exception;

	//트레이너 자신의 클래스 목록 조회
	List<Map<String, Object>> selectTrainerClassList(Criteria cri) throws Exception;
	
	//트레이너 자신의 클래스 목록 글 전체 개수
	int selectTrainerClassCnt(Criteria cri) throws Exception;
	
	//upUserId가 관리자인지 알아보기
	Map<String, Object> selectAdminFlag(String upUserId) throws Exception;
	
	//강의 공개 상태 바꾸기
	int updateLessonPrivate(LessonVO vo) throws Exception;
	
	//구매 많은 순 차트 정보 (남자)
	List<Map<String,Object>> selectBestClassMaleInfo(String memberId) throws Exception;
	
	//구매 많은 순 차트 정보 (여자)
	List<Map<String,Object>> selectBestClassFemaleInfo(String memberId) throws Exception;
	
	//이름 가져오기
	Map<String, Object> selectTrainer(String memberId) throws Exception;
	
	//총 정산 정보 목록 가져오기
	List<Map<String, Object>> selectAccountList(Map<String, Object> info) throws Exception;
	
	//나머지 정보 가져오기
	Map<String, Object> selectRemainInfo(Map<String, Object> info) throws Exception;
	
	//내 정보 가져오기
	Map<String, Object> selectMyInfo(String memberId) throws Exception;
	
	//내정보 수정
	int updateMyInfo(ProcessVO vo) throws Exception;
	
}
