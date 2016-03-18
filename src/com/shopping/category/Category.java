package com.shopping.category;

import java.util.ArrayList;
import java.util.List;

public class Category {
	private int id;
	private String name;
	private String descr;
	private int pid ;
	private int isleaf;//#0 for leaf, 1 for no-leaf
	private int grade;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	public int getPid() {
		return pid;
	}
	public void setPid(int pid) {
		this.pid = pid;
	}
	public int getIsleaf() {
		return isleaf;
	}
	public void setIsleaf(int isleaf) {
		this.isleaf = isleaf;
	}
	
	public boolean isleaf(){
		return isleaf==1;
	}
	
	public int getGrade() {
		return grade;
	}
	public void setGrade(int grade) {
		this.grade = grade;
	}
	
	public static void add(Category c){
		CategoryDAO.save(c);
	}
	
	public static void addTopCategory(String name, String descr){
		Category c = new Category();
		c.setId(-1);
		c.setName(name);
		c.setDescr(descr);
		c.setPid(0);
		c.setIsleaf(1);
		c.setGrade(1);
		CategoryDAO.save(c);
		//add(c);
	}
		
	public static List<Category> getCategories(){
		List<Category> list = new ArrayList<Category>();
		CategoryDAO.getCategories(list, 0);
		return list;
	}
	
	public static void addChildCategory(int pid, String name, String descr){
		CategoryDAO.addChildCategory(pid,name, descr);
	}
	
	
	public void delete(){
		CategoryDAO.delete(this.id, this.pid);
	}
	
	public static Category loadById(int id){
		return CategoryDAO.loadById(id);
	}
}
