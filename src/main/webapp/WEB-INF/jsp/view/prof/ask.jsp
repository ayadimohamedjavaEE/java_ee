<%@ page import="com.gsnotes.web.models.UserAndAccountInfos" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>


<jsp:include page="../fragments/userheader.jsp" />
<div class="container">

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">



            <jsp:include page="../fragments/usermenu.jsp" />

        </div>
    </nav>
    <h1>Tu as déja importé les notes ! Voulez vous les remplacer </h1>
    
    <a href="/prof/import?ask=yes" class="btn link-success">Yes</a>
    
    <a href="/prof/import" class="btn link-danger">No</a>

<jsp:include page="../fragments/userfooter.jsp" />