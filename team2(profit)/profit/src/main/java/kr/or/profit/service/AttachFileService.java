package kr.or.profit.service;

import kr.or.profit.vo.AttachFileVO;

public interface AttachFileService {

	//파일 등록
	public int insertLessonFile(AttachFileVO vo) throws Exception;
	
	//파일 수정
	public int updateLessonFile(AttachFileVO vo) throws Exception;
	
}
