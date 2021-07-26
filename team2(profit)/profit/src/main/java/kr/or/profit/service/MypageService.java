package kr.or.profit.service;

import java.util.List;
import java.util.Map;

import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.BuyLessonPayVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.ProcessVO;

public interface MypageService {
	
	//회원기본정보조회
	public List<Map<String, String>> selectMemberInfo(String memberId) throws Exception;
	
	//프로세스정보추가
	public int insertProcess(ProcessVO vo) throws Exception;
	
	//파일 추가
	public int insertProcessFile(Map map) throws Exception;
	
	
	
	//민선 
	//회원 모든 정보 select
	public MemberVO selectAllMemberInfo(String memberId) throws Exception;
	//내정보 수정
	public void updateMemberInfo(MemberVO vo) throws Exception;
	
	
	public int updateOnlyInfo(MemberVO vo) throws Exception;
	
	public ProcessVO selectProcessInfo(String memberId) throws Exception;
	
	
	public List<?> selectFileInfo(String fileSeq) throws Exception;
	
	public int checkApplyPage(String memberId) throws Exception;
	
	//북마크
	public List<Map<String, String>> selectBookmarkList(Criteria cri) throws Exception;
	
	//페이징용 북마크 전체 개수
	public int selectBookmarkCnt(Criteria cri) throws Exception;

	
	
	
	
	
	//민정
	//회원이 구매한 강의 list
	public List<?> myBuyLessonList(Criteria cri) throws Exception;
	
	//페이징용 구매강의 개수
	public int selectbuyLessonCnt(Criteria cri) throws Exception;

	//마이페이지 결제상세
	public Map<String, Object> selectMyLessonPayDetail(BuyLessonPayVO vo) throws Exception;

	//마이페이지 환불가능 체킹
	public int selectcheckRefundFlag(Map<String, Object> refundMap) throws Exception;
	
	//마이페이지 환불여부 변경
	public int updBuyLessonRefundFlag(Map<String, Object> refundFlagMap) throws Exception;
	
	//이용권 구매목록
	public List<Map<String, Object>> selectBuyTicketList(Criteria cri) throws Exception;
	
	//전체 글 개수 세팅
	public int selectBuyTicketCnt(Criteria cri) throws Exception;
	
	//이용권 사용목록
	public List<Map<String, Object>> selectUseTicketList(Criteria cri) throws Exception;
	
	//전체 글 개수 세팅
	public int selectUseTicketCnt(Criteria cri) throws Exception;



	
}
