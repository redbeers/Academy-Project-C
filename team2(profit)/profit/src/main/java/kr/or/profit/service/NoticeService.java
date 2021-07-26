package kr.or.profit.service;

import java.util.List;
import java.util.Map;

import kr.or.profit.vo.Criteria;

public interface NoticeService {

	int noticeInsert(Map<String, Object> map) throws Exception;

	List<?> noticeList(Criteria cri) throws Exception;

	int noticeCommonHit(Map<String, Object> map) throws Exception;

	Map<String, Object> noticeDetail(Map<String, Object> map) throws Exception;

	int noticeModUpdate(Map<String, Object> map) throws Exception;

	int noticeDelete(Map<String, Object> map) throws Exception;

	int noticeFileUpload(Map<String, Object> map) throws Exception;

	String noticeFileCnt() throws Exception;

	Map<String, Object> qnaProfileDownload(Map<String, Object> map) throws Exception;

	int noticeModDelFile(Map<String, Object> map) throws Exception;

	int selectBoardCnt(Criteria cri) throws Exception;

	List<?> noticeDetailFile(Map<String, Object> map) throws Exception;

	int noticeFileUploadMod(Map<String, Object> imgindexs) throws Exception;

	void fileSeq(Map<String, Object> map) throws Exception;

}