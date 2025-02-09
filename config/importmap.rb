# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "https://cdn.skypack.dev/@hotwired/turbo-rails@7.0.1"
pin "@hotwired/stimulus", to: "https://cdn.skypack.dev/@hotwired/stimulus", preload: true
pin "chartkick", to: "https://cdn.jsdelivr.net/npm/chartkick/dist/chartkick.min.js"
pin "chart.js", to: "https://cdn.jsdelivr.net/npm/chart.js/dist/chart.min.js"
pin "Chart.bundle", to: "https://cdn.jsdelivr.net/npm/chart.js@2.9.4/dist/Chart.bundle.min.js"
pin "jquery", to: "https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"
pin "datatables.net-dt", to: "https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"