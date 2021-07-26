package kr.or.profit.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.BuyLessonPayVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.ProcessVO;

//Mapper Interface => 메서드명과 쿼리ID를 매핑하여 쿼리호출

@Mapper("mypageMapper")
public interface MypageMapper {
	//회원기본정보조회
	public List<Map<String, String>> selectMemberInfo(String memberId);
	
	//프로세스정보추가
	public int insertProcess(ProcessVO vo);
	
	//파일추가
	public int insertProcessFile(Map map);
	
	
	
	
	
	//민선
	//회원 모든 정보 select
	public MemberVO selectAllMemberInfo(String memberId);
	
	public void updateMemberInfo(MemberVO vo);
	
	public int updateOnlyInfo(MemberVO vo);
	
	public ProcessVO selectProcessInfo(String memberId);
	
	public List<?> selectFileInfo(String fileSeq);
	
	public int checkApplyPage(String memberId);
	
	//북마크 리스트
	public List<Map<String, String>> selectBookmarkList(Criteria cri);
	
	public int selectBookmarkCnt(Criteria cri);

	
	//민정
	//회원이 구매한 강의 list
	public List<?> myBuyLessonList(Criteria cri) throws Exception;
	
	//구매강의 개수
	public int selectbuyLessonCnt(Criteria cri) throws Exception;

	//마이페이지 결제상세
	public Map<String, Object> selectMyLessonPayDetail(BuyLessonPayVO vo) throws Exception;

	//마이페이지 환불가능여부 체킹
	public int selectcheckRefundFlag(Map<String, Object> refundMap) throws Exception;

	//마이페이지 환불여부 변경
	public int updBuyLessonRefundFlag(Map<String, Object> refundFlagMap) throws Exception;
	
	//이용권 구매목록
	public List<Map<String, Object>> selectBuyTicketList(Criteria cri) throws Exception;
	
	//전체 글 개수 세팅
	public int selectBuyTicketCnt(Criteria cri) throws Exception;
	
	//이용권 사용목록
	public List<Map<String, Object>> selectUseTicketList(Criteria cri) throws Exception;
	
	//전체글 개수
	public int selectUseTicketCnt(Criteria cri) throws Exception;



	
}
