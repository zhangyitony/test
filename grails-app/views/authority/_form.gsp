<%@ page import="test.Authority" %>



<div class="fieldcontain ${hasErrors(bean: authorityInstance, field: 'acount', 'error')} required">
	<label for="acount">
		<g:message code="authority.acount.label" default="Acount" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="acount" name="acount.id" from="${test.Acount.list()}" optionKey="id" required="" value="${authorityInstance?.acount?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: authorityInstance, field: 'authority', 'error')} ">
	<label for="authority">
		<g:message code="authority.authority.label" default="Authority" />
		
	</label>
	<g:textField name="authority" value="${authorityInstance?.authority}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: authorityInstance, field: 'form', 'error')} required">
	<label for="form">
		<g:message code="authority.form.label" default="Form" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="form" name="form.id" from="${test.Form.list()}" optionKey="id" required="" value="${authorityInstance?.form?.id}" class="many-to-one"/>
</div>

