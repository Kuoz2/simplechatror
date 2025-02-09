// app/javascript/application.js

import "@hotwired/turbo-rails";
import "Chart.bundle";
import "chartkick";
import { Application } from "@hotwired/stimulus";
import datatables from "./controllers/datatables_controller.js";
import ToggleController from './controllers/toggle_controller.js'
import ToggleVisibility from './controllers/toggle_visibility_controller.js'
import ModalController from './controllers/modal_controller.js'
import PreviewController from './controllers/imagen_preview_controller.js'
import SearchFinishWorkController from './controllers/search_finishwork.js'
import FormController from './controllers/form_controller.js'
window.Stimulus = Application.start();
Stimulus.register("datatables", datatables);
Stimulus.register("toggle", ToggleController)
Stimulus.register("toggle-visibility", ToggleVisibility);
Stimulus.register("modal", ModalController);
Stimulus.register("preview", PreviewController);
Stimulus.register("search", SearchFinishWorkController);
Stimulus.register("form", FormController);