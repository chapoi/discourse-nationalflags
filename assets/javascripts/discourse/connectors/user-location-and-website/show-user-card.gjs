import { and, notEq } from "truth-helpers";
<template>
{{#if
  (and
    @model.custom_fields.nationalflag_iso
    (notEq @model.custom_fields.nationalflag_iso "none")
  )
}}
  <div class="user-profile-nationalflag">
    <img
      class="nationalflag-usersummary"
      src="/plugins/discourse-nationalflags/images/nationalflags/{{@model.custom_fields.nationalflag_iso}}.png"
      alt={{@model.custom_fields.nationalflag_iso}}
      title={{@model.custom_fields.nationalflag_iso}}
    />
  </div>
{{/if}}
</template>
