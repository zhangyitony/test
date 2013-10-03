<%@ page import="test.Acount" %>



<div class="fieldcontain ${hasErrors(bean: acountInstance, field: 'acountName', 'error')} ">
	<label for="acountName">
		<g:message code="acount.acountName.label" default="Acount Name" />
		
	</label>
	<g:textField name="acountName" value="${acountInstance?.acountName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acountInstance, field: 'authoritys', 'error')} ">
	<label for="authoritys">
		<g:message code="acount.authoritys.label" default="Authoritys" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${acountInstance?.authoritys?}" var="a">
    <li><g:link controller="authority" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="authority" action="create" params="['acount.id': acountInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'authority.label', default: 'Authority')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: acountInstance, field: 'jobTitle', 'error')} ">
	<label for="jobTitle">
		<g:message code="acount.jobTitle.label" default="Job Title" />
		
	</label>
	<g:textField name="jobTitle" value="${acountInstance?.jobTitle}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acountInstance, field: 'parentAcount', 'error')} ">
	<label for="parentAcount">
		<g:message code="acount.parentAcount.label" default="Parent Acount" />
		
	</label>
	<g:textField name="parentAcount" value="${acountInstance?.parentAcount}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acountInstance, field: 'password', 'error')} ">
	<label for="password">
		<g:message code="acount.password.label" default="Password" />
		
	</label>
	<g:textField name="password" value="${acountInstance?.password}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: acountInstance, field: 'role', 'error')} required">
	<label for="role">
		<g:message code="acount.role.label" default="Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="role" name="role.id" from="${test.Role.list()}" optionKey="id" required="" value="${acountInstance?.role?.id}" class="many-to-one"/>
</div>

