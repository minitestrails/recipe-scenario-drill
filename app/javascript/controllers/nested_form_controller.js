import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "container", "template" ]

  add(event) {
    event.preventDefault()
    const content = this.templateTarget.content.cloneNode(true)
    const timestamp = Date.now()

    content.querySelectorAll("input, select, textarea").forEach((element) => {
      if (element.name) {
        element.name = element.name.replace(/NEW_RECORD/g, timestamp)
      }
      if (element.id) {
        element.id = element.id.replace(/NEW_RECORD/g, timestamp)
      }
    })

    this.containerTarget.appendChild(content)
  }
}
