import Component from "@glimmer/component";
import {h} from 'virtual-dom';
import {withPluginApi} from 'discourse/lib/plugin-api';
import {ajax} from 'discourse/lib/ajax';
import { and, notEq, or } from "truth-helpers";

const PLUGIN_ID = "national_flags";

class NationalFlagComponent extends Component {
  static shouldRender(args, siteSettings) {
    const result = args.post?.user_signature;
    return result && result !== 'none';
  }

  get flagCode() {
    return this.args.post?.user_signature || 'none';
  }

  <template>
    {{#if (and this.args.post.user_signature (notEq this.args.post.user_signature "none"))}}
      <img 
        class="nationalflag-post"
        src="/plugins/discourse-nationalflags/images/nationalflags/{{this.flagCode}}.png"
        alt="Flag"
      />
    {{/if}}
  </template>
}

function initializeNationalFlags(api, siteSettings) {
  const nationalflagsEnabled = siteSettings.nationalflag_enabled;

  if (!nationalflagsEnabled) {
    return;
  }

  api.renderAfterWrapperOutlet(
    "post-meta-data-poster-name", 
    NationalFlagComponent
  );

  api.modifyClass('route:preferences', {
    pluginId: PLUGIN_ID,

    afterModel(model) {
      return ajax('/natflags/flags').then(natflags => {
        let localised_flags = [];

        localised_flags = natflags.flags
          .map((element) => {
            return {
              code: element.code,
              pic: element.pic,
              description: I18n.t(`flags.description.${element.code}`)
            };
          })
          .sort((a, b) => a.description.localeCompare(b.description));

        model.set('natflaglist', localised_flags);
      })
    }
  });
}

export default {
  name: "nationalflag",
  initialize(container) {
    const siteSettings = container.lookup('site-settings:main');
    withPluginApi("0.1", (api) => {
      initializeNationalFlags(api, siteSettings);
    });
  }
};