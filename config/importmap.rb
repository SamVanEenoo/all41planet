# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
# pin_all_from "app/javascript/controllers", under: "controllers"

pin "jQuery", to: "https://code.jquery.com/jquery-3.6.0.min.js", preload: true
pin "bootstrap", to: "https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js", preload: true
pin "cropperjs", to: "https://ga.jspm.io/npm:cropperjs@1.5.12/dist/cropper.js", preload: true
pin "jquery-cropper", to: "https://cdnjs.cloudflare.com/ajax/libs/jquery-cropper/1.0.1/jquery-cropper.min.js", preload: true
pin "users", to: "users.js", preload: true
