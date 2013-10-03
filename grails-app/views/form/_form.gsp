<%@ page import="test.Form" %>



<div class="fieldcontain ${hasErrors(bean: formInstance, field: 'authoritys', 'error')} ">
	<label for="authoritys">
		<g:message code="form.authoritys.label" default="Authoritys" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${formInstance?.authoritys?}" var="a">
    <li><g:link controller="authority" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="authority" action="create" params="['form.id': formInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'authority.label', default: 'Authority')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: formInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="form.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${formInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: formInstance, field: 'no', 'error')} required">
	<label for="no">
		<g:message code="form.no.label" default="No" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="no" type="number" value="${formInstance.no}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: formInstance, field: 'registrations', 'error')} ">
	<label for="registrations">
		<g:message code="form.registrations.label" default="Registrations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${formInstance?.registrations?}" var="r">
    <li><g:link controller="registration" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="registration" action="create" params="['form.id': formInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'registration.label', default: 'Registration')])}</g:link>
</li>
</ul>

</div>

