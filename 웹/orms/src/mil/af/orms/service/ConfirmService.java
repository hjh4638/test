package mil.af.orms.service;

import java.sql.SQLException;

import javax.annotation.Resource;

import mil.af.orms.dao.ConfirmDAO;
import mil.af.orms.model.ConfirmVO;
import mil.af.orms.model.UserVO;

import org.springframework.stereotype.Service;

@Service("ConfirmService")
public class ConfirmService {
	@Resource(name="ConfirmDAO")
	ConfirmDAO confirmDAO;

	public String confirmSchedule(Integer scheduleId, String confirmResult,
			String confirmOpinion, UserVO userVO) throws SQLException {
		ConfirmVO confirmVO=new ConfirmVO();
		confirmVO.setSeq(scheduleId);
		confirmVO.setSn(userVO.getUserid());
		confirmVO.setSosokcode(userVO.getSosokcode());
		confirmVO.setOpinion(confirmOpinion);
		confirmVO.setResult_fix(confirmResult);
		if(userVO.getSosokcode()==null||userVO.getUserid()==null){
			return "확인관 정보가 없습니다.통합인증 로그인 상태를 확인해주십시오.";
		}else{
			Integer confirmCount=confirmDAO.getConfirmCount(scheduleId);
			if(confirmCount<1){
				confirmDAO.insertConfirm(confirmVO);
				return "Success";
			}
			/*2012.5.9 일병 함준혁*/
			else if(confirmCount>=1){
				confirmDAO.updateConfirm(confirmVO);
				return "Success";
			}
			else{
				return "이미 의견이 등록되었습니다.";
			}
		}
	}
	public String getConfirmDateToCompare(String scheduleSeq) throws SQLException {
		return confirmDAO.getConfirmDateToCompare(scheduleSeq); 
	}
}
