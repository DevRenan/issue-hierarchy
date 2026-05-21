import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["children", "chev"]
  static values = { nodeId: Number }

  connect() {
    this.expanded = true
  }

  toggle(e) {
    if (!this.hasChildrenTarget) return
    this.expanded = !this.expanded
    this.childrenTarget.style.display = this.expanded ? "" : "none"
    if (this.hasChevTarget) {
      this.chevTarget.style.transform = this.expanded ? "rotate(0deg)" : "rotate(-90deg)"
    }
  }
}

