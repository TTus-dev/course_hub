import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

    connect() {
        console.log("DATE PICKER CONNECTED")
    }

    submit() {
        this.element.requestSubmit()
    }
}