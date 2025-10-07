<template>
{{#if @model.custom_fields.nationalflag_iso}}
  <img
    class="nationalflag-usersummary"
    src="/plugins/discourse-nationalflags/images/nationalflags/{{@model.custom_fields.nationalflag_iso}}.png"
  />
{{/if}}
</template>