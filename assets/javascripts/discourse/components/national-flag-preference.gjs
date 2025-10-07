import { ajax } from "discourse/lib/ajax";
import Component from "@glimmer/component";
import { service } from "@ember/service";
import {i18n} from "discourse-i18n";
import ComboBox from "select-kit/components/combo-box";


export default class NationalFlagPreference extends Component {
  @service site;
  @service siteSettings;

  // static shouldRender(args, siteSettings) {
  //   const result = args.post?.user_signature;
  //   return result && result !== "none";
  // }


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

  

//   @on("init")
//   setup() {
//     console.log(flags);
//     ajax("/natflags/flags")
//       .then((natflags) => {
//         let localised_flags = [];

//         localised_flags = natflags.flags
//           .map((element) => {
//             const description = I18n.t(`flags.description.${element.code}`);
//             return {
//               code: element.code,
//               pic: element.pic,
//               description: description,
//             };
//           })
//           .sort((a, b) => a.description.localeCompare(b.description));

//         this.set("natflaglist", localised_flags);
//       })
//       .catch(() => {
//         // Handle error silently or show a message
//         this.set("natflaglist", []);
//       });
//   },

//   @computed("model.custom_fields.nationalflag_iso")
//   flagsource() {
//     return this.get("model.custom_fields.nationalflag_iso") == null
//       ? "none"
//       : this.get("model.custom_fields.nationalflag_iso");
//   },
// });

