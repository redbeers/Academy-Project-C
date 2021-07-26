package kr.or.profit.mapper;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.or.profit.vo.AttachFileVO;

@Mapper("fileMapper")
public interface AttachFileMapper {
	
	//온라인클래스 강의등록 파일
	int insertLessonFile(AttachFileVO vo) throws Exception;

	//온라인클래스 강의 수정 파일
	int updateLessonFile(AttachFileVO vo) throws Exception;

}
