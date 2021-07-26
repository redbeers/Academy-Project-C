package kr.or.profit.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.or.profit.mapper.AttachFileMapper;
import kr.or.profit.service.AttachFileService;
import kr.or.profit.vo.AttachFileVO;

@Service("fileService")
public class AttachFileServiceImpl implements AttachFileService {
	
	@Resource(name = "fileMapper")
	private AttachFileMapper fileDAO;
	
	//온라인클래스 강의등록 파일
	@Override
	public int insertLessonFile(AttachFileVO vo) throws Exception {
		return fileDAO.insertLessonFile(vo);
	}

	//온라인클래스 강의 수정 파일
	@Override
	public int updateLessonFile(AttachFileVO vo) throws Exception {
		return fileDAO.updateLessonFile(vo);
	}


}
