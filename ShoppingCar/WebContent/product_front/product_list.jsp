<%@page import="org.wp.dao.IProductDAO"%>
<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@page import="org.wp.vo.*,org.wp.factory.*"%>
<%@page import="java.util.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<title>商品列表</title>
</head>
<script language = "javascript">
	function changeColor(obj,color){
		obj.bgColor = color;
	}
	function update(){
		window.location = "${pageContext.request.contextPath }/ProductFrontServlet?status=member_updatepre";
	}
	function exit(){
		window.location = "${pageContext.request.contextPath }/AdminLogout_Front_Servlet";
	}
</script>
<body>
<%!
	public static final String URL = "product_list.jsp";
%>
<%
	int currentPage = 1;			//为当前所在的页，默认在第一页
	int lineSize = 5;				//	每页显示的条数
	long allRecorders = 0 ; 		//	表示全部的记录数
	String keyword = request.getParameter("kw"); //接收查询关键字
%>
<%
	try{
		currentPage = Integer.parseInt(request.getParameter("cp"));			//取得当前的页面
	}catch(Exception e){}
	try{
		lineSize = Integer.parseInt(request.getParameter("ls"));			//取得每页显示的条数
	}catch(Exception e){}
	try{
		allRecorders = Long.parseLong(request.getParameter("allRecorders"));		//取得全部的查询记录
	}catch(Exception e){}
	if(keyword == null){
		keyword = "";
	}	
%>
<%
	IProductDAO dao = DAOFactory.getIProductDAOInstance();					//产品代理类
	List<Product> all = dao.findAll(keyword, currentPage, lineSize);		//取得所有的商品信息
	pageContext.setAttribute("all", all);									//为后面的标签输出准备
	allRecorders = dao.getAllCount(keyword);								//商品的记录条数
%>
<center>
	<h1>商品列表</h1>
	<h2><a href = "#">增加新商品</a></h2>
<!-- 引入分页组件，并且传入相关参数 -->
<jsp:include page = "split_page_plugin.jsp">
	<jsp:param name = "allRecorders" value = "<%=allRecorders %>"></jsp:param>
	<jsp:param name = "url" value = "<%=URL%>"></jsp:param>
	<jsp:param name = "currentPage" value = "<%=currentPage%>"></jsp:param>
	<jsp:param name = "lineSize" value = "<%=lineSize%>"></jsp:param>
</jsp:include>

<table border = "1" width = "100%" bgcolor = "F2F2F2" cellpadding = "5" cellspacing="0">
	<tr onMouseOver="changeColor(this,'white')" onMouseOut = "changeColor(this,'F2F2F2')">
		<td align = "center" valign = "middle"><span class = "STYLE10"></span>编号</td>
		<td align = "center" valign = "middle"><span class = "STYLE10"></span>名称</td>
		<td align = "center" valign = "middle"><span class = "STYLE10"></span>价格</td>
		<td align = "center" valign = "middle"><span class = "STYLE10"></span>数量</td>
		<td align = "center" valign = "middle"><span class = "STYLE10"></span>简介</td>
		<td align = "center" valign = "middle"><span class = "STYLE10"></span>访问量</td>
		<td align = "center" valign = "middle"><span class = "STYLE10"></span>购买</td>
	</tr>	
<c:forEach items="${all}" var="pro" >
	<tr onMouseOver="changeColor(this,'white')" onMouseOut = "changeColor(this,'F2F2F2')">
		<td>${pro.pid}</td>
		<td><a href = "${pageContext.request.contextPath }/ProductFrontServlet?pid=${pro.pid}&status=show" target="_ablank">${pro.name}</a></td>
		<td>${pro.price}</td>
		<td>${pro.amount}</td>
		<td>${pro.note}</td>	
		<td>${pro.count}</td>
		<td><a href = "${pageContext.request.contextPath }/ProductFrontServlet?pid=${pro.pid}&status=add_cars" target="_ablank">增加到购物车</a></td>
	</tr>
</c:forEach>
	<tr onMouseOver="changeColor(this,'white')" onMouseOut = "changeColor(this,'F2F2F2')">
		<td colspan = "8">
		<%-- <a href = "${pageContext.request.contextPath }/ProductFrontServlet?status=member_updatepre" target="_ablank">修改登录信息</a>
		<a href = "${pageContext.request.contextPath }/AdminLogoutServlet">退出登录</a> --%>
		<!--  <input type = "button" value = "修改登录信息" onclick = "update()"> -->
		 <input type = "button" value = "退出登录" onclick = "exit()">
		</td>		
	</tr>	
</table>
</center>
</body>
</html>