<%@page import="java.text.DecimalFormat"%>
<%@page import="service.GoodsService"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// Controller : java clss <- Servlet
	int rowPerPage = 20;
	int currentPage = 1;
	
	if (request.getParameter("rowPerPage") != null) {
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	DecimalFormat df = new DecimalFormat("###,###"); // 가격 천단위에 ,넣기
	
	GoodsService goodsService = new GoodsService();
	
	// list
	List<Map<String, Object>> goodsList = goodsService.getCustomerGoodsListByPage(rowPerPage, currentPage);
%>
<!-- 분리하면 servlet / 연결기술 forword(request, response) / jsp  -->

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Admin Index</title>
    <link href="<%=request.getContextPath()%>/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/font-awesome.min.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/prettyPhoto.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/price-range.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/css/animate.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet">
	<link href="<%=request.getContextPath()%>/css/responsive.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <script src="js/html5shiv.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->       
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/images/favicon.ico" type="umage/x-icon" />
	<link rel="icon" href="<%=request.getContextPath()%>/images/favicon.ico" type="umage/x-icon" />
    <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head><!--/head-->

<body>
	
	<%@include file="/header.jsp" %><!-- header -->
	
	<div class="container">
		<div class="features_items">
    	<%
    		for(Map<String, Object> m : goodsList) {
    	%>
    	
    	<div class="col-sm-3">
			<div class="product-image-wrapper">
				<div class="single-products">
						<div class="productinfo text-center">
							<img src="<%=request.getContextPath() %>/upload/<%=m.get("filename") %>" alt="상품이미지" />
							<h2><%=df.format(m.get("goodsPrice")) %></h2>
							<p><%=m.get("goodsName") %></p>
							<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
						</div>
						<div class="product-overlay">
							<div class="overlay-content">
								<h2><%=df.format(m.get("goodsPrice")) %></h2>
								<p><%=m.get("goodsName") %></p>
								<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>
							</div>
						</div>
				</div>
				<div class="choose">
					<ul class="nav nav-pills nav-justified">
						<li><a href="#"><i class="fa fa-plus-square"></i>Add to wishlist</a></li>
						<li><a href="#"><i class="fa fa-plus-square"></i>Add to compare</a></li>
					</ul>
				</div>
			</div>
		</div>
        <%
    		}
    	%>
	    <!-- 페이징 -->
		   <%
		   		int lastPage = goodsService.getGoodsListLastPage(rowPerPage);
		   		
		   %>
		   <div class="text-center">
		   		<ul class="mypagination justify-content-center">
		   		<%	
			   		int end = (int)(Math.ceil(currentPage / (double)rowPerPage) * rowPerPage);
					int start = end - rowPerPage + 1;
					end = (end < lastPage) ? end : lastPage; // lastPage 이상이 되면 end페이지 번호가 lastPage
					if (currentPage != 1) {
				%>
					<li class="page-item"><a class="page-link cool-blues" href="<%=request.getContextPath() %>/customerGoodsList.jsp?currentPage=<%=1%>"><<</a></li>
					<li class="page-item"><a class="page-link cool-blues" href="<%=request.getContextPath() %>/customerGoodsList.jsp?currentPage=<%=currentPage-1%>">Previous</a></li>
				<%		
					}
					for (int i = start; i <= end; i++){
				%>	
					<li class="page-item"><a class="page-link cool-blues" href="<%=request.getContextPath() %>/customerGoodsList.jsp?currentPage=<%=i%>"><%=i %></a></li>
				<%
						
					}
					if (currentPage != lastPage) {
				%>
					<li class="page-item"><a class="page-link cool-blues" href="<%=request.getContextPath() %>/customerGoodsList.jsp?currentPage=<%=currentPage+1%>">Next</a></li>
					<li class="page-item"><a class="page-link cool-blues" href="<%=request.getContextPath() %>/customerGoodsList.jsp?currentPage=<%=lastPage%>">>></a></li>
				<%
					}
				%>
		   		</ul>
		   </div>  
		   </div>
	</div>
		
	<%@include file="/footer.jsp" %><!-- footer -->
	
    <script src="js/jquery.js"></script>
	<script src="js/price-range.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
