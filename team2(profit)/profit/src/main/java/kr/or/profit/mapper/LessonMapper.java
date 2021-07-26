package kr.or.profit.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.BookgoodVO;
import kr.or.profit.vo.BuyLessonVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.LessonDetailVO;
import kr.or.profit.vo.LessonVO;
import kr.or.profit.vo.ReplyVO;

@Mapper("lessonMapper")
public interface LessonMapper {

	//강의 등록
	int insertLesson(LessonVO vo) throws Exception;

	//강의 수정
	int updateLesson(LessonVO vo) throws Exception;
	
	//강의 목록 조회
	List<?> selectLessonList(Criteria cri) throws Exception;

	//강의 상세조회
	Map<String, Object> selectLessonDetail(LessonVO vo) throws Exception;

	//강의 삭제(비활성화 여부)
	int deleteLesson(LessonVO vo) throws Exception;

	//강의 파일 추가

	int insertLessonFile(Map map) throws Exception;

	//강의 파일 수정
	int updateLessonFile(Map map) throws Exception;

	//인기강의 조회
	List<?> selectTopLessonList(String memberId) throws Exception;

	//상세강의파일 등록
	int insertClassFile(Map map) throws Exception;

	//상세 강의 등록
	int insertClass(LessonDetailVO vo) throws Exception;

	//상세강의 목록 조회
	List<?> selectClassList(Criteria cri) throws Exception;

	//상세 강의 디테일 조회
	Map<String, Object> selectclassDetail(LessonDetailVO vo) throws Exception;

	//상세 강의 삭제
	int deleteClass(LessonDetailVO vo) throws Exception;

	//카테고리 선택하면 리스트
	List<?> selectCateLessonList(Map<String, Object> map) throws Exception;

	List<?> selectLessonList() throws Exception;

	//자유게시판 상세 댓글 나의 프로필 사진 조회
	String selectMyProfile(String memberId)  throws Exception;

	//강의 댓글리스트 가져오기
	List<Map<String, Object>> selectReplyList(String lessonSeq) throws Exception;

	//강의 댓글 추가
	int insertLessonReply(ReplyVO replyvo);

	//강의 상세 답글 추가
	int insertLessonRereply(ReplyVO replyvo) throws Exception;

	//강의 댓글 삭제
	int deleteLessonReply(String replySeq) throws Exception;

	//조회수 증가
	int increaseLessonHit(String lessonSeq) throws Exception;

	//좋아요북마크 추가
	int insertLessonBookgood(BookgoodVO vo)  throws Exception;

	//좋아요북마크 개수 가져오기
	int selectLessonBookgoodCnt(BookgoodVO vo) throws Exception;

	//좋아요북마크 제거
	int deleteLessonBookgood(BookgoodVO vo) throws Exception;

	//강의 구매 추가
	int insertBuyLesson(BuyLessonVO buyLessonVO) throws Exception;

	//강의 구매한 사람이 있는지 확인
	int selectBuyLesson(Map<String, Object> buyMap) throws Exception;

	//트레인지 확인
	int checkTrainer(String memberId) throws Exception;

	//페이징 - 온라인클래스 전체 글 개수 
	int selectLessonCnt(Criteria cri) throws Exception;

	//페이징 - 온라인클래스 강의 상세 전체 글 개수
	int selectLessonClassCnt(Criteria cri) throws Exception;

	//수강시작 시 업데이트
	int updBuyLesson(BuyLessonVO vo) throws Exception;

	//상세 강의 글 개수
	int selectClassCnt(Criteria cri) throws Exception;

	//온라인클래스 상세 트레이너 정보소개
	List<?> trainerInfo(String lessonSeq) throws Exception;

	//강좌 추천 ai
	List<Map<String, Object>> recommand(String lessonSeq) throws Exception;

	//댓글 수 가져오기
	Map<String, Object> selectReplyCnt(String lessonSeq) throws Exception;





	
	

	


	


	
}
