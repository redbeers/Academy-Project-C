package kr.or.profit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import kr.or.profit.mapper.MypageMapper;
import kr.or.profit.service.MypageService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.BuyLessonPayVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.ProcessVO;

@Service("mypageService")
public class MypageServiceImpl extends EgovAbstractServiceImpl implements MypageService{
	
	@Resource(name="mypageMapper")
	private MypageMapper mypageDAO;

	//회원기본정보조회
	@Override
	public List<Map<String, String>> selectMemberInfo(String memberId) throws Exception {
		return mypageDAO.selectMemberInfo(memberId);
	}
	
	//프로세스정보추가
	@Override
	public int insertProcess(ProcessVO vo) throws Exception {
		return mypageDAO.insertProcess(vo);
	}

	//파일 추가
	@Override
	public int insertProcessFile(Map map) throws Exception {
		return mypageDAO.insertProcessFile(map);
	}

	
	
	@Override
	public MemberVO selectAllMemberInfo(String memberId) throws Exception {
		return mypageDAO.selectAllMemberInfo(memberId);
	}

	@Override
	public void updateMemberInfo(MemberVO vo) throws Exception {
		mypageDAO.updateMemberInfo(vo);
		
	}

	@Override
	public int updateOnlyInfo(MemberVO vo) throws Exception {
		return mypageDAO.updateOnlyInfo(vo);
	}

	@Override
	public ProcessVO selectProcessInfo(String memberId) throws Exception {
		return mypageDAO.selectProcessInfo(memberId);
	}

	@Override
	public List<?> selectFileInfo(String fileSeq) throws Exception {
		return mypageDAO.selectFileInfo(fileSeq);
	}

	@Override
	public int checkApplyPage(String memberId) throws Exception {
		return mypageDAO.checkApplyPage(memberId);
	}
	
	//북마크
	@Override
	public List<Map<String, String>> selectBookmarkList(Criteria cri) throws Exception {
		return mypageDAO.selectBookmarkList(cri);
	}

	@Override
	public int selectBookmarkCnt(Criteria cri) throws Exception {
		return mypageDAO.selectBookmarkCnt(cri);
	}

	//회원이 구매한 강의 list
	@Override
	public List<?> myBuyLessonList(Criteria cri) throws Exception {
		return mypageDAO.myBuyLessonList(cri);
	}

	//구매강의 개수
	@Override
	public int selectbuyLessonCnt(Criteria cri) throws Exception {
		return mypageDAO.selectbuyLessonCnt(cri);
	}

	//마이페이지 결제상세
	@Override
	public Map<String, Object> selectMyLessonPayDetail(BuyLessonPayVO vo) throws Exception {
		return mypageDAO.selectMyLessonPayDetail(vo);
	}

	//마이페이지 환불가능 체킹
	@Override
	public int selectcheckRefundFlag(Map<String, Object> refundMap) throws Exception {
		return mypageDAO.selectcheckRefundFlag(refundMap);
	}

	//마이페이지 환불여부 변경
	@Override
	public int updBuyLessonRefundFlag(Map<String, Object> refundFlagMap) throws Exception {
		return mypageDAO.updBuyLessonRefundFlag(refundFlagMap);
	}
	
	//이용권 구매목록
	@Override
	public List<Map<String, Object>> selectBuyTicketList(Criteria cri) throws Exception {
		return mypageDAO.selectBuyTicketList(cri);
	}
	
	//전체 글 개수 세팅
	@Override
	public int selectBuyTicketCnt(Criteria cri) throws Exception {
		return mypageDAO.selectBuyTicketCnt(cri);
	}
	
	//이용권 사용목록
	@Override
	public List<Map<String, Object>> selectUseTicketList(Criteria cri) throws Exception {
		return mypageDAO.selectUseTicketList(cri);
	}
	
	//전체 글 개수 세팅
	@Override
	public int selectUseTicketCnt(Criteria cri) throws Exception {
		return mypageDAO.selectUseTicketCnt(cri);
	}

}
