<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/portlet" prefix="portlet" %>
<%@ taglib uri="/WEB-INF/custom.tld" prefix="awc" %>

<%@ page isELIgnored="false" %>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main.css" TYPE="text/css">

<f:view>
   <%-- load a bundle of properties I18N strings here --%>
   <f:loadBundle basename="messages" var="msg"/>
   
   <h:form id="userListForm">
   
      <h2>Test Components</h2>
      
      <%-- use JSTL as simple example way to list the users --%>
      <%-- TODO: find out how to get this working - currently it can't find the JSF bean
                 in the session scope. Using useBean tag creates a new copy --%>
      <%--<jsp:useBean id="UserListBean" scope="session" class="jsftest.UserListBean" />--%>
      <%--
      <ol>
         <c:forEach items="${sessionScope.UserListBean.users}" var="u">
            <li>Username: ${u.username}, Name: ${u.name}, Roles: ${u.roles}</li>
         </c:forEach>
      </ol>
            
      <p>
      --%>
      
      <%-- DataList component test --%>
      DataList component test
      before datalist table
      <awc:dataList cellspacing="2" cellpadding="1" styleClass="recordSet">
         <tr><td>inside datalist table</td></tr>
      </awc:dataList>
      after datalist table
      
      <p>
      
      <%-- RichList component test --%>
      <%-- The RichList component is different to the data-grid in that it is
           designed to render it's own child components. This means it is capable
           of rendering the columns in any order and in any kind of layout. Allowing
           the impl of details, icons and list views within a single component. --%>
      RichList component test, including sortable columns of various data types and paging.
      <awc:richList viewModes="list,details,icon" pageSize="4" styleClass="none" style="border-width:thin" rowStyleClass="recordSetRow" altRowStyleClass="recordSetRowAlt"
            value="#{TestList.rows}" var="r" initialSortColumn="name" initialSortDirection="true">
         <awc:column primary="true">
            <f:facet name="header">
               <awc:sortLink label="Name" value="name" mode="case-insensitive" styleClass="header"/>
            </f:facet>
            <h:outputText value="#{r.name}"/>
         </awc:column>
         
         <awc:column>
            <f:facet name="header">
               <awc:sortLink label="Count" value="count" styleClass="header"/>
            </f:facet>
            <h:outputText value="#{r.count}"/>
         </awc:column>
         
         <awc:column>
            <f:facet name="header">
               <awc:sortLink label="Valid" value="valid" styleClass="header"/>
            </f:facet>
            <h:outputText value="#{r.valid}"/>
         </awc:column>
         
         <awc:column>
            <f:facet name="header">
               <awc:sortLink label="Relevance" value="relevance" styleClass="header"/>
            </f:facet>
            <h:outputText value="#{r.relevance}"/>
         </awc:column>
         
         <awc:column>
            <f:facet name="header">
               <awc:sortLink label="Created Date" value="created" styleClass="header"/>
            </f:facet>
            <h:outputText value="#{r.created}">
               <%-- example of a DateTime converter --%>
               <%-- can be used to convert both input and output text --%>
               <f:convertDateTime dateStyle="short" />
            </h:outputText>
         </awc:column>
         
         <%-- components other than columns added to a RichList will generally
              be rendered as part of the list footer --%>
         <awc:dataPager/>
      </awc:richList>
      
      <p>
      
      <%-- example of using a JSF DataTable to list the users --%>
      <%-- iterates around the List of User objects in the UserListBean --%>
      JSF dataTable component test.
      <h:dataTable id="userlist" value="#{UserListBean.usersModel}" var="u">
        <h:column>
          <f:facet name="header">
            <%-- NOTE: You cannot insert plain HTML text here, due to the way that some JSF
                       components are architected, the plain HTML would get displayed before
                       the body of the datatable tag is output. This is also true of the
                       other container tags including 'panel'.
                       The datatable is considerably inferior to our portal data tags
                       or even the freely available 'displaytag' tag library --%>
            <%-- You can also use the nasty 'f:verbatim' tag to wrap any non JSF elements --%>
            <h:outputText value="#{msg.username}"/>
          </f:facet>
          <h:outputText value="#{u.username}"/>
        </h:column>
        <h:column>
          <f:facet name="header">
            <h:outputText value="#{msg.name}"/>
          </f:facet>
          <h:outputText value="#{u.name}"/>
        </h:column>
        <h:column>
          <f:facet name="header">
            <h:outputText value="#{msg.joindate}"/>
          </f:facet>
          <h:outputText value="#{u.dateJoined}">
            <%-- example of a DateTime converter --%>
            <%-- can be used to convert both input and output text --%>
            <f:convertDateTime dateStyle="short" />
          </h:outputText>
        </h:column>
        <h:column>
          <f:facet name="header">
            <h:outputText value="#{msg.roles}"/>
          </f:facet>
          <h:outputText value="#{u.roles}"/>
        </h:column>
        <h:column>
          <f:facet name="actions">
            <h:outputText value="#{msg.actions}"/>
          </f:facet>
          <%-- inline command link - has an action listener which will decode which
               item in the grid it was clicked using the param tag below
               Then the action listener will delegate to the action view --%>
          <h:commandLink id="edit" value="Edit" action="edituser" actionListener="#{UserListBean.editUser}"/>
          <f:param id="userId" name="id" value="#{u.username}" />
        </h:column>
      </h:dataTable>
      
      </p>
      
      <h:commandButton id="add-user" value="Add" action="adduser" actionListener="#{UserListBean.addUser}"/>
      <br/><br/>
      <h:commandButton id="show-property-zoo" value="Property Zoo" action="#{ZooService.showPropertyZoo}" />
   </h:form>
</f:view>
