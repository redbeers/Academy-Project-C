package kr.or.profit.mapper;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.AttachFileVO;
import kr.or.profit.vo.Criteria;
import kr.or.profit.vo.MemberVO;
import kr.or.profit.vo.ProcessVO;

@Mapper("adminMemberMapper")
public interface AdminMemberMapper {
	
	/*트레이너 승인 탭*/
	
	//관리자-트레이너승인, 숫자 보여주는 표
	public ProcessVO selectProcessNumberList();
	
	//관리자-트레이너승인, 리스트 부분
	public List<Map<String, Object>> selectProcessList(Criteria cri);
	
	//페이징용 전체 수 cnt
	public int selectProcessListCnt(Criteria cri);
	
	//검토단계로 update
	public int updateStatusB(String processSeq);
	
	//트레이너 프로세스 디테일
	public ProcessVO selectProcessDetailBySeq(String processSeq);
	
	//첨부파일 가져오기
	public List<?> selectProcessFile(String fileSeq);
	
	//1. 관리자가 선택한 파일 삭제
	public int deleteFileDetailSeq(AttachFileVO vo);
	
	//파일상세고유번호 가져오기
	public String selectFileDetailSeq(String fileSeq);
	
	//2. 관리자 파일테이블에 정보 insert
	public int insertFilebyAdmin(Map map);
	
	//3. process테이블에 정보 업데이트
	public int updateProcessInfo(ProcessVO vo);
	
	//승인 보완 취소 processStatus update
	public int updateProcessStatus(ProcessVO vo);
	
	//승인시 trainer 테이블에 insert
	public void insertTrainerInfo(ProcessVO vo);
	
	//멤버구분 업데이트
	public void updateGubunTrainer(ProcessVO vo);
	
	//관리자 메모 update
	public int updateAdminMemo(ProcessVO vo);
	
	/*회원관리탭*/
	
	//회원관리 리스트
	public List<MemberVO> selectAdminMemberList(Criteria cri);
	
	//회원관리 리스트 전체 개수
    public int selectMemberListCnt(Criteria cri);
    
    //회원 디테일
    public MemberVO adminMemberDetail(String memberId);
    
    //블랙리스트 추가
    public int insertBlacklist(MemberVO vo);
    
    //블랙리스트 삭제
    public int deleteBlacklist(String memebrId);
	
	
}
