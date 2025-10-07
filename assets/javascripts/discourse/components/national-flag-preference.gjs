import { ajax } from "discourse/lib/ajax";
import Component from "@glimmer/component";
import { service } from "@ember/service";
import {i18n} from "discourse-i18n";
import ComboBox from "select-kit/components/combo-box";


export default class NationalFlagPreference extends Component {
  @service site;
  @service siteSettings;

  get flags() {
    return this.site.national_flags || [];
  }

  <template>
  {{#if this.siteSettings.nationalflag_enabled}}

  <div class="control-group nationalflags">
    <label class="control-label">{{i18n "flags.label"}}</label>
    <div class="controls">
      {{ComboBox
        nameProperty="description"
        valueAttribute="code"
        nameChanges=true
        content=this.flags
        none=this.none
        value=this.args.model.custom_fields.nationalflag_iso
      }}
      <img
        class="nationalflag-usersummary"
        src="/plugins/discourse-nationalflags/images/nationalflags/{{this.args.model.custom_fields.nationalflag_iso}}.png"
      />
    </div>
  </div>
{{/if}}
</template>
}

