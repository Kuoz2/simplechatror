Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.script_src :self, :unsafe_inline,:unsafe_eval,
      "https://cdn.skypack.dev",  
      "https://cdn.tailwindcss.com",
      "https://code.jquery.com",
      "https://cdn.datatables.net",
      "https://www.gstatic.com",
      "https://www.google.com"    
    policy.style_src :self, :unsafe_inline,
      "https://cdn.datatables.net",
      "https://cdn.jsdelivr.net",
      "https://www.gstatic.com",
      "https://cdn.tailwindcss.com"
    policy.img_src :self, :data
    policy.connect_src :self
    policy.font_src :self, "https://cdn.jsdelivr.net", "https://www.gstatic.com"
    policy.frame_src :self
    policy.object_src :none
    policy.base_uri :self
    policy.form_action :self
    policy.frame_ancestors :self
    policy.child_src :self
    policy.worker_src :self    
  end

  # Habilita la CSP en el entorno de desarrollo (opcional)
  config.content_security_policy_report_only = false
end