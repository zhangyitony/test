
<%@ page import="test.Acount" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'acount.label', default: 'Acount')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-acount" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-acount" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="acountName" title="${message(code: 'acount.acountName.label', default: 'Acount Name')}" />
					
						<g:sortableColumn property="jobTitle" title="${message(code: 'acount.jobTitle.label', default: 'Job Title')}" />
					
						<g:sortableColumn property="parentAcount" title="${message(code: 'acount.parentAcount.label', default: 'Parent Acount')}" />
					
						<g:sortableColumn property="password" title="${message(code: 'acount.password.label', default: 'Password')}" />
					
						<th><g:message code="acount.role.label" default="Role" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${acountInstanceList}" status="i" var="acountInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${acountInstance.id}">${fieldValue(bean: acountInstance, field: "acountName")}</g:link></td>
					
						<td>${fieldValue(bean: acountInstance, field: "jobTitle")}</td>
					
						<td>${fieldValue(bean: acountInstance, field: "parentAcount")}</td>
					
						<td>${fieldValue(bean: acountInstance, field: "password")}</td>
					
						<td>${fieldValue(bean: acountInstance, field: "role")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${acountInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
