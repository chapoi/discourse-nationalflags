# name: discourse-nationalflags
# about: Display National Flags from User's home countries.
# version: 2.0
# authors: Neil Ebrey <neil.ebrey@gmail.com>, Rob Barrow <merefield@gmail.com>
# url: https://github.com/Ebsy/discourse-nationalflags

enabled_site_setting :nationalflag_enabled

PLUGIN_NAME = "discourse-nationalflags"

after_initialize do

  module ::DiscourseNationalFlags
    class Engine < ::Rails::Engine
      engine_name "discourse_national_flags"
      isolate_namespace DiscourseNationalFlags
    end
  end

  load File.expand_path('../lib/flags.rb', __FILE__)
  load File.expand_path('../lib/flag_list.rb', __FILE__)

  Discourse::Application.routes.append do
    mount ::DiscourseNationalFlags::Engine, at: 'natflags'
  end


  ::DiscourseNationalFlags::Engine.routes.draw do
    get "/flags" => "flags#flags"
  end

add_to_serializer(:site, :national_flags, false) do
  if SiteSetting.nationalflag_enabled
    ::DiscourseNationalFlags::FlagList.list.map do |flag|
      {
        code: flag.code,
        pic: flag.pic,
        description: I18n.t("js.flags.description.#{flag.code}"),
      }
    end
  end
end

register_user_custom_field_type :nationalflag_iso, :text
allow_public_user_custom_field :nationalflag_iso
register_editable_user_custom_field :nationalflag_iso
  
  if SiteSetting.nationalflag_enabled then
  add_to_serializer(:post, :user_signature, respect_plugin_enabled: false) {
      object.user.custom_fields['nationalflag_iso']
    }
  end
end

register_asset "stylesheets/nationalflags.scss"
