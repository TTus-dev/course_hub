import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="location"
export default class extends Controller {
  static targets = ["type", "physical", "remote"]

  connect() {
    this.toggle()
  }

  toggle() {
    const remote = this.typeTarget.value === "remote"

    this.physicalTarget.hidden = remote
    this.remoteTarget.hidden = !remote

    this.physicalTarget.querySelectorAll("input").forEach(input => {
      input.disabled = remote
    })

    this.remoteTarget.querySelectorAll("input").forEach(input => {
      input.disabled = !remote
    })
  }
}
