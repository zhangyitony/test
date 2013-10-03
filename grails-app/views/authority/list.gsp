
<%@ page import="test.Authority" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'authority.label', default: 'Authority')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-authority" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-authority" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<th><g:message code="authority.acount.label" default="Acount" /></th>
					
						<g:sortableColumn property="authority" title="${message(code: 'authority.authority.label', default: 'Authority')}" />
					
						<th><g:message code="authority.form.label" default="Form" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${authorityInstanceList}" status="i" var="authorityInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${authorityInstance.id}">${fieldValue(bean: authorityInstance, field: "acount")}</g:link></td>
					
						<td>${fieldValue(bean: authorityInstance, field: "authority")}</td>
					
						<td>${fieldValue(bean: authorityInstance, field: "form")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${authorityInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
