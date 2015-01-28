package mil.af.L6S.test.subject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.mail.iap.Response;

public class NowServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		resp.setContentType("text/html; charset=euc-kr");
		Date now = new Date();
		
		PrintWriter writer = resp.getWriter();
		
		writer.println("<html>");
		writer.println("<head><title>현재시간</title></head>");
		writer.println("<body>");
		writer.println("현재 시간:");
		writer.println(now.toString());
		writer.println("</body>");
		writer.println("</html>");
		writer.close();
	}

	
}
