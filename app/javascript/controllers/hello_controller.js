import { Controller } from "@hotwired/stimulus"

export default class Hello extends Controller {
  connect() {
    this.element.textContent = "Hello World!"
  }
}
