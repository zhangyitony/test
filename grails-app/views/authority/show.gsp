
<%@ page import="test.Authority" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'authority.label', default: 'Authority')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-authority" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-authority" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list authority">
			
				<g:if test="${authorityInstance?.acount}">
				<li class="fieldcontain">
					<span id="acount-label" class="property-label"><g:message code="authority.acount.label" default="Acount" /></span>
					
						<span class="property-value" aria-labelledby="acount-label"><g:link controller="acount" action="show" id="${authorityInstance?.acount?.id}">${authorityInstance?.acount?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
				<g:if test="${authorityInstance?.authority}">
				<li class="fieldcontain">
					<span id="authority-label" class="property-label"><g:message code="authority.authority.label" default="Authority" /></span>
					
						<span class="property-value" aria-labelledby="authority-label"><g:fieldValue bean="${authorityInstance}" field="authority"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${authorityInstance?.form}">
				<li class="fieldcontain">
					<span id="form-label" class="property-label"><g:message code="authority.form.label" default="Form" /></span>
					
						<span class="property-value" aria-labelledby="form-label"><g:link controller="form" action="show" id="${authorityInstance?.form?.id}">${authorityInstance?.form?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${authorityInstance?.id}" />
					<g:link class="edit" action="edit" id="${authorityInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
