<%@ page import="test.Role" %>



<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'acount', 'error')} ">
	<label for="acount">
		<g:message code="role.acount.label" default="Acount" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${roleInstance?.acount?}" var="a">
    <li><g:link controller="acount" action="show" id="${a.id}">${a?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="acount" action="create" params="['role.id': roleInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'acount.label', default: 'Acount')])}</g:link>
</li>
</ul>

</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'name', 'error')} ">
	<label for="name">
		<g:message code="role.name.label" default="Name" />
		
	</label>
	<g:textField name="name" value="${roleInstance?.name}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: roleInstance, field: 'registrations', 'error')} ">
	<label for="registrations">
		<g:message code="role.registrations.label" default="Registrations" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${roleInstance?.registrations?}" var="r">
    <li><g:link controller="registration" action="show" id="${r.id}">${r?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="registration" action="create" params="['role.id': roleInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'registration.label', default: 'Registration')])}</g:link>
</li>
</ul>

</div>

