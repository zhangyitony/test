<%@ page import="test.Registration" %>



<div class="fieldcontain ${hasErrors(bean: registrationInstance, field: 'form', 'error')} required">
	<label for="form">
		<g:message code="registration.form.label" default="Form" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="form" name="form.id" from="${test.Form.list()}" optionKey="id" required="" value="${registrationInstance?.form?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: registrationInstance, field: 'role', 'error')} required">
	<label for="role">
		<g:message code="registration.role.label" default="Role" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="role" name="role.id" from="${test.Role.list()}" optionKey="id" required="" value="${registrationInstance?.role?.id}" class="many-to-one"/>
</div>

