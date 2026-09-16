import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    connect() {
        requestAnimationFrame(() => {
            this.element.classList.remove("-translate-y-full", "opacity-0")
        })

        setTimeout(() => {
            this.element.classList.add("opacity-0")
        }, 2500)

        setTimeout(() => {
            this.element.remove()
        }, 3000)
    }
}