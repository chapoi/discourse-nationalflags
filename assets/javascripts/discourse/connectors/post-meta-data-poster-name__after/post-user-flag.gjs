import { and, notEq } from "truth-helpers";
<template>
{{#if
  (and
    @post.user_signature (notEq @post.user_signature "none")
  )
}}
  <img
    class="nationalflag-post"
    src="/plugins/discourse-nationalflags/images/nationalflags/{{@post.user_signature}}.png"
    alt={{@post.user_signature}}
    title={{@post.user_signature}}
  />
{{/if}}
</template>