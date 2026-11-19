import { ajax } from "discourse/lib/ajax";
import Component from "@glimmer/component";
import { service } from "@ember/service";
import {i18n} from "discourse-i18n";
import ComboBox from "select-kit/components/combo-box";
import { and, notEq } from "truth-helpers";
import dIcon from "discourse/helpers/d-icon";


export default class NationalFlagPreference extends Component {
  @service site;
  @service siteSettings;

  get flags() {
    return this.site.national_flags || [];
  }

  <template>
  <div class="control-group nationalflags">
    <label class="control-label">{{i18n "flags.label"}}</label>
    <div class="controls">
      {{ComboBox
        nameProperty="description"
        valueAttribute="code"
        nameChanges=true
        content=this.flags
        none=this.none
        value=@model.custom_fields.nationalflag_iso
      }}
      {{#if
        (and
          @model.custom_fields.nationalflag_iso
          (notEq @model.custom_fields.nationalflag_iso "none")
        )
      }}
        <img
          class="nationalflag-usersummary"
          src="/plugins/discourse-nationalflags/images/nationalflags/{{@model.custom_fields.nationalflag_iso}}.png"
        />
      {{else}}
        <span class="nationalflag-usersummary nationalflag-none">{{dIcon "globe"}}</span>
      {{/if}}
    </div>
  </div>

</template>
}

