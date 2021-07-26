package kr.or.profit.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.NoticeMapper;
import kr.or.profit.service.NoticeService;
import kr.or.profit.vo.Criteria;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService {

	@Resource(name = "noticeMapper")
	private NoticeMapper mapper;

	//글등록
	@Override
	public int noticeInsert(Map<String, Object> map) throws Exception {
		return mapper.noticeInsert(map);
	}

	//글목록
	@Override
	public List<?> noticeList(Criteria cri) throws Exception {
		return mapper.noticeList(cri);
	}

	//글상세 보기
	@Override
	public Map<String, Object> noticeDetail(Map<String, Object> map) throws Exception {
		return mapper.noticeDetail(map);
	}

	//글 수정
	@Override
	public int noticeModUpdate(Map<String, Object> map) throws Exception {
		return mapper.noticeModUpdate(map);
	}

	//글 삭제
	@Override
	public int noticeDelete(Map<String, Object> map) throws Exception {
		return mapper.noticeDelete(map);
	}

	//조회수 증가
	@Override
	public int noticeCommonHit(Map<String, Object> map) throws Exception {
		return mapper.noticeCommonHit(map);
	}

	//파일 저장
	@Override
	public int noticeFileUpload(Map<String, Object> map) throws Exception {
		return mapper.noticeFileUpload(map);

	}

	//파일 번호
	@Override
	public String noticeFileCnt() throws Exception {
		return mapper.noticeFileCnt();
	}

	//파일 다운로드
	@Override
	public Map<String, Object> qnaProfileDownload(Map<String, Object> map) throws Exception {
		return mapper.qnaProfileDownload(map);
	}

	//파일 삭제
	@Override
	public int noticeModDelFile(Map<String, Object> map) throws Exception {
		return mapper.noticeModDelFile(map);
	}

	//페이징
	@Override
	public int selectBoardCnt(Criteria cri) throws Exception {
		return mapper.selectBoardCnt(cri);
	}

	//파일 리스트
	@Override
	public List<?> noticeDetailFile(Map<String, Object> map) throws Exception {
		return mapper.noticeDetailFile(map);
	}

	//파일 수정
	@Override
	public int noticeFileUploadMod(Map<String, Object> map) throws Exception {
		return mapper.noticeFileUploadMod(map);
	}

	@Override
	public void fileSeq(Map<String, Object> map) throws Exception {
		mapper.fileSeq(map);
	}

}
