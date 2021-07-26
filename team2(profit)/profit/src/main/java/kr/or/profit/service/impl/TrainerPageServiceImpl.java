package kr.or.profit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.CommunityMapper;
import kr.or.profit.mapper.TrainerPageMapper;
import kr.or.profit.service.CommunityService;
import kr.or.profit.service.TrainerPageService;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.CommunityVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.ProcessVO;
import kr.or.profit.vo.ReplyVO;

@Service("trainerPageService")
public class TrainerPageServiceImpl implements TrainerPageService {

	@Resource(name = "trainerPageMapper")
	private TrainerPageMapper trainerPageDAO;
	
	//상담 정산 리스트 조회
	@Override
	public List<Map<String, Object>> selectChatAccountList(Criteria cri) throws Exception {
		return trainerPageDAO.selectChatAccountList(cri);
	}
	
	//상담 정산 목록 전체 글 개수 조회
	@Override
	public int selectChatCnt(Criteria cri) throws Exception{
		return trainerPageDAO.selectChatCnt(cri);
	}

	//이용권 정산 차트
	@Override
	public Map<String, Object> selectChartInfo(String memberId) throws Exception {
		return trainerPageDAO.selectChartInfo(memberId);
	}
	
	//온라인 클래스 정산 리스트 조회
	@Override
	public List<Map<String, Object>> selectClassAccountList(Criteria cri) throws Exception {
		return trainerPageDAO.selectClassAccountList(cri);
	}
	
	//온라인클래스 정산 목록 전체 글 개수 조회
	@Override
	public int selectClassCnt(Criteria cri) throws Exception {
		return trainerPageDAO.selectClassCnt(cri);
	}

	//이용권 정산 차트
	@Override
	public Map<String, Object> selectChart2Info(String memberId) throws Exception {
		return trainerPageDAO.selectChart2Info(memberId);
	}

	//트레이너 자신의 클래스 목록 조회
	@Override
	public List<Map<String, Object>> selectTrainerClassList(Criteria cri) throws Exception {
		return trainerPageDAO.selectTrainerClassList(cri);
	}
	
	//트레이너 자신의 클래스 목록 글 전체 개수
	@Override
	public int selectTrainerClassCnt(Criteria cri) throws Exception {
		return trainerPageDAO.selectTrainerClassCnt(cri);
	}
	
	//upUserId가 관리자인지 알아보기
	@Override
	public Map<String, Object> selectAdminFlag(String upUserId) throws Exception {
		return trainerPageDAO.selectAdminFlag(upUserId);
	}
	
	//강의 공개 상태 바꾸기
	@Override
	public int updateLessonPrivate(LessonVO vo) throws Exception {
		return trainerPageDAO.updateLessonPrivate(vo);
	}
	
	//구매 많은 순 차트 정보 (남자)
	@Override
	public List<Map<String,Object>> selectBestClassMaleInfo(String memberId) throws Exception {
		return trainerPageDAO.selectBestClassMaleInfo(memberId);
	}
	
	//구매 많은 순 차트 정보 (여자)
	@Override
	public List<Map<String,Object>> selectBestClassFemaleInfo(String memberId) throws Exception {
		return trainerPageDAO.selectBestClassFemaleInfo(memberId);
	}
	
	//이름 가져오기
	@Override
	public Map<String, Object> selectTrainer(String memberId) throws Exception {
		return trainerPageDAO.selectTrainer(memberId);
	}
	
	//총 정산 정보 목록 가져오기
	@Override
	public List<Map<String, Object>> selectAccountList(Map<String, Object> info) throws Exception {
		return trainerPageDAO.selectAccountList(info);
	}
	
	//나머지 정보 가져오기
	@Override
	public Map<String, Object> selectRemainInfo(Map<String, Object> info) throws Exception {
		return trainerPageDAO.selectRemainInfo(info);
	}
	
	//내 정보 가져오기
	@Override
	public Map<String, Object> selectMyInfo(String memberId) throws Exception {
		return trainerPageDAO.selectMyInfo(memberId);
	}
	
	//내정보 수정
	@Override
	public int updateMyInfo(ProcessVO vo) throws Exception {
		return trainerPageDAO.updateMyInfo(vo);
	}
	
	
}
