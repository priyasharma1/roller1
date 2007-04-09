<%@ include file="/taglibs.jsp" %>
<%@ page import="org.roller.presentation.weblog.actions.WeblogEntryPageModel" %>
<%@ page import="org.roller.presentation.RollerRequest" %>
<%
WeblogEntryPageModel model = (WeblogEntryPageModel)request.getAttribute("model");
%>

<div class="sidebarFade">
    <div class="menu-tr">
        <div class="menu-tl">
        
<div class="sidebarInner">

<h3><fmt:message key="weblogEdit.comments" /></h3>

<c:choose>
<c:when test="${model.commentCount > 0}">
    <c:url value="/editor/commentManagement.do" var="commentManagement">
       <c:param name="method" value="query" />
       <c:param name="weblog" value="${model.website.handle}" />
       <c:param name="entryid" value="${model.weblogEntry.id}" />
    </c:url>
    <span class="entryEditSidebarLink">
        <a href='<c:out value="${commentManagement}" />'>
           <img src='<c:url value="/images/comment.png"/>' 
                align="absmiddle" border="0" alt="icon" title="Comments" />
           <fmt:message key="weblogEdit.hasComments">
                <fmt:param value="${model.commentCount}" />
           </fmt:message>
        </a> 
    </span><br />
</c:when>
<c:otherwise>
   <span><fmt:message key="application.none" /></span>
</c:otherwise>
</c:choose>

<hr size="1" noshade="noshade" />  
<h3><fmt:message key="weblogEdit.pendingEntries" /></h3>

<c:if test="${empty model.recentPendingEntries}">
   <span><fmt:message key="application.none" /></span>
</c:if>
<c:forEach var="post" items="${model.recentPendingEntries}">
    <span class="entryEditSidebarLink"><roller:link page="/editor/weblog.do">
       <roller:linkparam
           id="<%= RollerRequest.WEBLOGENTRYID_KEY %>"
           name="post" property="id" />
           <roller:linkparam id="method" value="edit" />
           <img src='<c:url value="/images/table_error.png"/>' 
                align="absmiddle" border="0" alt="icon" title="Edit" />
           <str:truncateNicely lower="50">
              <c:out value="${post.title}" />
           </str:truncateNicely>
        </roller:link>
    </span><br />
</c:forEach>
    
         
<hr size="1" noshade="noshade" />            
<h3><fmt:message key="weblogEdit.draftEntries" /></h3>

<c:if test="${empty model.recentDraftEntries}">
   <span><fmt:message key="application.none" /></span>
</c:if>
<c:forEach var="post" items="${model.recentDraftEntries}">
    <span class="entryEditSidebarLink"><roller:link page="/editor/weblog.do">
       <roller:linkparam
           id="<%= RollerRequest.WEBLOGENTRYID_KEY %>"
           name="post" property="id" />
           <roller:linkparam id="method" value="edit" />
           <img src='<c:url value="/images/table_gear.png"/>' 
                align="absmiddle" border="0" alt="icon" title="Edit" />
           <str:truncateNicely lower="50">
              <c:out value="${post.title}" />
           </str:truncateNicely>
    </roller:link></span>
    <br />
</c:forEach>             


<c:if test="${model.userAuthorizedToAuthor}">
            
<hr size="1" noshade="noshade" />
<h3><fmt:message key="weblogEdit.publishedEntries" /></h3>

<c:if test="${empty model.recentPublishedEntries}">
   <span><fmt:message key="application.none" /></span>
</c:if>
<c:forEach var="post" items="${model.recentPublishedEntries}">
    <span class="entryEditSidebarLink"><roller:link page="/editor/weblog.do">
       <roller:linkparam
           id="<%= RollerRequest.WEBLOGENTRYID_KEY %>"
           name="post" property="id" />
           <roller:linkparam id="method" value="edit" />
           <img src='<c:url value="/images/table_edit.png"/>' 
                align="absmiddle" border="0" alt="icon" title="Edit" />
           <str:truncateNicely lower="50">
              <c:out value="${post.title}" />
           </str:truncateNicely>
    </roller:link></span>                    
    <br />
</c:forEach>

<br />
<br />
</div>
       
        </div>
    </div>
</div>
 
</c:if>


