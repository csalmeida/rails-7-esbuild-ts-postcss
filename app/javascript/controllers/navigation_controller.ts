import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  open!: boolean
  readonly listTarget!: HTMLElement

  static targets: Array<string> = [ "button", "list" ];

  entering_classes: Array<string> = ["ease-out", "duration-200", "opacity-100", "scale-100"];
  close_classes: Array<string> = ["ease-in", "duration-75", "transform", "opacity-0", "scale-95"];

  initialize() {
    this.open = false;
    this.listTarget.classList.add("transition", "transform");
    this.hide();
  }

  toggle() {
    if (this.open) {
      this.hide();
    } else {
      this.reveal();
    }

    this.open = !this.open
  }

  reveal() {
    this.listTarget.classList.remove(...this.close_classes);
    this.listTarget.classList.add(...this.entering_classes);
  }

  hide() {
    this.listTarget.classList.remove(...this.entering_classes);
    this.listTarget.classList.add(...this.close_classes);
  }
}
