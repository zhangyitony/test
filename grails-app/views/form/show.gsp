
<%@ page import="test.Form" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'form.label', default: 'Form')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-form" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-form" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list form">
			
				<g:if test="${formInstance?.authoritys}">
				<li class="fieldcontain">
					<span id="authoritys-label" class="property-label"><g:message code="form.authoritys.label" default="Authoritys" /></span>
					
						<g:each in="${formInstance.authoritys}" var="a">
						<span class="property-value" aria-labelledby="authoritys-label"><g:link controller="authority" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
				<g:if test="${formInstance?.name}">
				<li class="fieldcontain">
					<span id="name-label" class="property-label"><g:message code="form.name.label" default="Name" /></span>
					
						<span class="property-value" aria-labelledby="name-label"><g:fieldValue bean="${formInstance}" field="name"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${formInstance?.no}">
				<li class="fieldcontain">
					<span id="no-label" class="property-label"><g:message code="form.no.label" default="No" /></span>
					
						<span class="property-value" aria-labelledby="no-label"><g:fieldValue bean="${formInstance}" field="no"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${formInstance?.registrations}">
				<li class="fieldcontain">
					<span id="registrations-label" class="property-label"><g:message code="form.registrations.label" default="Registrations" /></span>
					
						<g:each in="${formInstance.registrations}" var="r">
						<span class="property-value" aria-labelledby="registrations-label"><g:link controller="registration" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></span>
						</g:each>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${formInstance?.id}" />
					<g:link class="edit" action="edit" id="${formInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
