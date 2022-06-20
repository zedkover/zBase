fx_version 'adamant'
games {'gta5'}

client_scripts {
  "utils.lua",
  "@zCore/pmenu.lua",
  "client/*.lua",
  "locales/fr.lua"
}

shared_scripts {
  "shared.lua"
}

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  "server/*.lua",
  "locales/fr.lua"
}

ui_page 'html/ui.html'

files {
  'html/*.html',
  'html/js/*.js',
  'html/css/*.css',
  'html/locales/*.js',
  'html/img/hud/*.png',
  'html/img/*.png',
  'html/img/items/*.png',
}
