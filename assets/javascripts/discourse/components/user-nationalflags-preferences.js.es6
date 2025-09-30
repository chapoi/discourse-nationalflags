import { default as computed, on } from "discourse-common/utils/decorators";
import Component from "@ember/component";
import { ajax } from "discourse/lib/ajax";

export default Component.extend({
  layoutName:
    "javascripts/discourse/templates/connectors/user-custom-preferences/user-nationalflags-preferences",
  natflaglist: [],

  @on("init")
  setup() {
    ajax("/natflags/flags")
      .then((natflags) => {
        let localised_flags = [];

        localised_flags = natflags.flags
          .map((element) => {
            const description = I18n.t(`flags.description.${element.code}`);
            return {
              code: element.code,
              pic: element.pic,
              description: description,
            };
          })
          .sort((a, b) => a.description.localeCompare(b.description));

        this.set("natflaglist", localised_flags);
      })
      .catch(() => {
        // Handle error silently or show a message
        this.set("natflaglist", []);
      });
  },

  @computed("model.custom_fields.nationalflag_iso")
  flagsource() {
    return this.get("model.custom_fields.nationalflag_iso") == null
      ? "none"
      : this.get("model.custom_fields.nationalflag_iso");
  },
});
