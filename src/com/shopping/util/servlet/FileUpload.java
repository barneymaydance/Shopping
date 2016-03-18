package com.shopping.util.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.*;
import java.util.*;
import java.util.regex.*;
import java.io.*;
import org.apache.commons.fileupload.servlet.*;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;


public class FileUpload extends HttpServlet {
	
	private ServletConfig config = null;
	
	private String uploadPath = "D:\\picture\\";
	private File tempPath = new File("D:\\picture\\temp\\"); // temporary file context

	public void destroy() {
		config = null;
		super.destroy();
	}
	
	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		int id = -1;
		
		//String uploadPath = config.getInitParameter("uploadPath"); // upload path context
		
		//res.setContentType("text/html; charset=GB2312");
		PrintWriter out = res.getWriter();
		System.out.println(req.getContentLength());
		System.out.println(req.getContentType());
		DiskFileItemFactory factory = new DiskFileItemFactory();
		// maximum size that will be stored in memory
		factory.setSizeThreshold(4096);
		// the location for saving data that is larger than getSizeThreshold()
		factory.setRepository(tempPath);

		ServletFileUpload upload = new ServletFileUpload(factory);
		// maximum size before a FileUploadException will be thrown
		upload.setSizeMax(1000000);
		try {
			List fileItems = upload.parseRequest(req);
			// assume we know there are two files. The first file is a small
			// text file, the second is unknown and is written to a file on
			// the server
			Iterator iter = fileItems.iterator();

			// regexp filter file path
			String regExp = ".+\\\\(.+)$";

			// filter file type
			String[] errorType = { ".exe", ".com", ".cgi", ".jsp" };
			Pattern p = Pattern.compile(regExp);
			while (iter.hasNext()) {
				FileItem item = (FileItem) iter.next();
				if(item.isFormField()) {
					if(item.getFieldName().equals("id")) {
						id = Integer.parseInt(item.getString());
					}
				}
				// if not file content
				if (!item.isFormField()) {
					String name = item.getName();
					long size = item.getSize();
					if ((name == null || name.equals("")) && size == 0)
						continue;
					Matcher m = p.matcher(name);
					boolean result = m.find();
					if (result) {
						for (int temp = 0; temp < errorType.length; temp++) {
							if (m.group(1).endsWith(errorType[temp])) {
								throw new IOException(name + ": wrong type");
							}
						}
						try {
							item.write(new File(uploadPath + id + ".jpg"));

							out.print(name + "&nbsp;&nbsp;" + size + "<br>");
						} catch (Exception e) {
							out.println(e);
						}

					} else {
						throw new IOException("fail to upload");
					}
				}
			}
		} catch (IOException e) {
			out.println(e);
		} catch (FileUploadException e) {
			out.println(e);
		}

	}
	
//	public void init(ServletConfig config) throws ServletException {
//		this.config = config;
//	}
	

	

}

