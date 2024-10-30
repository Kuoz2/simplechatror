SecureHeaders::Configuration.default do |config|
    config.csp = {
      default_src: ["'self'"],
  
      # Permitir los scripts necesarios y 'unsafe-inline' para scripts en línea
      script_src: [
        "'self'", 
        "https://www.gstatic.com", 
        "https://cdn.jsdelivr.net", 
        "http://www.google.com/jsapi", 
        "https://cdn.tailwindcss.com", 
        "'unsafe-inline'"
      ],
  
      # Permitir los estilos necesarios incluyendo gstatic y estilos en línea
      style_src: [
        "'self'", 
        "https://cdn.jsdelivr.net", 
        "https://www.gstatic.com", 
        "'unsafe-inline'"
      ],
    }
  
    # Otros encabezados de seguridad HTTP
    config.x_frame_options = "DENY"               # Previene ataques de clickjacking
    config.x_content_type_options = "nosniff"     # Evita que el navegador infiera el tipo de contenido
    config.x_xss_protection = "1; mode=block"     # Protege contra ataques XSS
  end