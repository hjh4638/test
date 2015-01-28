package util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.activation.DataSource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * @author 공군 상병 함준혁
 *
 */
public class UploadAndDownloadUtil {
	private String dir_name;
	private String form_name;
	
	public UploadAndDownloadUtil(String directory_name,String form_name){
		this.dir_name = directory_name;
		this.form_name = form_name;
	}
	
	private String accept_type = "hwp,doc,docx,ppt,pptx,xls,pdf,txt,jpg,gif,gux,hox,xlsx,nxl,hpt,vsd,bmp,show";
	private long accept_volume= 524288000;
	
	public String getAccept_type() {
		return accept_type;
	}
	public void setAccept_type(String accept_type) {
		this.accept_type = accept_type;
	}
	public long getAccept_volume() {
		return accept_volume;
	}
	public void setAccept_volume(long accept_volume) {
		this.accept_volume = accept_volume;
	}
/**
 * 실제 업로드를 수행하고 저장한 파일이름을 리턴한다.
 * name ="file"로 전송한 한개 파일만 가능
 * @param request
 * @param response
 * @param file_id 
 * @return
 */
public String upload(HttpServletRequest request, HttpServletResponse response, String file_id){
		String path = request.getSession().getServletContext().getRealPath(dir_name);	
		MultipartHttpServletRequest mhsr = (MultipartHttpServletRequest) request;
		MultipartFile multi = mhsr.getFile(form_name);
		String filename=multi.getOriginalFilename();
						
		/*디렉토리 존재여부 체크*/
		File dir = new File(path);
		isThereDir(dir);
	
		/*업로드 가능 확장자인지  체크 AND 용량 사이즈 체크*/ 
		String type = filename.substring(filename.lastIndexOf(".") + 1,	filename.length());
		if((filename==null || "".equals(filename) ||!(isAccept(type)))||!(isAcceptVolume(multi.getSize())))
			return "";
			
		viewFileList(dir);
		filename=file_id;
		
		File file = new File(path,filename);
		try {
			multi.transferTo(file);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return multi.getOriginalFilename();
	}
/**
 * name ="attachedFile"로 전송한 여러개 파일 가능
 * @param request
 * @param response
 * @return 
 * @return
 */
public Map<String,String> severalThingUpload(HttpServletRequest request,
		List<MultipartFile> files,
		List<String> file_ids){
 
	String path = request.getSession().getServletContext().getRealPath(dir_name);
	
	File dir = new File(path);
	isThereDir(dir);
	
	int size = files.size();
	viewFileList(dir);
	Map<String,String> filename_list = new LinkedHashMap<String,String>();
		
	for(int i=0;i<size;i++){
		String filename=files.get(i).getOriginalFilename();
		
		String type = filename.substring(filename.lastIndexOf(".") + 1,
				filename.length());
				
//				|| !(isAcceptVolume(files.get(i).getSize())))
		if((filename==null || "".equals(filename)||!(isAccept(type))))
			System.out.println("업로드불가파일");
		else{
		File file = new File(path,file_ids.get(i));
		filename_list.put(filename, file_ids.get(i));
		try {
			files.get(i).transferTo(file);
			System.out.println("filename= "+filename+" ,file_id= "+file_ids.get(i));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
	}
	return filename_list;
}
/**
 * 지정된 디렉토리에서 파일명으로 
 * @param request
 * @param response
 * @param filename
 * @param origin_filename 
 * @throws IOException
 */
public void download(HttpServletRequest request, HttpServletResponse response, String filename, String origin_filename) throws IOException{
	String path = request.getSession().getServletContext().getRealPath(dir_name);
		
	if(filename.contains("../"))
		filename =filename.replace("../", "");
	else if(filename.contains("./"))
		filename =filename.replace("./", "");
	else if(filename.contains(".."))
		filename =filename.replace("..", "");
	
	File file = new File(path,filename);
	
	String utf_filename =  java.net.URLEncoder.encode(origin_filename,"utf-8");
	utf_filename = utf_filename.replace("+", " ");
	response.setContentType("application/octet-stream");
	response.setContentLength((int)file.length());
	response.setHeader("Content-Disposition","attachment;fileName="
			+utf_filename+";");
	response.setHeader("Content-Transfer", "binary");
		
	OutputStream out = response.getOutputStream();
	FileInputStream fis = null;
	try {
		fis = new FileInputStream(file);
		FileCopyUtils.copy(fis, out);
	} catch (UnsupportedEncodingException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	finally{
		if(fis!=null)
			try{
				fis.close();
			}catch(IOException ex){
			}
	}
 out.flush();
}

/**List filenames의 수만큼 각 파일을 지정한 디렉토리로 복사하여 write한다.
 * @param request
 * @param directory
 * @param filenames
 */
public void transferFile(HttpServletRequest request, String directory, List<String> filenames){
	String resource_path = request.getSession().getServletContext().getRealPath(dir_name);
	String destination_path = request.getSession().getServletContext().getRealPath(directory);
	
	File dir = new File(destination_path);
	isThereDir(dir);
	
	for(int i=0;i<filenames.size();i++){
		File res_file = new File(resource_path,filenames.get(i));
		File des_file = new File(destination_path,filenames.get(i));
		if(!(des_file.exists())){
			try {
				FileInputStream in= new FileInputStream(res_file);
				BufferedInputStream buin=new BufferedInputStream(in);
				
				FileOutputStream out = new FileOutputStream(des_file);
				BufferedOutputStream buout = new BufferedOutputStream(out);
				
				int c;
				byte b[]=new byte[1024];
				try {
					while((c=buin.read(b))!=-1){
						buout.write(b,0,c);
						buout.flush();
						}
					out.flush();
					buin.close();
					buout.close();
					in.close();
					out.close();
				}catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}
/**dir 폴더에 들어있는 파일 출력
 * @param dir
 */
public void viewFileList(File dir){
	String[] list = dir.list();
	if(list != null){
		for(int i=0; i<list.length;i++)
			System.out.println("\t"+list[i]);
	}else{}
}
/**input으로 들어가는 파일과 같은 이름의 파일이 디렉토리에 존재할경우
 * 파일명을 변경하여 반환
 * (재귀함수 이용)
 * @param file
 * @param filename
 * @param i
 * @param path
 * @return
 */
public File replaceAlikeFileName(File file,String filename, int i, String path){
	String copyFileName="("+i+")"+filename;
	if(file.exists()){
		i=i+1;
		File copyfile = new File(path,copyFileName);
		return replaceAlikeFileName(copyfile,filename,i,path);
	}
	else
		return file;
}
/**허용된 확장자인지 판별해주는 함수
 * @param type
 * @return
 */
private boolean isAccept(String type){
	String[] ss=accept_type.split(",");
	boolean is_Accept= false;
	for(String a_type : ss){
		if(type.equalsIgnoreCase(a_type))
			return true;
	}
	if(!(is_Accept))
	{
	try {
		Exception e = new Exception("잘못된 형식의 파일입니다.");
		throw e;
	} catch (Exception e) {
		System.out.println("에러메시지:"+e.getMessage());
		e.printStackTrace();
	}
	}
	return false;
}
/**지정된 경로에 디렉토리가 있는지 판별하는 함수
 * 디렉토리가 없을시 디렉토리 생성
 * @param dir
 * @return
 */
private boolean isThereDir(File dir){
	if(dir.exists())
		return true;
	else
		dir.mkdir();
	return false;
}
private boolean isAcceptVolume(long size){
	if(size>=accept_volume)
		return false;
	return true;
}
}