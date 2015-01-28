package mil.af.L6S.component.statistics;

import java.util.List;
import java.util.Map;

import mil.af.L6S.component.subject.SubjectDao;
import mil.af.L6S.component.subject.SubjectFormAndDataVO;
import mil.af.L6S.component.subject.SubjectService;
import mil.af.L6S.component.subject.SubjectVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SubjectStatisticsService {

	private SubjectStatisticsDao statisticsDao;
	private SubjectDao subjectDao;
	@Autowired
	void subjectcontroller(SubjectDao subjectDao, SubjectStatisticsDao statisticsDao){
		this.subjectDao=subjectDao;
		this.statisticsDao=statisticsDao;
	}
	
	public Map<String,SubjectFormAndDataVO> getStepCount(String year){
		return statisticsDao.getStepCount(year);
		
	}
	public Map<String,SubjectVO> getSubjectSectionCount(String year){
		return statisticsDao.getSubjectSectionCount(year);
		
	}
	public List<SubjectVO> getSubjectFieldCount(String year){
		return statisticsDao.getSubjectFieldCount(year);
	}
	public List<SubjectVO> getEachBaseCount(String year){
		return statisticsDao.getEachBaseCount(year);
	}
	public Integer getFinishSubjectCount(String year){
		return statisticsDao.getFinishSubjectCount(year);
	}
}
